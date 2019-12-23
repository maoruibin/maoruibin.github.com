---
layout: post
author: 咕咚
title:  "Android 复杂界面开发实践之 ViewController: 介绍"
description: ""
catalog:    true
shang    :  true
tags: 架构 ViewControl
categories: tech 
---


|本人博客地址 [http://gudong.site](http://gudong.site)
|本文简书地址:[http://www.jianshu.com/p/e70c1478cd9e](http://www.jianshu.com/p/e70c1478cd9e)

[ViewController](https://github.com/maoruibin/ViewController) 是一种界面开发组件化的实现方式,利用它可以将一些复杂的 UI 界面开发组件化, 从而更好的组织代码结构,从而提高开发效率,降低维护成本。

不同于 [Fragment](https://developer.android.com/guide/components/fragments.html) ，ViewController 更加小巧、灵活、易控制，代码也超级简单，目前只有一个不到 100 行的类。

目前项目已经开源，项目地址：[ViewController](https://github.com/maoruibin/ViewController)

## 介绍

关于 ViewControler 这种思想的介绍,也可以查看上一篇文章,[Android 复杂界面开发实践之 ViewController: 前言](http://www.jianshu.com/p/e3f86d5a4474)

在日常开发中，当我们看到如下的 UI 原型时，在实际编码实现过程中，通常我们会把所有的布局先用 xml 实现，然后在 Activity 中编写所有的 UI 操作逻辑。

![](http://upload-images.jianshu.io/upload_images/588640-eebf764b15d709d8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这里，稍微思考下，这种方式的开发会有什么弊端。

所有的 UI 元素都需要定义在同一个类中，所有的 UI 逻辑操作也都发生在同一个类里，在加上一些业务逻辑，这个界面的代码会在不断迭代的过程中越来越难保持 clean .

但是使用 ViewController 这种思想后，你可以把页面逻辑按 UI 块做拆分，进行组件化开发，最后在 Activity 中只需要把组件进行组合即可。

下面是一张 ViewController 示意图，如下所示。
![](http://upload-images.jianshu.io/upload_images/588640-f0d3a5f83460c558.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如上图所示，现在把界面拆分为了四个 ViewController，每个ViewController 管理自己的一组View 集合，这样就巧妙的把原本需要写在 Activity 代码分发到了不同的 ViewController 中去。

至于代码如何分发，可以查看项目主页 [Readme](https://github.com/maoruibin/ViewController)，或者直接看源码。

## 使用
具体如何使用，请移步[项目主页](https://github.com/maoruibin/ViewController)，那里有详细的介绍，因为代码很简短，如果有兴趣，建议直接看源码。

## 适合 ViewController 的情形

首先，不是所有的界面都适合用此种方式去开发，一些界面从设计之初就是浑然一体的，咱们没法做拆分，就没法使用，当然也没必要使用。

但是比如示例中的房屋详情设计，就特别适合使用 ViewController，因为他可以很容易的让我们去划分程序概念上的块。

如上所述，在合适的地方使用 ViewController，优点就显而易见。

## 优点

* 界面开发组件化，解决 Activity/Fragment 中 UI 代码臃肿问题。
* 灵活的 UI 开发，同一组件可在多处复用，从而做到代码重用。
* 易维护，开发简单。

## 作者

[个人主页：咕咚](http://gudong.site)

[新浪微博：大侠咕咚](https://github.com/maoruibin)