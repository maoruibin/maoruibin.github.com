---
layout: post
author: 咕咚
title:  "LeakCanary 工作原理浅析"
description: "LeakCanary 是 Square 公司为 Android 开发者提供的用于在开发期检测内存泄漏的神器，本文简单分析一下LeakCanary 具体的检测原理。"
catalog:    true
qrcode_mp:  false
tags: Skills View Android Activity 
categories: tech 
---

> 版权声明：本文为 **咕咚** 原创文章，可以随意转载，但必须在明确位置注明出处。
>
> 作者博客地址: [http://gudong.site](http://gudong.site/)
>
> 本文博客地址: [http://gudong.site/2017/05/15/leakcanary-theory.html](http://gudong.site/2017/05/15/leakcanary-theory.html)

LeakCanary 是 Square 公司为 Android 开发者提供的用于在开发期检测内存泄漏的神器，本文简单分析一下LeakCanary 具体的检测原理。通过本文你将会收获：

- Application.ActivityLifecycleCallbacks （应用中所有 Activity 生命周期检测）
- WeakReference 的另一个构造方法

## 原理分析

[LeakCanary](https://github.com/square/leakcanary) 在 Application 中安装完成后，会注册对应用内所有 Activity 生命周期的监听，具体监听的原理在于 Application 的 `registerActivityLifecycleCallbacks` 方法，该方法可以对应用内所有 Activity 的生命周期做监听。那具体在什么地方注册了对应的监听呢？追踪发现具体在：

*#*ActivityRefWatcher#watchActivities

```java
public void watchActivities() {
  // Make sure you don't get installed twice.
  stopWatchingActivities();
  //注册 Activity 生命周期监听
      application.registerActivityLifecycleCallbacks(lifecycleCallbacks);
}
```

这里的 lifecycleCallbacks 是一个监听的简单实现，但是这个实现只对 Activity 的销毁回调 onDestory 做了监听处理，如下所示：

```java
private final Application.ActivityLifecycleCallbacks lifecycleCallbacks =
  new Application.ActivityLifecycleCallbacks() {
  @Override public void onActivityCreated(Activity activity, Bundle savedInstanceState) {
  }

  @Override public void onActivityStarted(Activity activity) {
  }

  @Override public void onActivityResumed(Activity activity) {
  }

  @Override public void onActivityPaused(Activity activity) {
  }

  @Override public void onActivityStopped(Activity activity) {
  }

  @Override public void onActivitySaveInstanceState(Activity activity, Bundle outState) {
  }

  @Override public void onActivityDestroyed(Activity activity) {
    ActivityRefWatcher.this.onActivityDestroyed(activity);
  }
};
```

接着看 `onActivityDestroyed` 方法：

```java
void onActivityDestroyed(Activity activity) {
    refWatcher.watch(activity);
}
```

```java
public void watch(Object watchedReference) {
    watch(watchedReference, "");
}
//存放被 GC 后对象队列
ReferenceQueue queue = new ReferenceQueue<>();

public void watch(Object watchedReference, String referenceName) {
  	// .....
    final KeyedWeakReference reference = 
      new KeyedWeakReference(watchedReference, key, referenceName, queue);
    // .....
}
```

这里会把检测到的 activity 实例关联包装为一个自定义的弱引用（KeyedWeakReference），但是这里在指定弱引用时，LeakCanary 同时还为这个弱引用指定了一个 ReferenceQueue 队列。

这个队列很重要，它是 WeakReference 的第二个构造参数，下面是 ReferenceQueue 的文档介绍

> Reference queues, to which registered reference objects are appended by the garbage collector after the appropriate reachability changes are detected.

该队列的具体作用就是当发生 GC 后，WeakReference 所持有的对象如果被回收就会进入该队列，所以只要在 activity onDestory 时，把 Activity 对象绑定在 WeakReference 中，然后手动执行一次 GC，然后观察 ReferenceQueue 中是不是包含对应的 Activity 对象，如果不包含，说明 Activity 被强引用，也就是发生了内存泄漏。

接着 LeakCanary 会使用 Square 开源库 [haha](https://github.com/square/haha) 来分析Android heap dump文件，并把最终结果通过通知的方式显示在通知栏。

这就是 LeakCanary 工作的大致原理。



> 本文原创发布于公众号 大侠咕咚，欢迎扫码关注更多原创文章。
> ![大侠咕咚](http://upload-images.jianshu.io/upload_images/588640-20fdcda8075edb5d.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



