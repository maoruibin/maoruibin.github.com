---
layout: post
author: 咕咚
title: "Handler 之 ThreadLocal 相关"
description: ""
cover-color:  "#007d65"
catalog:    true
tags: Handler
categories: tech 
---
在上一篇文章[Handler 之 源码解析](/2016/03/10/handler_analysis_two.html)中介绍 Handler 与 Looper 的关系时，半路出现了 ThreadLocal 这个类，他是什么呢，本想在 Handler 源码解析一文一起阐述了，
但是觉得这样篇幅太长，不好，况且他又是一个相对独立的概念，这里就把它单独拿出来，结合任玉刚的[Android的消息机制之ThreadLocal的工作原理](http://blog.csdn.net/singwhatiwanna/article/details/48350919)博文，为自己总结归纳下 ThreadLocal 的用处，以及他在 Handler 和 Looper 中的巧妙用法。

### ThreadLocal

其实在Handler 之 源码分析一文中，关于 Handler 有一点一直没说到。

Handler 在创建的时候必须使用当前线程的 Looper 来构造消息循环，而自己手动创建的子线程默认是没有 Looper 的，
如果在一个子线程中创建 Handler ，就必须为这个子线程创建相应的消息轮训器，否则我们就会看到一个常见的异常

    Can't create handler inside thread that has not called Looper.prepare()

那我们如何在子线程中创建一个 Looper 呢？

其实从上面的异常信息，我们已经知道了，在子线程中调用 Looper.prepare() 方法就可以为这个子线程创建一个 Looper 对象。

是抛出一个观点的时候了。

我们在主线程创建一个 Handler，这个 Handler 就需要一个和主线程绑定的消息轮询器(Looper)，如果是在一个子线程创建一个 Handler,
那么我们就需要为这个 Handler 绑定一个与子线程绑定的消息轮询器(Looper).

至于原因，应该是这样的，主线程的 handler 发送消息后，应该是主线程的 Looper 去轮询与主线程相关的那个 MessageQueue，并且处理消息，子线程中创建的 Handler 对象在发送消息时，（不论他在什么地方发送），应该是通过子线程对应的消息轮询器去轮询相应的 MessageQueue，然后处理消息。

但是现在有一个问题，如何控制 Looper 的 myLooper() 方法返回的对象是当前线程对应的 Looper 呢?

    public static @Nullable Looper myLooper() {
       return sThreadLocal.get();
    }

这就是 ThreadLocal 妙用之所在，ThreadLocal 可以在不同的线程之中互不干扰地存储并提供数据，这句话的意思很清楚。

就是说，在不同的线程中会存储不同的数据，他们互不干扰。

下面这行，摘抄自任玉刚的博客

`ThreadLocal是一个线程内部的数据存储类，通过它可以在指定的线程中存储数据，数据存储以后，只有在指定线程中可以获取到存储的数据，对于其它线程来说无法获取到数据。`

这个特性正好满足 Handler、Looper 在线程方法的特性，可以确保在主线程中调用 sThreadLocal.get(); 得到的是主线程对用的 Looper 对象，在子线程中调用得到的是子线程中对应的Looper。

上面也说了，如果我们在子线程中去实例化 Handler，必须先调用 Looper.prepare() 方法。通过这个方法，为所在的子线程绑定一个 Looper,这个
Lopper 将会在子线程中 new Handler() 时自动绑定到这个 Handler，解析来我们看看，这一切在子线程中是怎么发生的。

首先分析出错的情形，也就是直接在子线程中 new Handler() 时报错，是怎么发生的。先在子线程中创建一个 Handler

    new Thread(new Runnable() {
        @Override
        public void run() {

            Handler innerHandler = new Handler(){
                @Override
                public void handleMessage(Message msg) {
                    super.handleMessage(msg);
                }
            };

        }
    }).start();

接着看 Handler 的构造方法。

    public Handler(Callback callback, boolean async) {
          mLooper = Looper.myLooper();
          if (mLooper == null) {
              throw new RuntimeException(
                  "Can't create handler inside thread that has not called Looper.prepare()");
          }
          mQueue = mLooper.mQueue;
          mCallback = callback;
          mAsynchronous = async;
      }

当执行到 myLooper()    

    public static @Nullable Looper myLooper() {
         return sThreadLocal.get();
     }

此时的 sThreadLocal 是一个线程数据存储类，但是因为是在子线程中访问，所以它对应者子线程中的资源。

由于我们在这个子线程中没有事先对 sThreadLocal 做任何处理，没有设置任何 Looper 对象，所以此时的 myLooper() 返回值一定是 null。

接下来，我们就会看到那个一开始学 Handler 时经常看到的错误日志了。

    Can't create handler inside thread that has not called Looper.prepare()"

然后，此时出错了，按照以前的做法。根据提示，在创建 handler 之前，调用Looper.prepare() 方法，这样错误就没有了，但是先在从代码的角度观察一遍为什么这里调用一次 Looper.prepare() 就不报错了。

prepare() 源码

    public static void prepare() {
        prepare(true);
    }

    private static void prepare(boolean quitAllowed) {
        if (sThreadLocal.get() != null) {
            throw new RuntimeException("Only one Looper may be created per thread");
        }
        sThreadLocal.set(new Looper(quitAllowed));
    }

此时在方法中，首先判断 sThreadLocal.get() != null ，因为现在的调用发生在子线程，而且没有为 sThreadLocal 设置过 Looper 对象，所以此时
sThreadLocal.get() 一定是 null 的，所以会直接执行

    sThreadLocal.set(new Looper(quitAllowed));

我们看到，最终通过 prepare() 方法设置了在子线程中 sThreadLocal 的值为一个新的 Looper 对象。

那么只要设置过了 Looper 对象，下一次在 sThreadLocal 执行 get 操作时就会得到已经设置好的 Looper,这个 Looper 最终会被绑定到子线程中创建的 Handler 上面。

这里需要特别注意一点，仅仅在创建 handler 之前调用了 Looper.prepare() 并不能完事大吉，如果你想通过这个 handler 接受消息，你就一定需要在创建完毕 Handler ，执行 Looper.loop() 方法，让刚才创建的 Looper 工作起来。

否则，后续你在子线程发送消息了，但是你却在子线程的 handler 中接受不到消息，就会出现这样的问题。

所以补全上面的代码，如下所示。

    new Thread(new Runnable() {
        @Override
        public void run() {
            Looper.prepare();
            Handler innerHandler = new Handler(){
                @Override
                public void handleMessage(Message msg) {
                    super.handleMessage(msg);
                    Log.i("msg","content is "+msg.what);
                }
            };
            Looper.loop();
        }
    }).start();

这里不禁就要问了，在子线程中是这样创建 Handler 的，需要手动调用 Looper.prepare(); 以及 Looper.loop();那为什么在主线程中定义 Handler 不需要这些操作呢？

因为主线程，也就是我们经常提到的主线程，也叫UI线程，其实就是 ActivityThread，ActivityThread 被创建时就已经初始化过 Looper 了，代码如下

  public static void main(String[] args) {

      //............. 无关代码...............

      Looper.prepareMainLooper();

      Looper.loop();

      throw new RuntimeException("Main thread loop unexpectedly exited");
  }

所以在主线程中创建 handler 时，是不需要手动去创建 Looper 的，因为他们早已创建好了。
