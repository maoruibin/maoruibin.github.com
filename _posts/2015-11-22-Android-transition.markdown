---
layout: post
author: 咕咚
title: "在Android5.0以上设备实现过渡动画"
description: ""
categories: 
cover-color:  "#3e4145"
tags: Usage Skills
categories: tech 
---
从Android5.0开始，系统提供一个很好看的Activity间的转场动画，具体就是共享两个界面中一些共有的View，让前后两个界面的跳转变得很流畅
好看。

## 具体效果

一图胜千语,下面就是 Android 5.0 设备上使用转场动画后示意图，这样的交互在 Google 自家的 App 里已经司空见惯。比如 Google Play
中，从应用列表界面跳转到应用详情页，就使用了类似的转场动画。下面的示意 gif 来自 Android 官方 Demo。

![tronsition_effect](/assets/tronsition_effect.gif "tronsition_effect")

看上去确实很好看,使用后让原本硬生生的界面跳转变得特别自然。那怎么实现呢,简单分析下。

现在有两个 Activity 分别为 MainActivity 和 DetailActivity 。MainActivity中是一些动物的列表展示，每个 Item包含一个动物图片和动物名称。
点击 Item 需要跳转到对应动物的详情介绍页。详情介绍页，会显示动物的大图，名称以及这个动物的详细介绍。

因为两个界面中动物的图片和名称是一致的,也就是说这两个界面有共有的 View 元素,所以这种场景就比较适合用转场动画来
优化交互逻辑，现在点击 MainActivity 的 Item，需要产生一个转场动画来到达详情页。下面就是具体实现方式。

## 实现方法

### 1、在DetailActivity中为指定的 View 设置一个字符串的标记
```java

    // View name of the header image. Used for activity scene transitions
    public static final String VIEW_NAME_HEADER_IMAGE = "detail:header:image";
    
    // View name of the header title. Used for activity scene transitions
    public static final String VIEW_NAME_HEADER_TITLE = "detail:header:title";
    
```    

### 2、使用 ActivityCompat 启动目标 Activity

```java    

    Intent intent = new Intent(this, DetailActivity.class);
    intent.putExtra(DetailActivity.EXTRA_PARAM_ID, item.getId());

    /**
     * 通过ActivityOptionsCompat的工厂方法创建一个ActivityOptions实例
     */
    ActivityOptionsCompat activityOptions = ActivityOptionsCompat.makeSceneTransitionAnimation(
            this,
            //关联两个界面中的共有 View 元素
            new Pair<View, String>(itemView.findViewById(R.id.imageview_item),
                    DetailActivity.VIEW_NAME_HEADER_IMAGE),
            new Pair<View, String>(itemView.findViewById(R.id.textview_name),
                    DetailActivity.VIEW_NAME_HEADER_TITLE));
    //启动目标 Activity 
    ActivityCompat.startActivity(this, intent, activityOptions.toBundle());
   
```    

### 3、在 DetailActivity 的 onCreate 方法中接受并处理

```java    

    //找到 detail 界面中的 View 元素
    mHeaderImageView = (ImageView) findViewById(R.id.imageview_header);
    mHeaderTitle = (TextView) findViewById(R.id.textview_title);

    //关联
    ViewCompat.setTransitionName(mHeaderImageView, VIEW_NAME_HEADER_IMAGE);
    ViewCompat.setTransitionName(mHeaderTitle, VIEW_NAME_HEADER_TITLE);
    
```

## 总结

总体说来使用还是挺简单的,这个效果尤其对图片类应用特别棒,不过目前只有 5.0 以上设备才能支持这个效果,如果想要兼容5.0以下的设备,你可能需要去 Github 搜搜有没有合适库。



    
    
