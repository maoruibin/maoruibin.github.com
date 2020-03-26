---
layout: post
author: 咕咚
title:  "JVM、Dalvik、ART 介绍"
description: ""
catalog:    true
tags: Skills Java Android JVM ART
categories: tech 
---

该篇文章主要分享记录一下自己对 Java 虚拟机这个概念以及 Dalvik 虚拟机的理解，同时也会对他们做一个简单的对比。对于 Java 虚拟机自己也在不断学习认识中，如果有什么描述有误的地方，欢迎指正。

## 虚拟机

从一开始学 Java，我们就知道，我们写的所有的 Java 代码最终都会被编译器编译为以 .class  结尾的字节码文件，然后最终被 Java 虚拟机执行，从而得到我们想要的结果。
这里说到的 Java 虚拟机是一种规范。这个规范由 Sun 公司指定，然后具体的设备上执行字节码文件的 Java 虚拟机可能不一致，但是这些虚拟机都必须遵守相同的规范。

那目前主流的 Java 虚拟机有那些呢？具体可移步 [主流 JAVA 虚拟机](https://github.com/maoruibin/ArticlePart/issues/1)。

可以看出 Sun 公司开发的 HotSpot VM 是绝对的主流。

## Java 虚拟机与 Dalvik 虚拟机的关系 

首先 Java 虚拟机是一个规范，由 Sun 公司制定，任何实现该规范的虚拟机都可以用来执行 Java 代码。比如说，你们公司对现有虚拟机的垃圾回收或者其他特性不满意，完全可以自己去按照 JVM 规范来开发一个自己的虚拟机，当然一般的公司或者个人几乎没有这么干的，毕竟这需要相当的技术实力或者业务场景。

但是 Android 就这样搞了。由于 Androd 运行在移动设备上，内存以及电量等诸多方面跟一般的 PC 设备都有本质的区别 ，一般的 JVM 没法满足移动设备的要求，所以在开发 Android 过程中，Android 团队一开始就必须打造一个符合移动设备的可以执行 Java 代码的虚拟机。

这就是我们说的 Dalvik 虚拟机 。

## JVM 与 Dalvik 的区别

到这里你会发现，其实 Dalvik 是一个更符合移动设备的用于执行 Java 代码的虚拟机，但又不是一个严格按照 JVM 规范的虚拟机实现，下面分别从执行文件格式等其他方面介绍一下他们的区别。

### 格式

JVM 可以执行的文件是 .class 结尾的字节码文件，而 Dalvik 执行的是 dex  文件。

但是按照 JVM 的规范，虚拟机只能执行 .class 文件，所以这里也印证上面抛出的那个结论，`Dalvik 并不是一个符合 JVM 规范的 Java 虚拟机`。

为什么 Dalvik 执行 dex 文件而不是 .class 文件，其实这里是 Android 专为 Dalvik 虚拟机做的一个优化。

Java 虚拟机执行 .class 格式的字节码。每一个 Java 文件对应一个 .class 的字节码文件，JVM 在运行时为每一个执行到的类装载字节码。而 Android 设备上为了提高执行效率，在编译 Android 项目时，Android 通过 SDK 提供的工具 dex.jar 会把所有的 .class 文件最终打包成一个 .dex 文件(不一定是一个)。


### Base
Dalvik 基于寄存器，而 JVM 基于栈，很明显，基于寄存器的 Dalvik 在速度方面优势会更明显。

### 运行环境

Dalvik 经过优化，允许在有限的内存中同时运行多个虚拟机的实例，并且每一个 Dalvik 应用作为一个独立的 Linux 进程执行。

独立的进程可以防止在虚拟机崩溃的时候所有程序都被关闭。

除了上面提到的，还有以下几点。

* Dalvik负责进程隔离和线程管理，每一个Android应用在底层都会对应一个独立的Dalvik虚拟机实例，其代码在虚拟机的解释下得以执行。
* dex 文件格式可以减少整体文件尺寸，提高I/O操作的类查找速度。
* 有一个特殊的虚拟机进程Zygote，他是虚拟机实例的孵化器。它在系统启动的时候就会产生，它会完成虚拟机的初始化、库的加载、预制类库和初始化的操作。如果系统需要一个新的虚拟机实例，它会迅速复制自身，以最快的速度提供给系统。

## Dalivk 与 ART 虚拟机
从 Android L 开始，Android 开始启用了新设计的虚拟机 ART。与 Dalvik 不同，在Dalvik下，应用每次运行的时候，字节码都需要通过即时编译器（Just In Time ，JIT）转换为本地机器码，这会拖慢应用的运行效率。

而在ART 环境中，应用在第一次安装的时候，会使用设备上的`dex2oat `工具进行字节码转码，把字节码预先编译成本地机器码，使其成为真正的本地应用。这个过程叫做预编译（Ahead-Of-Time，AOT）。

采用 AOT 策略后的好处显而易见，应用的启动速度会因此快很多，但是与此同时，应用的安装时间就会因为执行 AOT 操作而变长，但是相比之下还是非常值得。

另外，ART的另一个缺点就是对存储空间占用变大。一般的字节码在编译转码后占用的空间大小比之前要增大10%-20%。

除了 AOT 机制，ART 另外一个显著的提升就是垃圾回收方面的提升。相比 Dalvik 虚拟机，ART 虚拟机具有更高的回收性能。具体可以查看知乎的一个同学的[回答](https://www.zhihu.com/question/29406156)，或者可以直接看[官方的文档说明](https://source.android.com/devices/tech/dalvik/)。

## 总结

Dalvik 其实可以理解为一个专为移动设备优化过的 JVM，它的大部分地方都遵守了 JVM 规范，其实那些不符合规范的地方，就可以理解为为移动设备做的优化工作。而 ART 是一个具有更高性能的 Android 虚拟机，从一开始他就是为取代 Dalvik 而来，它的 AOT 机制相比Dalvik 的 JIT 机制使得应用有更快的启动速度。同时 ART 虚拟机在垃圾回收方面也比 Dalvik 更加高性能。

## 附：

JIT：Dalvik 虚拟机运行 App 的机制，运行期实时翻译（Just In Time）。

AOT：ART 虚拟机对 App 运行的优化机制，它在应用安装时就提前（Ahead-Of-Time）做好了字节码到机器码的翻译工作。

## 参考链接
- [ART and Dalvik - 官方文档](https://source.android.com/devices/tech/dalvik/)
- [ART 和 Dalvik 的区别 - 知乎](https://www.zhihu.com/question/29406156)
- [目前主流的 Java 虚拟机有哪些?](https://zhihu.com/question/29265430/answer/43818804)
- [Dalvik虚拟机和JVM的区别。Java里面的，Android里面的区别](https://zhidao.baidu.com/question/1238373007717632179.html)
- [Java 虚拟机与 Dalvik 虚拟机(简书)](http://www.jianshu.com/p/a8cc7a92137c)
- [Android：ART 优化配置（Mstar\-6A648） \- sheldon\_blogs \- 博客园](https://www.cnblogs.com/blogs-of-lxl/p/11608115.html)