---
layout: post
author: 咕咚
title: "使用 CheckStyle 检查代码"
description: ""
catalog:    true
tags: Android 代码规范
---

### 前言

最近在看廖祜秋的下拉刷新项目 [android-Ultra-Pull-To-Refresh](https://github.com/liaohuqiu/android-Ultra-Pull-To-Refresh)，就在今天做了一些精简操作后，准备加入项目准备使用时，发现 lib 根目录下有一个 `checkstyle.xml` 文件，很好奇它是干什么的，后来 Google 后，原来这东西可以用来检查代码，随即查询了一些资料，把它用了起来，下面简单记录下。

### 用途

先不说如何配置，先说它有什么用。

AndroidStudio 可以通过自己指定的 CheckStyle 去检查自己写的代码是不是符合规则，如果代码中有不合该规范的地方，都可以在控制台看到对应的提示信息。

这里比较好的一点是，你可以自定义自己的 checkstyle ,可以根据自己的代码规范去一点点完善这个 checkstyle ,也可以使用一些大公司的 checkstyle ,这些 checkstyle  文件是可以搜到的。

### 最终效果

说了这么多，还是看最终效果比较来的直白一点。

下图中使用 checkstyle 检查我的 MainActivity，我故意让一个成员变量的命名没有按照驼峰式去写，然后点击菜单键的 Check
Current File 检查如下。

![one](/assets/checkstyle_1.jpg)

可以看到，显示提示 viewpager 命名不合规范，然后我改为 mViewPager 后，就不会再提示了。如下所示。

![one](/assets/checkstyle_2.jpg)

### 配置

已经看到了具体效果，是不是跃跃欲试了，这时你可能试着点击了菜单右键，却发现没有`Check Current File` 这个选项。

下面具体说下

#### 安装插件

要使用 checkstyle 需要安装一个 AndroidStudio 插件 CheckStyle-IDEA,你可以通过在线安装插件的方式去安装，也可以通过本地安装，[插件地址](https://github.com/jshiell/checkstyle-idea)

#### 配置 checkstyle 文件

当安装好插件，打开 AndroidStudio 的设置页面 settings -> Other Settings  你会发现多了一个 Checkstyle ,
点击打开,如下图。
![one](/assets/checkstyle_3.jpg)

你会看到有一个 `+` 按钮，点击即可添加自己的 checkstyle 文件，你可能第一次不会写这个文件，没关系，这里提供一个华为的 Checkstyle [Gist 地址](https://gist.github.com/ownwell/c32878440216f1866842)。

其实 AndroidStudio 已经默认提供了一个，你也可以使用默认的。

记得添加时，不要忘了填写 description 。

![four](/assets/checkstyle_4.jpg)

这里关于 checkstyle 中的语法，有相应的文档，可以自己去搜索阅读具体语法，一般的，照猫画虎就够了。

#### 现成的CheckStyle

[华为 CheckStyle 地址](https://gist.github.com/ownwell/c32878440216f1866842)

[ the checkstyle configuration used for Picasso by Square folks](https://github.com/square/picasso/blob/master/checkstyle.xml)

 [Google's Java Style Checkstyle Coverage](http://checkstyle.sourceforge.net/google_style.html)

#### 完毕

到此，基本的配置就完毕了。现在 AndroidStudio 的控制面板会多一个 CheckStyle，你可以在这里方便的进行代码检查。

可以点击面板的左上角下拉框 Rule 去动态切换不同的 checkstyle。

### 总结

其实代码检查还有很多方式，这只是一种，有兴趣可以看看其他几种,如 Lint , [Findbugs](http://findbugs.sourceforge.net/) 。

### 有用的超链接
[checkstyle 项目地址](https://github.com/checkstyle/checkstyle)

[CheckStyle API 文档](http://checkstyle.sourceforge.net/checks.html)

[代码规范和Android项目中的一些可用工具](http://tech.glowing.com/cn/dai-ma-gui-fan-he-androidxiang-mu-zhong-de-xie-ke-yong-gong-ju/)

[Static code analysis plugin for Android project](https://github.com/noveogroup/android-check)
