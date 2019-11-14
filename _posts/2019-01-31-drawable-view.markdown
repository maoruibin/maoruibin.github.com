---
layout: post
author: 咕咚
title: "Android Drawable 简析"
description: Drawable 用的很多，值得好好学习一下，之前看过很多次，但是都没有记录，这次记录之。Drawable 有很多应用场景，多多挖掘。
shang: true
qrcode_mp: true
tags: Android Drawable
categories: tech 
---

![Photo by Patrick Tomasso on Unsplash](http://upload-images.jianshu.io/upload_images/588640-f3c7beeead2d22c8.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

Drawable 是开发中经常用到的一个概念，我们经常用它去设置 View 的背景，背景可以一个颜色值，也可以是一张资源图片，还可以是一个自定义的 Drawable等等。这篇文章就简单说下 Drawable 与 View 的关系，同时结合代码，简要分析一下 Drawable 如何作用于 View。

## Drawable 介绍

官方介绍

> A Drawable is a general abstraction for "something that can be drawn." Most often you will deal with Drawable as the type of resource retrieved for drawing things to the screen; the Drawable class provides a generic API for dealing with an underlying visual resource that may take a variety of forms. Unlike a `View`, a Drawable does not have any facility to receive events or otherwise interact with the user.

简单翻译下：

> Drawable 是 “所有可绘制东西” 的一个抽象，大多数时候，我们只需要把各种不同类型的资源作为转化为 drawable，然后 View 会帮我们把它渲染到屏幕上。Drawable 类提供了一个通用 API，用于解析转化各种可视资源到 Canvas，跟 View 不一样，**Drawable 不能接受任何事件以及用户交互**。

总而言之，Drawable 就是一个可绘制东西的抽象，相比 View，它更纯粹，就是用来做绘制相关事情的，它处理不了用户交互事件，也不需要处理，所有交互相关的事都是由 View 来完成，但是背景相关的事大都可以通过 Drawable 来完成。

一般的，我们要为 View 设置背景，可通过如下几种方式：

* 通过颜色为 View 设置背景
* 通过自定义的 shape 设置背景

### 用颜色设置背景
通过 View 的 setBackgroundColor 方法可以设置颜色为 View 的背景。
```java
button.setBackgroundColor(Color.YELLOW);
```
效果如下：

![image](http://upload-images.jianshu.io/upload_images/588640-10df2a93e49cce80.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### 用自定义的 shape 设置背景

先用 xml 自定义一个圆角空心描边矩形 shape

```xml
<shape
     android:shape="rectangle">
    <corners android:radius="4dp"/>
    <solid android:color="#fff"/>
    <stroke android:color="#ef6f06" android:width="1dp"/>
</shape>
```
通过代码进行设置
```java
button.setBackgroundResource(R.drawable.bk_normal);
```

效果如下：
![image](http://upload-images.jianshu.io/upload_images/588640-3d920cfacd70e1aa.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

可以看到，给 View 设置背景 drawable 非常简单，具体通过如下的 API 实现背景设置：

* setBackgroundColor(@ColorInt int color)
* setBackgroundResource(@DrawableRes int resid)
* setBackground(Drawable background)

**但是设置的背景 Drawable 是如何在 View 上生效的**，可能很多人没去思考过这个问题，这里简单分析下。

## Drawable 如何作用于 View 

Drawable 是一个抽象类，这里通过它的的几个抽象方法就能大概猜得出 Drawable 如何作用于 View，下面是 Drawable 的几个抽象方法：

```java
public abstract void draw(@NonNull Canvas canvas);
public abstract void setAlpha(@IntRange(from=0,to=255) int alpha);
public abstract void setColorFilter(@Nullable ColorFilter colorFilter);
public abstract @PixelFormat.Opacity int getOpacity();
```

可以看到这里有一个 draw 方法，并且参数中提供了 canvas 对象。

```java
public abstract void draw(@NonNull Canvas canvas);
```

现在可以想象一下，**View 通过 setBackground 方法为自己设置了一个 drawable 对象后，而 drawable 又有一个 draw 方法，那么 View 绘制自己的背景时，直接调用 drawable 对象的的 draw 方法，这个 draw 方法需要一个 canvas 对象，这里可直接把 View 的 Canvas 对象传递过去，那么 Drawable 就可以成功的把自己的绘制内容应用到 View 之上。**

这个过程，相当于 View 把自己的背景绘制功能外包给了 Drawable 对象。

而且，这也是一种非常好的设计模式，**View 负责测量自己大小，给自己指定位置，并绘制 View 前景 ，但是把自己的背景绘制外派给了更独立的 drawable 去做，从而做到了让自己更加轻量，现在 View 就成功的把背景绘制职责分配给了自己的 drawable 对象。**

尽管上面只是想象，但事实上也确实如此。通过查看源码，在 View 中有一个私有方法 `drawBackground`，它的作用就是把 drawable 绘制在 canvas 上。
```java
/**
 * Draws the background onto the specified canvas.
 * @param canvas Canvas on which to draw the background
 */
private void drawBackground(Canvas canvas) {
	final Drawable background = mBackground;
	if (background == null) {
		return;
	}
	setBackgroundBounds();
    //省略部分代码
	final int scrollX = mScrollX;
	final int scrollY = mScrollY;
	if ((scrollX | scrollY) == 0) {
        //调用 drawable 自己的 draw 方法，从而将绘制的功能移交到 drawable 类
		background.draw(canvas);
	} else {
		canvas.translate(scrollX, scrollY);
		background.draw(canvas);
		canvas.translate(-scrollX, -scrollY);
	}
}
```

### Drawable 与 View 的关系

* View 是皮，它是一个具体的东西，看得见摸得着，因为它自己可以测量自己打消、指定自己位置，还能接受 onTouch 事件从而处理用户交互。
* Drawable 是毛，它可以不存在，因为 View 完全可以在自己的 onDraw 时机中，自己把自己绘制了，无需把绘制进行外包。
* 但是 Drawable 更专业，更独立，它提供了一整套丰富的背景 Drawable 机制，它有丰富的实现类，可以提供给 View 进行方便的背景设置，对 View 来说 drawable 提供的那些实现类开箱即用，还可以减少自己的职能，节省自己的维护开销，何乐而不为。

## 总结

Drawable 是一个抽象的概念，只要理解了它跟 View 的关系，其实 Drawable 的想象力会非常大。通过自定义 Drawable，可以在 Drawable 中完成各种绘制逻辑，自定义完成后，只需要让 View 调用 setBackground() 方法，把自定义的 Drawable 传递进去，这样就可以方便把自定义 Drawable 和 View 关联在一起。

之前写过一个转菊花的 Loading 效果，就是用自定义 Drawable 实现的，目前已开源在 github，感兴趣的去看看。

[FlowerLoading: Android loading or progress view, just like iOS IndicatorView\.](https://github.com/maoruibin/FlowerLoading)