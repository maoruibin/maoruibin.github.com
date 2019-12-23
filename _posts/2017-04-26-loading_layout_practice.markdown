---
layout: post
author: 咕咚
title:  "Android 多状态加载布局的开发 Tips"
subtitle:  "『多状态布局开发的点点滴滴』"
description: "本文将结合自己的项目开发实践，简单分享一下关于多状态 Layout 的开发实践 Tips。"
catalog:    true
qrcode_mp:  false
cover-color:  "#121a2a"
tags: Experience Skills 架构 Android 
categories: tech 
---

本文将结合自己的项目开发实践，简单分享一下关于多状态 Layout 的开发实践 Tips。

> 版权声明：本文为 **咕咚** 原创文章，可以随意转载，但必须在明确位置注明出处。
> 
> 作者博客地址: [http://gudong.site](http://gudong.site/)
>
> 本文博客地址: [http://gudong.site/2017/04/26/loading_layout_practice.html](http://gudong.site/2017/04/26/loading_layout_practice.html)

## 什么是多状态 Layout

对于大多数 App 而言，项目中都有多状态加载 View 这种需求，如下图所示。

![demo](http://7xr9gx.com1.z0.glb.clouddn.com/loading_status.png)

对应到开发中，我们通常会开发一个对应的自定义 layout 用于根据页面不同的状态来显示不同的提示 view。

在项目中，我们大多会在开发初期就把这套 layout 框架写好，然后其他人的自己的开发过程中直接使用即可。如下所示：

```java
<name.gudong.MJMultipleStatusLayout
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <ListView
        android:id="@+id/lv_activity_center"
        android:layout_width="match_parent"
        android:layout_height="match_parent" />

</name.gudong.MJMultipleStatusLayout>
```

这篇文章不讨论如何去实现这样的自定义 loading layout，Github 上[这样的 layout ](#开源方案)太多了，这里主要思考、总结在实际开发中开发这样的自定义 Layout 时应该注意那些地方。

但是为了说明方便，这里还是采用的方案简单叙述一下。

>为了后文描述方便，这里把这个多状态自定义 Layout 先称为 MultipleStatusLayout。

## 实现方案

在实现 MultipleStatusLayout  时，首先选择继承一个 ViewGroup 作为自己的父类，然后默认把内部的第一个子 View 作为 ContentView，其它各种情形下对应要显示的 layout view，根据不同的加载状态，在 MultipleStatusLayout 中通过动态 addView 去控制对应 layout 的加载显示，也可以通过 ViewStub 把不同情形的 layout 进行懒加载，然后对外提供不同的方法，方便外部调用、控制不同状态下的 layout 显示。

嗯，简单说来就是这样，原理很简单，实现起来也没什么技术难度，对于一般的开发人员只要一开始明白具体的产品逻辑和实现思路，相信花不了多少时间就可以完成这样的 MultipleStatusLayout。具体这种方式的实现可以参看一个[开源项目](https://github.com/qyxxjd/MultipleStatusView/blob/master/multiple-status-view/src/main/java/com/classic/common/MultipleStatusView.java) 的实现。

下面着重列举一下开发 MultipleStatusLayout 过程中的注意点或者要点。

## Tips 

考虑到 MultipleStatusLayout  开发完成后，会在项目中的很多页面中应用，而且很多时候是作为页面顶级父容器而存在，所以开发过程中一定要注意其性能还有稳定性，否则一旦出现问题，整个项目中应用到该 MultipleStatusLayout  的页面都会随之出现问题。

以下就从性能角度、可维护性、稳定性等方面考虑出发，列举一些开发 tip 。

### 选择最合理的父容器

首先 FrameLayout、RelativeLayout、LinearLayout 都可以作为 MultipleStatusLayout  的父类，抛开现在的应用场景不谈，都知道 RelativeLayout 在 layout 时需要 measure 两次，所以对于一个未来要在很多页面中使用的 Layout ，把 RelativeLayout 作为父类这个方案首先 pass 掉。

但是因为 MultipleStatusLayout 中显示的 view 大都需要居中显示，所以使用 RelativeLayout 相对比较容易控制居中位置，这可能是很多人选择 RelativeLayout  作为父类的初衷。这里自己可以做一下权衡。

关于 LinearLayout 和 FrameLayout，如果按照上一节提到的实现方案，其实都可以采用，不过考虑到该类 Layout 的应用场景，建议选择 FrameLayout。

因为MultipleStatusLayout 未来在大多数情况下是作为页面父容器存在的，既然是父容器，内容可能会有各种变化，这时使用 LinearLayout  这种线性布局就会在布局时显得特别局限，比如一些页面可能需要在 MultipleStatusLayout 之上显示一个 FloatActionButton 或者其他的 view，这时使用 FrameLayout 就会好做很多也会灵活很多。

### 选择最优的加载 View 方式 

如何控制这些多状态对应的 View ? 对于一般的情形，至少有两种 View 类型，一种是加载中的 loading 样式 view，一种是异常状态的 layout view，当然还可能有更多具体的情形。

不同的样式对应一个不同的布局，为了简便我们可以一次性的把所有状态对应的布局都写在一个 layout 布局里，然后可以通过控制隐藏、显示来根据不同的状态来展示不同 view，这是最直接的想法。

但是，只要多思考一步，就会发现这种方式非常不可取。因为很多时候，MultipleStatusLayout 作为一个父容器只关心自己的 ContentView，异常页面和加载页面甚至可能没有机会出现，但是现在这样做就表示，这个页面不论有没有异常或者加载逻辑，你的布局里都会存在对应的 layout 布局代码。这样在界面绘制时就会白白耗掉多余的时间。

而且这个 Layout 后续会在项目很多页面用到，所以这里的布局耗时问题放大后就显得很严重。

鉴于此，取而代之的更好的做法应该是动态去 addView，只有这个页面第一次调用 loading 或者 showError 这样的方法，我才去把对应布局加载进来，当然这里使用 ViewStub 也是一样的效果。

这里也就是说，只有调用了相应的方法，才去加载对应的 layout.

### 资源命名

其实这个问题是自己开发公用 Api 普遍面临的问题，由于开发 MultipleStatusLayout 可能会定义一些颜色资源或者背景资源，这里建议所有资源开头使用一个固定的开头，这样可以防止跟主版本中的资源重名。进而早成一些奇怪的 UI 问题或者编译问题。比如按钮的背景你可以定义为 msl_btn_normal 而不是 btn_normal，文字的颜色你可以定义为 msl_text_white 而不是 text_white。这样就可以有效避免一些资源冲突。

更多关于如何开发一个第三方库，可以查看[天之界线](https://github.com/tianzhijiexian/)的[开发第三方库最佳实践](http://www.jianshu.com/p/0aacd419cb7e)

### 提供友好的方法调用方式

既然是提供给大家使用，你就应该在方法命名上多花点心思，最好见名之意，这样大家调用时也会舒服很多。

另外对外提供 Api 时也应该保持克制。不要一下子提供出去太多的方法，不论有用没用，一下子都对外提供，这样会对后续的维护造成隐形的负担，因为提供的公用方法越多，表示你后续都要对这些方法进行维护。

最好的原则就是用到什么提供什么，不要提前设计。

另外，随着项目迭代，对外提供方法的参数可能会变得多起来，比如以前显示错误页面的方法是 

```java
void showErrorView(Stirng error) 
```

后来要增加自定义的 icon 或者点击事件响应，这时你就需要扩展方法参数，往往这种参数可能会变得很多不可收拾，这时建议使用 Build 构建模式设计，如下示例所示：

```java
showErrorView(StatusViewConfig config) 
```

调用时就可以这样调用

```java
showErrorView(new StatusViewConfig.StatusViewBuild(getContext())
                .icon(icon)
                .message(message)
                .subMessage(subMessage)
                .layoutMode(mLayoutMode)
                .withActionText(actionText, clickListener)
                .build())
```

### 良好的文档

当你开发完成后，最好趁热写一份简单明了的使用文档出来，这样大家就可以直接对照文档使用你写的库，不用去关心代码实现，直接调用 Api 就可以完成自己的业务需求，同时也省的自己去面对面跟别人讲怎么使用了。

前段时间在 V 站上看到一个问题，说你们公司使用什么样的文档管理工具？其中有一个回答言简意赅，很有意思，四个字 `口口相传`。

其实对于任何一个项目都是，有时间写点文档，梳理自己思路的同时方便别人，何乐而不为。

## 其他

这种 Layout 在项目中会随着项目的更新迭代而不断的更新，所以一开始你就应该知道，后续还要不断迭代更新，所以代码设计实现时应该留意扩展性。

另外，相关的开源方案有很多，建议一开始可以参考一些好的方案，然后结合自己项目的实际需求，来开发维护属于自己项目的一套框架。因为多状态 loading 加载提示框架大都和产品设计强相关，不具备一般的通用性。

下面列举一些自己收集到的多状态加载开源方案，方便对比。

## 开源方案

[StatefulLayout](https://github.com/gturedi/StatefulLayout)

[progress-activity](https://github.com/vlonjatg/progress-activity)

[StateLayout](https://github.com/lufficc/StateLayout)

[MultipleStatusView](https://github.com/qyxxjd/MultipleStatusView)

## 总结

同样功能的 Layout 可能在不同的业务场景下实现方式也会有很大的区别，所以不论哪种实现方式，无所谓好坏，只要适合就好。但是开发此类 Layout 要遵循的基本准则、以及要注意的点应该大都相同，希望此文可以给你一些启示帮助。

> 本文原创发布于公众号 大侠咕咚，欢迎扫码关注更多原创文章。
> ![大侠咕咚](http://upload-images.jianshu.io/upload_images/588640-20fdcda8075edb5d.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



