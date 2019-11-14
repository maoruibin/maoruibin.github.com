---
layout: post
author: 咕咚
title: "Android 过度绘制介绍"
description: "Android 中的过度绘制是指同一个像素被绘制多次，从绘制性能角度讲，同一像素点被绘制的次数当然越少越好，这样有利于减轻 GPU 的工作压力，事实上，在具体开发过程中，不可避免的可能会出现过度绘制，这里，Android 系统本身在开发者选项里已经提供了一个选项开关 Debug GPU overdraw(调试 GPU 过度绘制)，用于检测 App 的过度绘制，只要打开这个开关，App 界面就会在不同的界面区域根据像素的绘制次数显示出不同的颜色，下面说说这几种颜色。"
cover-color: "zzz"
catalog:    true
tags: Performance
categories: tech 
---
Android 中的过度绘制是指同一个像素被绘制多次，从绘制性能角度讲，同一像素点被绘制的次数当然越少越好，这样有利于减轻 GPU 的工作压力，事实上，在具体开发过程中，不可避免的可能会出现过度绘制，这里，Android 系统本身在开发者选项里已经提供了一个选项开关 Debug GPU overdraw(调试 GPU 过度绘制)，用于检测 App 的过度绘制，只要打开这个开关，App 界面就会在不同的界面区域根据像素的绘制次数显示出不同的颜色，下面说说这几种颜色。

关于过度绘制，也可以去查看官方的相关说明

[Debug GPU Overdraw Walkthrough](http://developer.android.com/intl/zh-cn/tools/performance/debug-gpu-overdraw/index.html)

### 颜色说明

如果同一个像素点被绘制了两次，意味着过度绘制了一次，此时显示蓝色，大片的蓝色是一种比较理想的状态。

如果同一个像素点被了绘制三次，意味着过度绘制了二次，此时显示绿色，如果界面中中等部分的绿色是可以接受的。

如果同一个像素点被绘制了四次，意味着过度绘制了三次，此时显示浅红色，如果界面中有小范围的红色也是可以接受的。

如果同一个像素点被了绘制五次或者更多（这个绘制的有点过分了啊！），意味着过度绘制了四次，此时显示暗红(GPU 发烫时的颜色)，
`This is wrong. Fix it.`

下面是一副官方关于颜色说明的图片。

<img src="/assets/over_draw_color_1.png" style="width: 50%;margin: auto;"><br>


`Note:` 如果只被绘制了一次，那么不显示任何指示颜色，即透明。

### 实例

上面说了几种不同状态对应的颜色，下面结合代码，我们看看在 App 中过度绘制具体如何表现。

新建应用 OverdrawDemo ，没有任何逻辑代码，直接看 Layout 文件，如下所示

    <?xml version="1.0" encoding="utf-8"?>
    <LinearLayout
        xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:tools="http://schemas.android.com/tools"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="vertical"
        tools:context="me.gudong.overdrawdemo.MainActivity">

    </LinearLayout>

然后打开 开发者选项的过度绘制选项，效果如下，

<img src="/assets/over_draw_color_2.png" style="width: 50%;margin: auto;"><br>

请先忽略 Toolbar 相关的颜色。这里可以看到在内容区域，是没有过度绘制的指示颜色，因为这片区域确实只被绘制了一次。

此时试想一下，如果为根布局的 LinearLayout 设置背景色，

    android:background=“#f4f4f4"

此时的界面会是怎样

<img src="/assets/over_draw_color_3.png" style="width: 50%;margin: auto;"><br>

因为这个 Activity 默认已经用主题指定背景绘制了一次内容区域(DecorView)，此时在绘制 LinearLayout 时，因为指定 `android:background=“#f4f4f4"`的缘故，这片区域的
 像素点必然会被绘制两次，所以此时的内容区域就会显示为蓝色。

同样的道理，绿色、浅红色、暗红色都是根据同一像素点绘制次数的不同，而显示出来。

### 为什么要研究过度绘制

对一个 App 来说，它运行时要不停的根据用户的操作去绘制不同的界面，绘制界面主要由 GPU 控制，如果一个界面过度绘制比较严重，大部分界面区域都被
绘制了3、4次甚至更多，那么就会浪费掉 GPU 的很多性能，这对于一个追求有良好体验 App 的开发者肯定是不允许的。

尽管大部分情况下，App 的过度绘制不可避免，但是在开发中，我们还是应该尽可能去减少过度绘制。

从一定程度上，减少过度绘制会有利于提高 App 的流畅度。目前我们用到的主流 App 都有过度绘制的优化，包括微博微信，他们的首页在过度绘制方面做的都很不错，
但是，也有很多 App 在这方面不够重视亦或者是优化力度不大，如下图对比了一些优化的比较好的 App 和一些没有优化的或者优化不够出色的 App。

<img src="/assets/over_draw_good_one.png" style="width: 50%;margin: auto;float:left;">
<img src="/assets/over_draw_bad_one.png" style="width: 50%;margin: auto;float:right;">

<br>
<br>
<p style="text-align:center">微信 VS 回家吃饭</p>
<br>

<img src="/assets/over_draw_good_two.png" style="width: 50%;margin: auto;float:left;">
<img src="/assets/over_draw_bad_two.png" style="width: 50%;margin: auto;float:right;">
<br>
<br>
<p style="text-align:center">微博 VS Keep</p>
<br>

### 避免过度绘制的 Tips
既然过度绘制是不好的，那么我们在开发中就应该尽量去减少过渡绘制，这里结合自己网上看到的一些优化 tip ,整理一下。

1、对于我们开发中的用到的 View ，如果对他设置背景颜色没有意义的，那么我们就应该不要随便去给他设置背景色。

待补充...


### 参考文章

[Debug GPU Overdraw Walkthrough](http://developer.android.com/intl/zh-cn/tools/performance/debug-gpu-overdraw/index.html)

[Android性能优化之如何避免Overdraw](http://www.jianshu.com/p/145fc61011cd)
