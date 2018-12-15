---
layout: post
author: 咕咚
title: "Handler 之 初识及简单应用"
description: ""
cover-color:  "#007d65"
header-mask: 0.3
catalog:    true
tags: Handler Usage 
categories: blog 
---
这篇文章主要讲解和记录自己对 Handler 的理解。因为一开始接触 Android 就接触到了 Handler，所以对 handler 的了解应该比较多，加上项目中在消息传递以及异步控制方面都要用到 Handler。自己也不止一遍的看过 Handler 源码，不过每次看的时候都能明白，但是时间久了，就很容易忘记。所以这次就有了这个 Handler 系列。从 Handler 的使用场景，到具体使用再到源码解析，自己重新再走一遍，同时通过博客记录下来，方便以后查阅。我想，这也是写博客的意义所在。

谈一个东西之前，首先说明白他为什么要存在。也就是它存在的意义。

## 为什么要有 Handler

在 Android 中，默认所有的代码都执行在主线程，我们已经在 Activity 中 happy 的写了很久的代码，如设置一个 Button 的颜色、
获取输入框内的文本、设置 ImageView 的图片属性等等，这些操作执行起来都很快，只要设置，我们可能就会马上看到效果，这就是我们常见的 UI 操作。完成
他们几乎都是瞬时的。

但是，在 Android 中有一些操作是很耗费时间的，比如从网络加载一个大图片。因为要建立连接，请求服务端，解析数据等等的操作，所以完成这样的操作，就不是一下两下能做到的。

试想，这个操作发生在主线程，由于线程同一时间只能执行一个操作，所以在请求网络图片的过程中，主线程不能做一些其他的更新 UI 相关的操作，所以我们现在能看到的就是，界面被卡住了，原因已经很清楚，主线程被耗时操作阻塞了。这种卡住的状态直到请求成功。

这里，卡主状态首先不是一种好的用户体验，与此同时， Android 也有一个相关的规定，在主线程完成一个操作的时间不能超过5秒，否则 Android 系统就会给用户弹出一个 ANR 的奔溃对话框。

下面是从官方文章中摘抄的一段

    In Android, application responsiveness is monitored by the Activity Manager and Window Manager system services. Android will display the ANR dialog for a particular application when it detects one of the following conditions:
    No response to an input event (such as key press or screen touch events) within 5 seconds.
    A BroadcastReceiver hasn't finished executing within 10 seconds.
这里需要说明的一点，在 Android 4.0 之后，系统已经不允许在 UI 线程访问网络了，以前只是 ANR，4.0 之后就直接 FC 了。

所以，作为开发者，你一定不希望这样的事发生在你的 App 里，所以我们一定要避免把一个耗时可能超过5秒的操作放在主线程，那怎么才能做到呢？

其实目前已经有很多方法可以做到这一点，用 Thread + Handler 的组合或者使用 AsyncTask，当然如果你知道 RxJava 的话，用 RxJava 也是相当不错的选择。上述三种方式都可实现。

官方也已经提供了一个指南，用于介绍如何避免这种问题，他用到了 AsyncTask，原文 [Keeping Your App Responsive](http://developer.android.com/intl/ru/training/articles/perf-anr.html)，可以一看。

作为自己今天的研究，我主要说 Handler。

## 使用

由于主线程不能做耗时操作，所以可以在主线程中建立一个子线程，把耗时操作放在子线程完成，这样不就能避开 Android 系统的 ANR 规则了吗？

是的，所以我们可以在主线程 new 一个子线程，让它开启工作，像下面这样

```java
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
```

如上所示，loadImg() 就是一个耗时操作，可以猜想的到，它里面都发生了什么。

首先发送了网络请求，接着获取到对应的图片数据，然后还把数据解析成 Bitmap，恩恩，这是一个标准的网络请求操作。代码不贴了。

恩，回到正题，你不是很耗时吗？我把你放到一个子线程中去执行，随你怎么耗时，你都不会影响我主线程中的 UI 更新操作。

但是问题来了，子线程 跨过山河大海，飘过远洋高山，终于气喘吁吁的回来了，手里还拿着 bitmap。

此时，我们很容易的想到，赶紧把这个从服务端解析到的 bitmap 通过 ImageView
的 setImageBitmap() 方法设置到 ImageView 上啊，这样我们就可以看到图像了。

此时当你调用上面的方法后，你的应用又崩了。因为此时的 setImageBitmap() 方法调用发生在子线程，同时，这个方法属于更新界面 UI 的操作，而 Android 系统不允许我们的代码在子线程中去更新 UI，更新 UI 的操作只能发生在主线程，so ~ 我们的代码执行到 setImageResource 这里的时候就崩溃了。

    Only the original thread that created a view hierarchy can touch its views.
    at android.view.ViewRootImpl.checkThread(ViewRootImpl.java:6581)
    at android.view.ViewRootImpl.requestLayout(ViewRootImpl.java:924)
奔溃提示如上所示，注意中间那句提示，说的很明白，简单翻译一下

    Only the original thread that created a view hierarchy can touch its views.

    只有创建了这个 view 树的线程才可以去 touch(泛指操作)这个 View

因为 Activity 的 view 层次树是在主线程完成初始化的，所以对所有依附于这个层次树的 view ,你要是后续想要 touch 它，就一定要在主线程中 touch，不能挪到其他子线程中去 touch。

关于上面说到的， View 层次树的创建以及初始化是在主线程中完成这一点，一些人可能怀疑。这里也不具体深挖代码，简单分析下。

一般的，我们在 onCreate 中调用 setContent() 方法就可以完成布局的设置和加载，如下所示。

      setContentView(R.layout.activity_handler);

很明显，setContent() 是在主线程中调用完成的，这里如果深究 setContent(),你会发现是 PhoneWindow 最终执行了相关的逻辑，而最终通过 Window 的一系列操作，这个 Activity 对应的 View 层次树也就创建成功。同时，这个 Activity 中的所有 view 都将依附于这个层次树。

我们平时可能看过很多这样的结论，『Android 中不允许在子线程中更新 UI』,其实归根结底是这个原因。


说道这里，你不禁想说，Android 也太麻烦了，这么多规则，但是正所谓『无规矩，不成方圆』。有规矩总是好的，况且他也不是只定规矩，不给 API。

既然有问题，Android 就提供了一整套的解决方案。

既然子线程不能更新 UI ，那么就只能去主线程更新，但是现在的程序流正在子线程中，我们要怎么才可以把当前的代码逻辑切换到主线程中去?从而达到更新 UI 的目的。

Handler 来了~

## Handler 用法

`既然要在主线程中处理 UI ，那么你应该先在主线程里去定义好你的 Handler 。`

此时只要在子线程中去调用 handler 的 sendMessage(msg,obj) 方法，你就可以把自己的逻辑，或者程序流给甩到主线程(暂且让我们这么形容吧~)。

```java
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
```

上面可以看到，在子线程里，在执行完耗时操作，得到 bitmap 后，我们简单封装了一个 msg 对象，我们就把这个 msg 通过 mHandler 的 sendMessage 方法，甩到了主线程，主线程中 mHandler 的 handMessage() 方法会处理被甩过来的 msg 对象；
如下所示：

```java
private Handler mHandler = new Handler(){
    @Override
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
};
```

`注意，这里我把它定义成了一个 Activity 的成员变量，它是在主线程中创建完成的。`

这里你可能就要问了，为什么在上面的子线程中调用了

    mHandler.sendMessage(msg);

后，msg 就能被甩到主线程中去呢，你说能就能吗？证据在哪里？

其实通过运行代码，我们发现这样确实没问题了，我们在上面的 handlerMessage 方法中的 case 1 中获得了 对应 bitmap,而且
通过调用 setImageBitmap() 方法，我们确实也看到了实际的图片效果。

这就是证据啊，有图有真相，msg 就是被甩到主线程了，否则你怎么看到的图像。

话虽这样说，现象也确实证明了上面说的，但是为什么简单调用了 sendMessage() 方法后，msg 就到了 主线程中呢？背后的具体逻辑到底是什么呢？

下面具体带你进入 Handler 的背后。其实不是带你进入，同时也是带我进入，我虽然看过好多次，但是老是忘记，这次就通过博客的方式记录下。

以备以后再次忘记，哈哈~

具体可以看下一遍文章 [Handler 之 源码解析](/2016/03/10/handler_analysis_two.html)
