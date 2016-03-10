---
layout: post
author: 咕咚
title: "Handler 解析"
description: ""
cover:  "#5FAD9C"
categories: Technology
tags: Android Hander SourceAnalysis
---
这篇文章记录自己从源码角度看 Handler 的工作原理。之前已经看过很多次 Handler 的源码，每次看的时候都能明白，但是时间久了，就很容易忘记。
这次打算记在博客里，方便以后查阅。这也是写博客的意义所在。

谈一个东西之前，首先说明白他为什么要存在。也就是它存在的意义。

### 为什么要有 Handler

在 Android 中，默认所有的代码都执行在主线程，我们已经在 Activity 中 happy 的写了很久的代码，如设置一个 Button 的颜色、
获取输入框内的文本、设置 ImageView 的图片属性等等，这些操作都很快，只要设置，我们可能就会马上看到效果，这就是我们常见的 UI 操作。完成
他们几乎都是瞬时的。

但是，在 Android 中有一些操作是很耗费时间的，比如从网络加载一个大图片。因为要建立连接，请求服务端，解析数据等等的操作，所以完成这个操作不是一下两下就能完成的。

试想，如果这个操作也发生在主线程，由于线程同一时间只能执行一个操作，所以在请求网络图片的过程中，主线程不能做一些其他的更新 UI 相关的操作，现在我们只会看到我们的界面卡住了，因为我们的主线程被耗时操作卡住了。

这种卡主的状态直到请求成功，如果这样也还好，卡就卡下吧，忍忍也就算了，但是不幸的是， Android 有一个规定，

    在主线程完成一个操作的时间不能超过5秒，否则 Android 系统就会给用户弹出一个 ANR 的奔溃对话框。


所以，作为开发者，你一定不希望这样的事发生在你的 App 里，所以我们一定要避免把一个耗时可能超过5秒的操作放在主线程。那我们怎么才能做到呢？

其实目前已经有很多方法可以做到这一点，用 Thread + Handler 的组合或者使用 AsyncTask，当然如果你知道 RxJava 的话，用 RxJava 也是相当
不错的选择。上述三种方式都可实现。

作为自己今天的研究，我主要说 Handler 。

### 使用

由于主线程不能做耗时操作，所以可以在主线程中建立一个子线程，把耗时操作放在子线程完成，这样不就能避开 Android 系统的 ANR 规则了吗？

是的，所以我们可以在主线程 new 一个子线程，让他开启工作

    private void executeTask(){
      new Thread(new Runnable() {
          @Override
          public void run() {
              try {
                  Bitmap bitmap = loadImg("http://blog.happyhls.me/wp-content/uploads/2015/12/fresco-og-image-1024x362.png");
              } catch (IOException e) {
                  e.printStackTrace();
                  mHandler.sendMessage(mHandler.obtainMessage(-1,e.getMessage()));
              }
          }
      }).start();
    }

如上所示，loadImg() 就是一个耗时操作，可以猜想的到，它里面都发生了什么。

他肯定在里面发送了网络请求，获取到了对应的图片数据，然后还把数据解析成 Bitmap，这个就是一个标准的网络请求操作。

他们都发生在子线程，然后，子线程气喘吁吁的回来，带着 Bitmap 回来了，此时我们很容易的想到，赶紧把这个从服务端解析到 bitmap 通过 ImageView
的 setImageResource() 方法设置到 ImageView 上啊，这样我们就可以看到图像了。

此时当你调用上面的方法后，你的应用又崩了。因为此时的 setImageResource() 方法调用发生在子线程，同时，这个方法属于更新界面 UI
的操作，而 Android 系统不允许我们的代码在子线程中去更新 UI，更新 UI 的操作只能发生在主线程，so ~ 我们的代码执行到 setImageResource 这里的时候就崩溃了。

你不禁想说，Android 也太麻烦了，这么多规则，但是正所谓『无规矩，不成方圆』。有规矩总是好的，况且他也不是只定规矩，不给 API。

既然有问题，Android 就提供了一整套的解决方案。

既然子线程不能更新 UI ，那么你就需要在 Android 规定的主线程中区更新 UI。但是此时我就在子线程，叫我怎么去主线程啊！

Handler 来了~

### Handler 用法

`既然要在主线程中处理 UI ，那么你应该先在主线程里去定义好你的 Handler 。`

为什么要这么做，后面会在 Handler 机制中讲解，你不信可以把 Handler 的实例化过程放在子线程中完成，你一定还会回来的！

此时只要在子线程中去调用 handler 的 sendMessage(msg,obj) 方法，你就可以把自己的逻辑，或者程序流给甩到主线程(暂且让我们这么形容吧~)。


    private void executeTask(){
         new Thread(new Runnable() {
             @Override
             public void run() {
                  // 子线程

                  //............. 耗时操作 ................... //

                  Bitmap bitmap = loadImg("http://i.imgur.com/DvpvklR.png");

                  //............. 耗时操作 ................... //

                  Message msg = new Message();
                  msg.what = 1;
                  msg.obj = bitmap;
                  mHandler.sendMessage(msg);
             }
         }).start();
     }

上面可以看到，在子线程里，在执行完耗时操作，得到 bitmap 后，我们简单封装了一个 msg 对象，我们就把这个 msg
通过 mHandler 的 sendMessage 方法，甩到了主线程，主线程中 mHandler 的 handMessage() 方法会处理被甩过来的 msg 对象；
如下所示：

    public void handleMessage(Message msg) {
          super.handleMessage(msg);
          switch (msg.what){
              case 1:
                  Bitmap bitmap = (Bitmap) msg.obj;
                  imageView.setImageBitmap(bitmap);
                  break;
              case -1:
                  Toast.makeText(MainActivity.this, "msg "+msg.obj.toString(), Toast.LENGTH_SHORT).show();
                  break;
          }
      }

这里你可能就要问了，为什么在上面的子线程中调用了

    mHandler.sendMessage(msg);

后，msg 就能被甩到主线程中去呢，你说能就能吗？证据在哪里？

其实通过运行代码，我们发现这样确实没问题了，我们在上面的 handlerMessage 方法中的 case 1 中获得了 对应 bitmap,而且
通过调用 setImageBitmap() 方法，我们确实也看到了实际的图片效果。

这就是证据啊，有图有真相，msg 就是被甩到主线程了，否则你怎么看到的图像。

话虽这样说，现象也确实证明了上面说的，但是为什么简单调用了 sendMessage() 方法后，msg 就到了 主线程中呢？背后的具体逻辑到底
是什么呢？

下面具体带你进入 Handler 的背后。其实不是带你进入，同时也是带我进入，我虽然看过好多次，但是老是忘记，这次就通过博客的方式记录下。

以备以后再次忘记，哈哈~

### Handler 机制

终于写完了上面的前言，下面我该再读一遍 Handler 的源码了，其实讲 Handler 内部机制的博客已经很多了，但是自己还是要在看一遍，源码是最好的资料。
