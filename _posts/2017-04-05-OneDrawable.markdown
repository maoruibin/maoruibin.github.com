---
layout: post
author: 咕咚
title:  "仅使用一张资源图片为 View 设置具有按下效果的背景 - OneDrawable"
description: ""
catalog:    true
shang    :  true
cover-color:  "zzz"
tags: Skills Tools 
categories: tech 
---
该篇文章主要分享介绍，如何使用一张资源图片为 View 设置具有按下效果的 Background Drawable.

![OneDrawable](http://7xr9gx.com1.z0.glb.clouddn.com/slogin.gif)

开源地址 [OneDrawable](https://github.com/maoruibin/OneDrawable)

## 缘起

前段时间在开发项目新版本的过程中，设计师出了一套项目的按下效果规范。规范大概是这样的。

对于一般的按钮，按钮按下的效果只有两种不同的实现。

1、按下后将前置背景图片变暗，具体就是在正常状态的 drawable 上面增加一层 20% 的黑色遮罩。

2、按下后降低前置背景资源透明度，具体就是在按下时改变正常状态的 drawable 透明度为原来的 70% 。

很明显，这套规范会带来以下好处。

* 设计师在出图时只需要出一张图，然后只需要告诉开发人员对应的按下效果策略，这样可以减轻设计师的出图负担。
* 客户端这边也是，不需要因为实现一个按下效果而导入两张资源图片，这样在减小包大小的同时也省去了客户端开发人员去写 selector 文件的麻烦。  

## 实现方案

其实在之前的开发过程中，我也曾有过这样的思考，想怎么可以根据一张图来设置 View 的背景，并让他具有按下效果。一开始自然而然的想到了处理 View 的 touch 事件，然后在按下时动态的根据正常背景设置按下后的背景资源。

但是后来觉得还是麻烦，而且一些时候一些 View 本身就需要处理 touch 事件，会造成冲突，所以当时也就一了百了。

这次经过一些搜索，思考，最终使用 `StateListDrawable` 达到了了目标效果。

StateListDrawable 有一个方法 `addState` 用于设置不同状态下的 drawable ，包括按下、聚焦、不可用等等所有的状态。

所以结合需求，这里只需要根据正常状态下的 drawable 计算出按下状态的 drawable，然后设置给按下按下状态，就可以完美实现一套资源实现 View 的按下状态。   

## 具体实现

方案已经说清楚了，实现其实很简单，代码如下所示。

```java
private static Drawable getBackground(@NonNull Context context, @DrawableRes int res, @StatePressedMode.Mode int mode, @FloatRange(from = 0.0f, to = 1.0f) float alpha) {
    Drawable normal = context.getResources().getDrawable(res);
    Drawable pressed = context.getResources().getDrawable(res);
    pressed.mutate();
    //根据不同的按下要求设置不同的按下drawable
    setPressedStateDrawable(mode, alpha, pressed);
    final StateListDrawable stateListDrawable = new StateListDrawable();
    //按下状态
    stateListDrawable.addState(new int[]{android.R.attr.state_pressed}, pressed);
    //正常状态
    stateListDrawable.addState(new int[]{}, normal);
    return stateListDrawable;
}
```

根据不同按下模式，处理按下的 drawable

```java
private static void setPressedStateDrawable(@StatePressedMode.Mode int mode, @FloatRange(from = 0.0f, to = 1.0f) float alpha, @NonNull Drawable pressed) {
    switch (mode) {
        case StatePressedMode.ALPHA:
            pressed.setAlpha(convertAlphaToInt(alpha));
            break;
        case StatePressedMode.DARK:
            pressed.setColorFilter(alphaColor(Color.BLACK, convertAlphaToInt(alpha)), PorterDuff.Mode.SRC_ATOP);
            break;
        default:
            pressed.setAlpha(convertAlphaToInt(alpha));
    }
}
```

下图为 demo 截图

![demo](http://7xr9gx.com1.z0.glb.clouddn.com/statebackgroundv2.gif)

## 兼容问题

后来有网友反馈在 4.4 的机型下按下效果失效，后来发现是因为 Drawable 的 setColorFilter 方法在 4.4 的手机上失效，后来采用了 BitmapDrawable 的方式解决，具体可以看代码实现，这里贴出最重要的一段代码。
```java
    private static Drawable kitkatDrawable(Context context, @NonNull Drawable pressed, @PressedMode.Mode int mode, @FloatRange(from = 0.0f, to = 1.0f) float alpha) {
        Bitmap bitmap = Bitmap.createBitmap(pressed.getIntrinsicWidth(), pressed.getIntrinsicHeight(), Bitmap.Config.ARGB_8888);
        Canvas myCanvas = new Canvas(bitmap);
        switch (mode) {
            case PressedMode.ALPHA:
                pressed.setAlpha(convertAlphaToInt(alpha));
                break;
            case PressedMode.DARK:
                pressed.setColorFilter(alphaColor(Color.BLACK, convertAlphaToInt(alpha)), PorterDuff.Mode.SRC_ATOP);
                break;
        }
        pressed.setBounds(0, 0, pressed.getIntrinsicWidth(), pressed.getIntrinsicHeight());
        pressed.draw(myCanvas);
        return new BitmapDrawable(context.getResources(), bitmap);
    }
```

## 一些细节
在设置按下状态的 drawable 时，

```java
Drawable normal = context.getResources().getDrawable(res);
Drawable pressed = context.getResources().getDrawable(res);
```

这里的 normal 和 pressed 使用的资源 res 资源是同一个 id。但是由于 drawable 在加载过程中，同一个 res 资源只要在内存中加载过一次,这个 drawable 对应的 state 就会保持一致，所以这里要对 pressed 进行可变设置。

```java
pressed.mutate();
```

关于 mutate 方法的官方说明

> This is especially useful when you need to modify properties of drawables loaded from resources. By default, all drawables instances loaded from the same resource share a common state;


另外需要注意的是，由于 View 的按下效果只有在设置了 clickable 为 true 时才可以看到效果，所以当你使用 OneDrawable 为 View 设置背景后却发现没有按下效果，你应该知道怎么办。


最后，如果你发现还有什么问题，欢迎在 [issue](https://github.com/maoruibin/OneDrawable/issues) 或者评论区指出，也欢迎你把更好的方案 PR 上来。
