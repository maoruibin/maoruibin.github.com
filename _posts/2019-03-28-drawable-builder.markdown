---
layout: post
author: 咕咚
title: "用 Xml 写 Shape Drawable 还是挺让人烦的..."
shang: true
qrcode_mp: true
tags: Android Drawable
categories: blog 
---

so, DrawableBuilder is comming...

该 Builder 类主要提供语义化的 API 进行快捷的 Shape 创建操作。

比如我们要对一个 View 设置一个线条背景，给定的效果如下所示：

![](https://ws3.sinaimg.cn/large/006tKfTcly1g1eumuk7isj30dg03mmwx.jpg)

首先写好 TextView 布局，代码如下所示：

```xml
    <TextView
        android:id="@+id/tvName"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:padding="6dp"
        android:gravity="center"
        android:text="咕咚来了"/>
```
接着用 xml 编写线条背景 drawable，代码如下所示：

```xml
<shape xmlns:android="http://schemas.android.com/apk/res/android" 
       android:shape="rectangle">
    <stroke android:width="1dp" android:color="#34495e"/>
</shape>
```

用 xml drawable 设置背景

```java
tvName = (TextView) findViewById(R.id.tvName);
tvName.setBackgroundResource(R.drawable.bk_line_drawable);
```
样式

![](https://ws3.sinaimg.cn/large/006tKfTcly1g1eumuk7isj30dg03mmwx.jpg)

以上是传统的设置方式，在写好布局文件后，都需要去 res 目录下再创建 drawable 文件，然后再切换回 Activity 或者布局文件进行背景设置，这就免不了我们跳来跳去的切换目录，很麻烦。

现在通过 DrawableBuilder 通过 java api 直接构造线条 drawable，如下所示：

```java
Drawable drawable = new DrawableBuilder()
  .line()
  .build();
```

```
tvName.setBackground(drawable);
```

样式：

![](https://ws3.sinaimg.cn/large/006tKfTcly1g1eumuk7isj30dg03mmwx.jpg)

跟 xml 样式一致，并且代码更少，更易于使用。

以下是圆角等其他线条的展示。

**指定度数的圆角线条**

```java
new DrawableBuilder()
  .line()
  .corner(4)
  .build();
```

样式：

![](https://ws2.sinaimg.cn/large/006tKfTcly1g1eu63aw9rj30d603imwx.jpg)

**椭圆形圆角**
```java
new DrawableBuilder()
  .line()
  .roundCorner()
  .build();		
```

样式：

![](https://ws1.sinaimg.cn/large/006tKfTcly1g1eu8cytmqj30d403et8h.jpg)

**充满颜色的圆角**

```Java
new DrawableBuilder()
  .line()
  .roundCorner()
  .fill("#d35400")
  .build();
```

样式：

![](https://ws2.sinaimg.cn/large/006tKfTcly1g1eug4duitj30de03wwe9.jpg)

**虚线线条**

```java
new DrawableBuilder()
  .line()
  .dash()
  .build();
```

样式

![](https://ws3.sinaimg.cn/large/006tKfTcly1g1eus2o5l1j30d603sq2p.jpg)

## 其他 API

除了以上语义化 API，还提供了相应自定义参数的 API，如下所示：

| API                         | 说明                  |
| --------------------------- | ------------------- |
| lineWidth(int width)        | 设置线条宽度，参数为具体数值，无需转换 |
| lineColor(int lineColor)    | 设置线条颜色              |
| corner(float cornerRadius)  | 设置圆角度数              |
| dashWidth(float dashWidth)  | 设置虚线每个单元长度          |
| dashGap(float dashGap)      | 设置虚线边框每个单元之间的间距     |
| fill(@ColorInt int bkColor) | 设置填充颜色              |

