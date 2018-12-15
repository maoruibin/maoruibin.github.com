---
layout: post
author: 咕咚
title: "开源协议小风波"
description: ""
catalog:    true
tags: 随想
categories: blog 
---


今天无意间在做项目的过程中，因为没有遵守开源协议，导致了一个小误会，尽管已经跟drakeet同学致歉，但后来还是觉得有必要把事情再梳理一遍，让更多的开发者注重一下开源协议。

一开始在微博看到了@drakeet 同学开源了一个项目，叫 [MeiZhi](https://github.com/drakeet/Meizhi)，一个干货集中营的 unofficial 客户端，客户端用于在手机端更好的显示技术干货信息，因为自己平时也比较关注技术干货，自己也就开始使用。

整个客户端一开始都是drakeet一个人设计开发完成，其实对于程序员来说，写代码、开发往往是最轻松的事，最难的往往是设计，最终drakeet的干货客户端给人的视觉操作体验整体还是非常不错的，其中有很多细节，完成的很不错。

后来自己阅读了源码，更是对代码钦佩不已。项目中使用了RxJava Retrofit以及JAVA8新特性lambda ，整个项目代码很简洁，很优雅。

因为自己之前没有接触RxJava等知识，所以自己想仿照项目，自己动手实践一边RxJava的语法内容，以及lambda，因为我相信实践出真知，后来自己就new了一个项目，开始使用干货集中营的api进行开发，开始动手练习

后来在写页面的时候，觉得把所有的数据获取逻辑写在Activity中其实不好，这样Activity会显得臃肿，正巧那段时间，大家在讨论MVP，所以自己就干脆使用MVP来做项目，毕竟是小项目，重构起来还是挺方便，重构很顺利。

在重构完成后，我觉得自己已经不是在单纯的练习一些语法知识了，发现自己其实在做一个客户端。因为我想突出干货内容，所以后来就把干货首页改为了当天的干货信息，也就是下面的样子。

<img src="/assets/licence_1.jpeg" style="width: 50%;margin: auto;">

同时为了突出时间，还对图片做了亮度的调节，所以图片看上去暗点，这样时间也就显得更清楚一点。

后来代码被自己review了好几次，然后尝试发beta版，在一些开发者朋友的反馈下，自己又改了一些细节，然后就把应用发布了，同时代码也公布在github。

其实一开始，我是知道原项目是基于一个开源协议发布的，因为自己在看代码的过程中也多次看到drakeet在代码中的协议内容，包括在MeiZhi的Readme文件中也有这样的字样

![license](/assets/licence_2.jpeg)

但是自己没有花精力去像思考代码结构那样思考开源协议，然后就把代码公布，这也许是很多开发者不注意的问题。

对于我们而言很多时候都会把精力集中在具体的代码，而对于代码之外的一些东西往往会很容易忽略。

通过这件事提醒我们，作为开发者应该了解一些开源协议的问题，开源协议有很多，但是常用的就那些。

自己事后也开始找一些开源协议相关的资料,[聊聊Apache开源协议](http://kymjs.com/manager/2015/11/21/01/) @kymjs张涛

此外，drakeet同学也提供一张有用的图片，如下所示，

![license](/assets/licence_3.jpeg)

关于开源协议如果有更好的资料欢迎补充，自己最近也会多多学习并了解这方面！

再次感谢drakeet同学的及时指正，我的项目GankDaily也会尽快按照协议进行修正！不过最近因为自己的时间问题可能无法及时更新代码，可能需要过段时间才可以，不过开源协议这块，以后自己一定会注意到！

当然说这么多，也希望大家可以在以后的工作开发中，注意到这个问题的存在，让我们一起对开源协议保持敬畏并了解学习使用它。

附：文中出现的一些链接

干货集中营 [http://gank.io/](http://gank.io/)

妹纸 [https://github.com/drakeet/Meizhi](https://github.com/drakeet/Meizhi)

GankDaily [https://github.com/maoruibin/GankDaily](https://github.com/maoruibin/GankDaily)

聊聊Apache开源协议[http://kymjs.com/manager/2015/11/21/01/](http://kymjs.com/manager/2015/11/21/01/)
