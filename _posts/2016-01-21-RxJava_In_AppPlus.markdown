---
layout: post
author: 咕咚
title: "RxJava 在 AppPlus 中的应用"
description: ""
cover-color: "zzz"
catalog:    true
tags: RxJava App 
categories: tech 
---
RxJava 已经出来很长一段时间了，国内也已经有很多公司在使用，与此同时，有不少优秀的开发者也不断的在开源社区分享自己对 RxJava
的使用理解，而且这个过程中也产出了不少优秀的 RxJava 资料。自己通过这些资料以及一些开源项目也在不断的学习 RxJava，
从一开始的 GankDaily 项目中蹒跚学步，到 AppPlus 中的大量实战，自己对 RxJava 的应用也变得熟练了起来，
这篇文章结合自己的实践，简单说说 RxJava 以及它在 AppPlus 这个项目中的应用。

### 前言

先说一些与技术无关的内容。

其实关于 RxJava 的使用介绍文档，国内已经有很多非常优秀的文章，比如扔物线的 [给 Android 开发者的 RxJava 详解](http://gank.io/post/560e15be2dca930e00da1083)
以及 hi大头鬼hi 的[深入浅出RxJava (译文)](http://blog.csdn.net/lzyzsd/article/details/41833541)系列文章，都是非常不错的文章，自己把上面的文章至少读了两遍以上，
从中收获颇多，而且文章中已经把 RxJava 的很多要点写的很清楚了，尤其是扔物线的那篇。

所以，如果想了解 RxJava 使用方法，推荐直接去看上面两位的博文，这篇文章主要是记录自己学习过程中的一些感悟、以及自己在 [AppPlus](https://github.com/maoruibin/AppPlus) 这个项目中的实践。

关于自己为什么要写这篇，主要是因为在看了别人的文章后，觉得有必要记录一下自己的理解，毕竟，别人的文章是别人的理解，是人家自己的学习记录以及思考。
很多知识点只有经过自己的思考、应用、再思考、再理解才会变成自己的知识，
当然不排除那种只看一遍就能领会 RxJava 核心思想的牛人，反正自己不是，纸上得来终觉浅，所以自己在读完了上面的文章后把 RxJava 应用到了自己的项目
[AppPlus](https://github.com/maoruibin/AppPlus) 中，并且决定在这里记录一些自己对 RxJava 的一些理解，用于加深对 RxJava 的认识理解。

### 为什么要有 RxJava

RxJava 的核心在于 异步。他的出现主要方便简化原来复杂的异步逻辑处理，下面是扔物线举出的一个实例，一个数组中含有多个图片本地路径，现在要把他们显示在
一 ImageView 上，这是一个典型的异步过程。用传统的方式

    new Thread() {
        @Override
        public void run() {
            super.run();
            for (File folder : folders) {
                File[] files = folder.listFiles();
                for (File file : files) {
                    if (file.getName().endsWith(".png")) {
                        final Bitmap bitmap = getBitmapFromFile(file);
                        getActivity().runOnUiThread(new Runnable() {
                            @Override
                            public void run() {
                                imageCollectorView.addImage(bitmap);
                            }
                        });
                    }
                }
            }
        }
    }.start();

使用 RxJava 的方式

    Observable.from(folders)
        .flatMap(new Func1<File, Observable<File>>() {
            @Override
            public Observable<File> call(File file) {
                return Observable.from(file.listFiles());
            }
        })
        .filter(new Func1<File, Boolean>() {
            @Override
            public Boolean call(File file) {
                return file.getName().endsWith(".png");
            }
        })
        .map(new Func1<File, Bitmap>() {
            @Override
            public Bitmap call(File file) {
                return getBitmapFromFile(file);
            }
        })
        .subscribeOn(Schedulers.io())
        .observeOn(AndroidSchedulers.mainThread())
        .subscribe(new Action1<Bitmap>() {
            @Override
            public void call(Bitmap bitmap) {
                imageCollectorView.addImage(bitmap);
            }
        });

使用 RxJava 后的好处是程序结构变的清晰了，整个实现逻辑是流式风格，特别适合阅读，可以显著的提升代码的阅读性。
如果整个团队都使用 RxJava ,那么后续维护成本就会降低写，因为代码的阅读性得到了提高。

有种面向过程编程的感觉啊~

### RxJava 原理介绍

RxJava 的异步实现主要是通过一种可扩展的观察者模式得到的。RxJava 有四个基本概念：Observable (可观察者，即被观察者)、 Observer (观察者)、 subscribe (订阅)、事件。

`被观察者`(Observable) 发出 `事件`(Event) `观察者`(Observer) `订阅`(Subscribe)事件，当`被观察者`发出事件，观察者则会接受消息事件。


### 简单使用

这里忽略如何引入 RxJava 的方式，具体可去 [RxJava](https://github.com/ReactiveX/RxJava) 开源站点去获取。  

首先来看 AppPlus 中的一个应用场景，在首页，我们需要查询最近运行的程序列表，这很明显一个异步过程，符合 RxJava 的应用场景，
我们在工作线程去获取数据，获取数据完毕后，回到主线程完成界面更新。

整个过程中， `被观察者`是一个抽象的数据获取过程，而`观察者`则是界面更新这个操作，在实际应用中，大多数情况下
被观察者和观察者都是这种抽象的概念。

下面首先定义一个观察者，这段代码在 [AppListFragment](https://github.com/maoruibin/AppPlus/blob/04a177710d4914469f68860e16c7105004f82021/app/src/main/java/com/gudong/appkit/ui/fragment/AppListFragment.java#L284-L284)中。

    Subscriber<List<AppEntity>> subscriber = new Subscriber<List<AppEntity>>() {
        @Override
        public void onNext(List<AppEntity> appEntities) {
             setData(appEntities, mType);
        }

        @Override
        public void onCompleted() {
            loadingFinish();
        }

        @Override
        public void onError(Throwable throwable) {
            Log.d(tag, "Error!");
        }
    };

这个`观察者` 等待 `被观察者` 获取数据，`被观察者`获取到数据后就会自动发布事件，然后自动调用到观察者中已经定义好的
回调方法，如上所示，调用 setData() 方法去更新界面，很简单的逻辑。

那`被观察者`如何定义，如下所示

      Observable<List<AppEntity>> observable =  DataHelper.getRunningAppEntity(getActivity());

      /**
         * get the running app list info
         * @param ctx
         * @return
         */
        public static Observable<List<AppEntity>> getRunningAppEntity(final Context ctx) {
            return RxUtil.makeObservable(new Callable<List<AppEntity>>() {
                @Override
                public List<AppEntity> call() throws Exception {
                    List<ActivityManager.RunningAppProcessInfo> runningList = ProcessManager.getRunningAppProcessInfo(ctx);
                    List<AppEntity> list = new ArrayList<>();
                    for (ActivityManager.RunningAppProcessInfo processInfo : runningList) {
                        String packageName = processInfo.processName;
                        if (isNotShowSelf(ctx, packageName)) continue;
                        AppEntity entity = DataHelper.getAppByPackageName(packageName);
                        if (entity == null) continue;
                        list.add(entity);
                    }
                    return list;
                }
            });
        }

这里牵扯到另一个问题，如何让自己的异步方法返回一个 Observable 对象，具体查看另一篇不错的译文 [将数据库操作 RxJava 化的方法](http://www.devtf.cn/?p=734)

现在观察者与被观察者都已经建立好了，按照之前的说法，现在只需要要通过 observable 的 subscribe 方法就可以将两者关联起来，

    observable.subscribe(subscriber);

但是这里还有一个问题，我们写惯了 Android 的异步代码，都知道这样一个道理，获取数据等耗时操作要写在
工作线程中，以防止应用 ANR ，但是数据获取成功后，要更新界面，就需要到把这个操作放到主线程中去完成，通常我们使用 Handler 就可以方便的做到上述这点，
但是使用 RxJava 后我们怎么办，现在在被观察者和观察者中都没有看到任何和线程切换的操作，默认他们都应该是在主线程中运行。

不出意外的话，执行上面的代码，程序应该会奔溃，因为获取最近运行的程序列表是一个耗时操作，把它刚在主线程明显是有问题的，那怎么办？

这里不妨设想下，如果 RxJava 可以提供两个方法，一个用来控制`被观察者`中逻辑代码的执行线程，另一个用来控制`观察者`执行的线程该多好，那对我们程序员
来说不非常方便吗，写惯了以前的 Android 代码，我们对那些代码应该放在主线程、那些代码应该放在子线程已经非常清楚，所以如果 RxJava 可以提供这样的
线程控制 API 那一定是极好的。

既然都这样设想了，RxJava 必然已经提供了这样的方法，否则我也不会设想，哈哈~下面就说说 RxJava 中的线程控制

###线程控制

RXJava 使用 subscribeOn() 和 observeOn() 两个方法来对线程进行控制

subscribeOn(): 指定 subscribe() 所发生的线程，即 Observable.OnSubscribe 被激活时所处的线程。或者叫做事件产生的线程。

observeOn(): 指定 Subscriber 所运行在的线程。或者叫做事件消费的线程。一般的我们用到的这里应该是主线程

经过这个分析，修改上面的代码，如下所示

    observable
        // 指定了获取数据的操作（被观察者）发生在 io 线程
        .subscribeOn(Schedulers.io())
        // 指定了界面更新的操作 (观察者) 发生在 mainThread
        .observeOn(AndroidSchedulers.mainThread())
        // 观察者订阅数据获取这一事件
        .subscribe(subscriber);

关于 Schedulers 内置的那几个线程可选项可查看扔物线博客 线程控制 —— Scheduler (一) 那一章节。

到此为止，使用 RxJava 完成一个异步事件订阅就完成了。           
