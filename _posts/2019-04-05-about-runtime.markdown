---
layout: post
author: 咕咚
title: "什么是运行时（Runtime）"
description: 运行时是一个通用概念，不同的语言可能都需要一个运行时才能让程序在硬件平台运行，这篇文章介绍了什么是运行时。
shang: true
qrcode_mp: true
tags: Java Runtime
categories: tech 
---

任何语言要运行都需要自己的运行时，Java 程序的运行时叫 Java Runtime，Android 程序的运行时叫 Android Runtime，而具体 Runtime 是个什么东西呢，就是说一个程序要在一个硬件或者平台上跑，就必须要有一个中间层用来把程序语言转换为机器能听懂的机器语言。

Java Runtime 的左右就是如此，如我们编写好了 Java 的 Hello World 程序，

```java
public class HelloWorld{
    public static void  main(String[] args){
        System.out.println("hello world");
    }
}
```

代码我们认识，作用就是输出一个 “hello world”，但是要在一个冷冰冰的机器上，让机器能读懂并运行这段代码，就需要一个 Java 语言的运行时环境，只有这个环境才能读懂它，并能让代码更机器进行打交道。

到这里我们已经明白，**如果一个电脑要能运行 Java 程序就必须安装有 Java Runtime。**对于其他语言也是如此，要在平台上运行就必须要有对应平台上的 Runtime 组件，这也是开发一个新语言必须要做的事。

说道 Runtime，在 Java 发展的过程中，Java 一下子火了有一个很重要原因，就是在 90 年代，微软的 IE 浏览器为了打败网景浏览器，曾经就在 IE 中默认安装 Java 运行时，再加上 IE 浏览器内置在 Windows 操作系统中，使得 IE 装机量特别大，同样这对 Java 也是一个非常大的促进作用。由于 IE 内置 Java Runtime，使得在 IE 浏览器中开发 Java 程序变得更加简单。如出名的  Java Applet（Java 小程序）开发。

后来因为 Sun 跟 微软之间诉讼等事情，这个合作也没多久，现在 IE 已经默认禁用了 Java Applet。

说道 Java Runtime（简称 JRE） ，曾经在一开始开发 Java 程序时，经常把 JRE 跟 JDK 搞混。

JRE 是一个独立的东西，就是 Java 程序的运行环境，其中包含一个 JAVA 虚拟机（JVM）以及一些标准的函数类库。

而 JDK 是 Sun 公司专门给开发人员准备的 Java 开发工具集。它其中就包含了 JRE，所以配置好 JDK，自然就可以在电脑上运行 Java 程序了。除此之外，JDK 还包含了源码、API 文档、编译工具等等。

