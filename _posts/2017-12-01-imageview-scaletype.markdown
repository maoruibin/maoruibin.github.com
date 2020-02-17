---
layout: post
author: 咕咚
title:  "ImageView 中不同 scaleType 的对比介绍"
description: "在使用 ImageView 的时候，经常需要设置它的 scaleType，但是一些时候对他们的区别总是很难把握，这次通过示例完整的了解一下不同的 scaleType 对一个 ImageView 的展示到底会有什么样的区别。"
catalog:    true
qrcode_mp:  true
shang    :  true
tags: Skills ImageView Android
categories: tech

---

> 版权声明：本文为 **咕咚** 原创文章，可以随意转载，但必须在明确位置注明出处。
>
> 个人主页: [http://gudong.site](http://gudong.site/)
>
> 文章地址: [http://gudong.site/2017/12/01/imageview-scaletype.html](http://gudong.site/2017/12/01/imageview-scaletype.html)

## 介绍
在使用 ImageView 的时候，经常需要设置它的 scaleType，但是一些时候对他们的区别总是很难把握，这次通过示例完整的了解一下不同的 scaleType 对一个 ImageView 的展示到底会有什么样的区别。

这是原图片

![](https://user-gold-cdn.xitu.io/2017/12/24/160842d6de3252f2?w=215&h=199&f=jpeg&s=12988)

可以看到，其实他有一个内部 padding 的距离。

## ImageView 布局
下面使用 ImageView 用来显示这个图片资源，然后分别使用不同的 scaleType 进行展示，布局代码如下

```xml
<ImageView
    android:layout_width="300dp"
    android:layout_height="500dp"
    android:layout_centerInParent="true"
    android:scaleType="center"
    android:src="@mipmap/ic_launcher"/>
```
这是一个宽 300dp 高 500dp 的 ImageView，现在设置 scaleType 为 center

> 说明：为了显示方便，这里设置 ImageView 的背景为灰色，下面所有截图中看到的灰色区域就是 ImageView 的区域。

### 1、scaleType="center"

scaleType 为 center 表示按照图片尺寸在给定的 ImageView 上居中显示图片，如下所示，当 ImageView 尺寸很大足够容纳图片时，图片会居中显示在 ImageView 中。

![](https://user-gold-cdn.xitu.io/2017/12/24/1608436dffcc8b0d?w=267&h=420&f=jpeg&s=4484)

但是当 ImageView 的 size 被设置的较小，如下 ImageView 的宽高被设置为 20-50 时，此时 ImageView 的 size 小于图片的大小，会发现图片依旧居中显示，但是为了居中显示，图片会被按 ImageView 的宽高比例进行缩小然后裁剪如下所示：

![](https://user-gold-cdn.xitu.io/2017/12/24/160843c917f771e2?w=268&h=416&f=jpeg&s=2451)

### 2、scaleType="centerCrop"
它会根据 ImageView 的尺寸，把目标图片按照 ImageView 的尺寸进行等比例放大或缩小然后裁剪，最终显示。

这里因为原图尺寸没有 ImageView 尺寸大，所以图片会被放大，然后最终被裁剪后显示成如下图所示的样式。

![](https://user-gold-cdn.xitu.io/2017/12/24/16084324e9e01d2e?w=270&h=462&f=jpeg&s=14533)


### 3、scaleType="centerInside"
目前跟 center 一致 ，看不出有什么区别，

![](https://user-gold-cdn.xitu.io/2017/12/24/1608436dffcc8b0d?w=267&h=420&f=jpeg&s=4484)

但是如果 ImageView 的尺寸小于图片自己的尺寸，它就会跟 center 的效果不一样了，它会自适应 ImageView 进行自适应，比如，我们将 ImageView 的尺寸特意设的特别小。
```xml
<Image
    android:layout_width="20dp"
    android:layout_height="50dp"
    android:layout_centerInParent="true"
    android:scaleType="fitCenter"
    android:src="@mipmap/ic_launcher"/>
```
然后效果如下。

![](https://user-gold-cdn.xitu.io/2017/12/24/1608437029320bea?w=375&h=523&f=jpeg&s=3511)

对比 scaleType = center 在 ImageView size 小于图片 size 的情况下, center 会把图片进行裁剪，但是 centerInside 就不会，这也是为什么叫 `inside` 的缘故吧。

### 4、scaleType="fitStart/fitEnd/fitCenter"

fit 表示图片自己会根据 ImageView 的尺寸进行自适应。

start 表示在图片靠上面，end 表示靠下边，center 表示居中

![](https://user-gold-cdn.xitu.io/2017/12/24/16084530e73482e0?w=257&h=411&f=jpeg&s=9254)

![](https://user-gold-cdn.xitu.io/2017/12/24/160843abbb957d6e?w=257&h=408&f=jpeg&s=9017)

![](https://user-gold-cdn.xitu.io/2017/12/24/160843a805a7645f?w=265&h=407&f=jpeg&s=9345)


这里区分一下 `fitCenter` 和 `centerInside`

fitCenter 会放大图片自身，然后居中显示，如上图所示。但是 centerInside 不会放大图片，还是根据图片尺寸居中显示在 ImageView 中。

![](https://user-gold-cdn.xitu.io/2017/12/24/1608436dffcc8b0d?w=267&h=420&f=jpeg&s=4484)


### 5、scaleType="matrix"
matrix 是 ImageView 默认的 scaleType, 他不改变原图的大小，从ImageView的左上角开始绘制原图，原图超过ImageView的部分作裁剪处理。
同样对比下 ImageView 在不同尺寸下的样式

- ImageView 尺寸大于图片尺寸

![](https://user-gold-cdn.xitu.io/2017/12/24/160843d005338772?w=253&h=406&f=jpeg&s=4601)

- ImageView 尺寸小于图片尺寸

![](https://user-gold-cdn.xitu.io/2017/12/24/160843d16555a5cc?w=248&h=404&f=jpeg&s=2445)

### 6、scaleType="fitXY
这中类型最好理解，不管原图的宽高比例，直接把原图按照 ImageView 的大小尺寸进行拉伸，使原图填满 ImageView，非常暴力，实际开发中用到的不多，因为很容易造成图片变形的问题。

![](https://user-gold-cdn.xitu.io/2017/12/24/160843d518ea7c16?w=249&h=416&f=jpeg&s=12073)

## 总结
结合平时的开发经验，一般主要用的 scaleType 就几种，比较多的是 center 、centerInside 以及 fitCenter, 主要掌握这几个类型的区别。
