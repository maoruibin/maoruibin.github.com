---
layout: post
author: 咕咚
title:  "Activity 与 Window、PhoneWindow、DecorView 之间的关系简述"
description: "该篇文章主要探究 Android 中 Activity 与 Window、PhoneWindow、DecorView 之间的关系。Activity 的概念都比较熟悉，但是 Window、PhoneWindow、DecorView 这几个类并不常用，所以很多时候就忽略了它们的具体作用。其实在 Activity 的背后，它们都发挥着非常重要的作用，比如下文即将要说到的 setContentView()  原理、事件分发源头都可以看到这几个概念。"
catalog:    true
qrcode_mp:  false
shang    :  true
tags: Skills View Android Activity 
categories: tech 
---

该文主要探究 Android 中 Activity 与 Window、PhoneWindow、DecorView 之间的关系。Activity 的概念都比较熟悉，但是 Window、PhoneWindow、DecorView 这几个类并不常用，所以很多时候容易忽略了它们。其实在 Activity 的背后，它们都发挥着很重要的作用，比如下文即将要说到的 setContentView()  原理以及事件分发源头都可以看到他们。



> 版权声明：本文为 **咕咚** 原创文章，可以随意转载，但必须在明确位置注明出处。
>
> 作者博客地址: [http://gudong.site](http://gudong.site/)
>
> 本文博客地址: [http://gudong.site/2017/05/08/activity-windown-decorview.html](http://gudong.site/2017/05/08/activity-windown-decorview.html)



下面从类关系的层次上简述一下他们的关系。

## 关系简述

每一个 Activity 都持有一个 Window 对象，

```java
public class Activity extends ContextThemeWrappe{
  private Window mWindow;
}
```

但是 Window 是一个抽象类，这里 Android 为 Window 提供了唯一的实现类 PhoneWindow。也就是说 Activity 中的 window 实例就是一个 PhoneWindow 对象。

但是 PhoneWindow 终究是 Window，它并不具备多少 View 相关的能力。

不过 PhoneWindow 中持有一个 Android 中非常重要的一个 View 对象 Decor(装饰)View，它在 PhoneWindow 中的定义如下：

```java
public class PhoneWindow extends Window{
  // This is the top-level view of the window, containing the   window decor.
  private DecorView mDecor; 
}
```

查看 DecorView 继承关系得知，DecorView 继承自 FrameLayout。

```java
public class DecorView extends FrameLayout {
  
}
```

现在的关系就很明确了，每一个 Activity 持有一个 PhoneWindow 的对象，而一个 PhoneWindow 对象持有一个 DecorView 的实例，所以 Activity 中 View 相关的操作其实大都是通过 DecorView 来完成。

但是具体呢，DecorView 如何与 Activity 关联起来，下面简单分析两个案例。

## 实例讲解

这里分析两个开发中常见的与 window、decorView 相关的案例，一个是 setContentView() 作用原理，一个是 View 事件分发原理相关。

## setContentView() 与 DecorView

我们对 Activity 的 `setContentView(int resId)`方法都非常熟悉，通过该方法，Android 可以帮我们把自己写好的布局文件( resId )最终展示在 Activity 的内容区域中。但具体是怎么做到的呢？

这里其实就是通过不断的传递，把布局文件对应的资源 id 一直传递到这个 Activity 对应的 decorView 中，decorView 本身是一个 FrameLayout，当 decorView 接受到来自 Activity 传递过来的布局 id 后，通过 inflater，把布局资源 id 转换为一个 View，然后把这个布局 View 添加在自身中。

到此为止，我们就在 Activity 中最终看到了自己指定的布局样式。下面稍微看看源码中的逻辑流转。从 MainActivity 的 onCreate 方法开始

MainActivity

```java
@Override
protected void onCreate(Bundle savedInstanceState) {
  super.onCreate(savedInstanceState);
  setContentView(R.layout.activity_main);
}
```

Activity

```java
public void setContentView(@LayoutRes int layoutResID) {
  getWindow().setContentView(layoutResID);
  initWindowDecorActionBar();
}
```

这里可以看到，Activity 的 setContentView 方法紧接着又调用的 Window setContentView 方法，从上面的描述可知，这里的 window 其实就是 PhoneWindow，所以查看 PhoneWindow 的 setContentView 方法实现。

PhoneWindow

```java
@Override    
public void setContentView(int layoutResID) {
  if (mContentParent == null) {
    //初始化 id 为 android.R.id.content 的根布局，将其赋值给 mContentParent
    installDecor();
  } else {
    mContentParent.removeAllViews();
  }

  //把 Activity 中指定的布局 id 最终 inflate 到 mContentParent 中
  mLayoutInflater.inflate(layoutResID, mContentParent);

  final Callback cb = getCallback();
  if (cb != null && !isDestroyed()) {
    cb.onContentChanged();
  }
}
```

这个方法就是最终发生作用的地方，执行完该方法后，从 Activity 传递而来的布局资源 id 最终就会添加到 decorView 中。这里的 installDecor  方法很重要，通过该方法做了很多初始化相关的操作，这里不展开，有兴趣可以自己看看。

## 事件分发与 DecorView

都知道在一个界面中，如果发生触摸点击事件，事件分发的源头在 Activity 的 `dispatchTouchEvent`方法中，事件会从这里开发向下分发，然后分发到页面中具体布局 View 中，不断递归调用 ViewGroup / View 的 dispatchTouchEvent 方法，如果在递归过程中，和事件分发相关的三个方法 dispatchTouchEvent、onInterceptTouchEvent、onTouchEvent 都返回了 false 那么事件最终会执行到 Activity 的 onTouchEvent 方法中，那么表示一次事件分发结束。如果根据这个流程画出一个流程图，就可以看到一个 U 形图。关于事件分发的细节有很多，这里不展开了，具体可以参考我收集的[最佳文章](https://github.com/maoruibin/GreatArticles)。

但是 Activity 如何能把触摸事件从 Activity 中分发到具体的 ViewGroup / View 呢？跟上面的 setContentView 原理类似，Activity 在接受到上层派发来的事件后，会把事件传递到自己的 dispatchTouchEvent 方法中，然后Activity 会把触摸、点击事件传递给自己的 mWindow 对象，最终传递给 decorView 的 dispatchTouchEvent 方法。追踪代码如下所示

Activity

```java
public boolean dispatchTouchEvent(MotionEvent ev) {
  if (ev.getAction() == MotionEvent.ACTION_DOWN) {
    //不关心
    onUserInteraction();
  }
  //派发给 window 对象
  if (getWindow().superDispatchTouchEvent(ev)) {
    return true;
  }
  return onTouchEvent(ev);
}
```

PhoneWindow

```java
@Override
public boolean superDispatchTouchEvent(MotionEvent event) {
  return mDecor.superDispatchTouchEvent(event);
}
```

可以看到，最终的事件传递到了decorView，看 decorView 怎么处理事件

DecorView

```java
public boolean superDispatchTouchEvent(MotionEvent event) {
  return super.dispatchTouchEvent(event);
}
```

可以看到 DecorView 直接调用了 super 的 `dispatchTouchEvent`方法，也就是最终走了 ViewGroup 的 dispatchTouchEvent 方法。

从这里就可以知道了，都说 Activity 的 dispatchTouchEvent 方法是事件传递的源头（其实如果向上追应该还能追踪源头），但是不断传递事件，最终 Activity 接受到的事件还是到达了 Activity 对饮的 DecorView 中，而 DecorView 是一个 FrameLayout，所以接下来的分发规就是正常的 ViewGroup 分发逻辑了。

## 补充

关于 Activity 与 Window 之间的关系以及他们具体是怎么关联起来的，这里并没有给出具体的答案，这里面会涉及到 WindowManage 已经 IPC 相关的内容，具体可以查看《Android 开发艺术探索》的第八章。

不过这里还是从大体上简单概括一下 Activity 启动后 Window 与 View 是怎么跟 Activity 关联起来的。

Activity 的启动代码具体位于 ActivityThread 的 performLaunchActivity 方法中，如下所示：

ActivityThread#performLaunchActivity

```java
Activity activity = null;
java.lang.ClassLoader cl = r.packageInfo.getClassLoader();
//初始化 Activity 
activity = mInstrumentation.newActivity(cl, component.getClassName(), r.intent);

if (activity != null) {
  Context appContext = createBaseContextForActivity(r, activity);
  CharSequence title = r.activityInfo.loadLabel(appContext.getPackageManager());
  Configuration config = new Configuration(mCompatConfiguration);
  // 执行 attach 
  activity.attach(appContext, this, getInstrumentation(), r.token,
          r.ident, app, r.intent, r.activityInfo, title, r.parent,
                    r.embeddedID, r.lastNonConfigurationInstances, config,
                    r.voiceInteractor);
}
```

可以看到 ActivityThread 通过类加载的方式实例化 Activity 完毕后，会调用 Activity 的 attach 方法。然后在 Activity 的 attach 方法中初始化了 mWindow 对象。

```java
 final void attach(Context context, ActivityThread aThread,
            Instrumentation instr, IBinder token, int ident,
            Application application, Intent intent, ActivityInfo info,
            CharSequence title, Activity parent, String id,
            NonConfigurationInstances lastNonConfigurationInstances,
            Configuration config, String referrer, IVoiceInteractor voiceInteractor,
            Window window) {
      ...
        //实例化 window 对象  
        mWindow = new PhoneWindow(this, window);
        mWindow.setWindowControllerCallback(this);
        mWindow.setCallback(this);
        mWindow.setOnWindowDismissedCallback(this);
    ...
 }
```

这里已经可以知道，当 Activity 启动时对应的 Window 对象也已经创建好，但是在 Activity 调用 setContentView 之前，window 上没有任何 View，然后经过 setContentView，最终执行 ActivityThread 的 handlerResumeActivity 方法，然后调用 Activity 的 onResume 方法，最终调用 activity 的 makeVisible 方法后，最终才把 decorView 添加到 WindowManage，如下所示：

```java
void makeVisible() {
  if (!mWindowAdded) {
    ViewManager wm = getWindowManager();
    //添加到 WindowManage 
    wm.addView(mDecor, getWindow().getAttributes());
    mWindowAdded = true;
  }
  mDecor.setVisibility(View.VISIBLE);
}
```

## 总结

到此为止，我们应该已经大概了解了 Activity 中的一些 View 相关的逻辑是怎么跟 window 发生关系的。

其实可以看到上面两个跟 View 操作相关的分析过程中，Activity、以及 Activity 的成员变量 mWindow 什么也没干，他们拿到参数都第一时间都是外抛，最终都会抛给 mWindow 的 decorView 去做具体的逻辑。

这里可能会想，难道 Activity Window 都是傀儡吗？为什么上面的分析中，他们接受到命令后都是一个劲的外抛，自己不处理呢？他们没作用吗？我想其实这里应该是一种特意的设计策略。

作为一个 Activity，它承载了很多功能和使命，它不仅仅是为 View 操作而服务的，所以它把 View 相关的操作交给 DecorView 去完成，通过这种 “外包” 的方式使得自己不用关心 View 操作的细节，到最后其实有点管理中经常说的 “授权” 的意思。



> 本文原创发布于公众号 大侠咕咚，欢迎扫码关注更多原创文章。
> ![大侠咕咚](http://upload-images.jianshu.io/upload_images/588640-20fdcda8075edb5d.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



