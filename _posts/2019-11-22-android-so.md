---
layout: post
author: 咕咚
title: "Android so 文件概要"
description: So 文件学习笔记
tags: so  
categories: tech
---

## 要点
* 不同的 CPU  架构需要不同的 so 文件
* NDK平台不是后向兼容的，而是前向兼容的。
* ABI 的概念，每一个 Cpu架构对应一个 ABI（Application Binary Interface，应用二进制接口）。
* ABI 定义了其所对应的 CPU 架构能够执行的二进制文件（如 .so 文件）的格式规范，决定了二进制文件如何与系统进行交互。
* 所有的 x86/x86_64/armeabi-v7a/arm64-v8a 设备都支持 armeabi 架构的 .so 文件
* so（shared object，共享库）是机器可以直接运行的二进制代码，是 Android上的动态链接库，类似于Windows上的dll。

### 为什么使用so
* so 机制让开发者最大化利用已有的 C 和 C++ 代码，达到重用的效果，利用软件世界积累了几十年的优秀代码；
* so 是二进制，没有解释编译的开消，用 so 实现的功能比纯 java 实现的功能要快；
* so 内存分配不受 Dalivik/ART 的单个应用限制，减少 OOM；
* 相对于 java 代码，二进制代码的反编译难度更大，一些核心代码可以考虑放在 so 文件中。

### x86 手机对 arm 的支持

值得注意的是原本 x86 架构的 CPU 是不支持运行 arm 架构的 native 代码的，但 **Intel 和 Google 合作**在x86机子的系统内核层之上加入了一个名为 **houdini** 的Binary Translator（二进制转换中间层），这个中间层会在运行期间动态的读取 arm 指令并将之转换为 x86 指令去执行。

 Android 系统支持其中不同的 CPU 架构，ARMv5，ARMv7 (从2010年起)，x86 (从2011年起)，MIPS (从2012年起)，ARMv8，MIPS64和x86_64 (从2014年起)，每一种都关联着一个相应的ABI。



## 参考链接

* [ABI 管理  \|  Android NDK  \|  Android Developers](https://developer.android.com/ndk/guides/abis.html)
* [谈谈Android的so \| Allen's Zone](http://allenfeng.com/2016/11/06/what-you-should-know-about-android-abi-and-so/)

