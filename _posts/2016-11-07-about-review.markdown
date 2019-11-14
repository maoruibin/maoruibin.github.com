---
layout: post
author: 咕咚
title:  "ReView 一个辅助设计师方便 review UI 的 view 组件集合"
description: ""
catalog:    true
tags: 效率 Android UI 
categories: tech 
---

ReView 是一个用于帮助程序员、设计师方便查看字体大小以及颜色等属性的 View 组件集合，
这篇文章简单介绍一下 [ReView](https://github.com/maoruibin/ReView) 的开发初衷及用途。


## 问题

在日常开发过程，程序员一般都需要根据设计师的设计图以及标注图来进行 UI 开发，一般来说，设计师往往会在标注图上标注清楚每个 View 的大小以及字体颜色等等属性，我们开发者需要严格按照设计师的标注进行界面开发。

开发完成后，设计师往往会 review 我们的实现效果，这时如果设计师感觉到有一个 TextView 好像字体小了点，跟他标注的有出入，而且字体颜色也有点浅，这时也许他就回过来找你理(si)论(bi)，然后对你说，你这个字体大小好像不对啊，看上去有点小，你是不是搞错了.

这时，在没有任何辅助工具的情况下，只能默默找到对应的 layout 文件，然后查看 xml 文件，找到具体的 View 属性设置，看是不是跟字体大小或者颜色跟标注有出入，而且你还要考虑代码中动态设置字体大小颜色的可能性，不论最终结果如何，整个过程都显得效率低下，一点不高效，这些事有没有更好的解决方式呢？

如果能让 View 显示自己的大小、颜色，这个问题不就解决了吗？

## 解决方案

如下图所示

![review](http://7xr9gx.com1.z0.glb.clouddn.com/review.gif)

这就是自己最近开发的一个 View 组件 ReView。

他可以帮助你查看当前 View 的字体大小以及颜色，目前只支持 TextView Button ImageView 这三个 View。

由于 gif 图质量一般，效果看的不是很明显，推荐下载示例 demo APK 查看。

[下载地址](http://fir.im/mvzb)

也可扫码下载

![扫码下载](http://7xr9gx.com1.z0.glb.clouddn.com/fir-review.png)

## 推荐用法 
你可以在项目中增加一个开关用于控制是不是启用这个高级属性，正常的开发模式下，你不需要使用这个功能，只有在特定场合下，如文章一开始说到的，设计师都找到你头上了，这种时候你直接打开你自己定义好的控制开关，秒杀设计师，"哼，我的字体木有任何问题！！就是这么叼！"，当然也不排除打自己脸的时候。

当然，你可以可以直接把这个开关告诉设计师妹妹，他们 review 时直接打开开关就可以方便的看到 View 的字体大小，如果你字体设置的有问题，她直接告诉你那个 View 有问题，省的你自己再去 layout 文件中找了。

这也是为什么叫 ReView 的原因。

项目已开源，具体使用方法可以查看[项目主页](https://github.com/maoruibin/ReView)介绍，如有问题，欢迎 [issue](https://github.com/maoruibin/ReView/issues) 或者 评论。


