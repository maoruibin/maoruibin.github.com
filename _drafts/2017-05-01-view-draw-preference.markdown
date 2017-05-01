---
layout: post
author: 咕咚
title:  "View 绘制优化 tip 集合"
description: ""
tags: 随想
---

关于绘制 View 过程中的各种优化 tip 

> 仅仅在View的内容发生改变的时候才去触发invalidate方法



> 尽量使用ClipRect等方法来提高绘制的性能

使用 ClipRect 可以避免一些无用的绘制，比如两个 View 叠加在一起，那么相叠加的地方就可以使用 ClipRect 来标记出来，然后避免重复绘制。

> ArrayList手写的循环比增强型for循环更快，其他的集合没有这种情况。因此默认情况下使用增强型for循环，而遍历ArrayList使用传统的循环方式。

尤其是 View 绘制时如果要做一些遍历，可以参考此条原则。

> 用到除法的时候使用位运算



## 参考链接

[Android性能优化典范 - 第2季](http://hukai.me/android-performance-patterns-season-2)