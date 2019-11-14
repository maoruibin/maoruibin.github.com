---
layout: post
author: 咕咚
title: "利用 Gradle Task 查看远程依赖库的本地存储路径"
description: ""
cover-color:  "#84BA40"
publish: true
catalog:    true
tags: Gradle Tools
categories: tech 
---
这篇文章主要分享一个主题，如何在 AndroidStudio 中利用 gradle 查看自己项目中引入的三方依赖库的本地缓存路径。相信一些同学会对这个
话题感兴趣的。

### 问题

自从使用 AndroidStudio + Gradle 开始项目开发，我们已经用到了很多 gradle 带来的特性，比如要在项目中使用三方 Lib ，
我们再也不需要像 eclipse 时代，需要我们手动下载对应的 jar 包，从 gradle 开始，我们只要在build.gradle 加入三方lib的
dependencies 路径，然后同步，lib就自动下载到本地了。

例如，我们要在自己的项目中引用 square 公司的网络框架 OkHttp ，只需要在 build.gradle
文件中加一行依赖路径即可，如下所示

    compile 'com.squareup.okhttp:okhttp:2.5.0'

加入之后，同步，我们就可以使用 okhttp 提供的各种 API ，很简单的导入方式。

但是时间久了，我就愈发想知道，gradle到底把lib给存到什么地方了，
今天搜了一圈，找到一个靠谱的方法，特意分享下，也不是什么技术点，只是解决我心中的一个疑问而已。

###  答案

     dependencies{
         .....
     }

     //显示依赖包的存储路径   
     task showMeCache << {
         configurations.compile.each { println it }
     }

如上所示，只需要在 build.gradle 文件中，增加如上所示的一个 task ,然后打开 AndroidStudio 自带的 Terminal 窗口，执行

    gradle showMeCache

即可看到所有依赖的对应路径，

Note : 因为 gradle 文件顺序执行的特点，这个任务应该定义在`dependencies`节点之下。

###  结果

    :app:showMeCache
    /Users/mao/workpace/person/AppPlus/app/libs/lite-orm-1.7.0.jar
    /Users/mao/workpace/person/AppPlus/app/libs/umeng-update-v2.6.0.1.jar
    /Users/mao/Downloads/android/sdk/extras/android/m2repository/com/android/support/appcompat-v7/23.1.1/appcompat-v7-23.1.1.aar
    /Users/mao/Downloads/android/sdk/extras/android/m2repository/com/android/support/design/23.1.1/design-23.1.1.aar
    /Users/mao/.gradle/caches/modules-2/files-2.1/com.jenzz/materialpreference/1.3/def38f1784f5f789b10ed388e385f7857e765405/materialpreference-1.3.aar
    /Users/mao/.gradle/caches/modules-2/files-2.1/com.readystatesoftware.systembartint/systembartint/1.0.3/de4f7404e2f58d8f6e83cb1e85d0c2d6c2987287/systembartint-1.0.3.jar
    /Users/mao/Downloads/android/sdk/extras/android/m2repository/com/android/support/gridlayout-v7/22.2.0/gridlayout-v7-22.2.0.aar
    /Users/mao/.gradle/caches/modules-2/files-2.1/com.umeng.analytics/analytics/5.6.4/76fed6d2233b958f0c1d589aa366785e0ab5c8f1/analytics-5.6.4.jar
    /Users/mao/Downloads/android/sdk/extras/android/m2repository/com/android/support/percent/23.1.0/percent-23.1.0.aar
    /Users/mao/.gradle/caches/modules-2/files-2.1/com.jaredrummler/android-processes/1.0.2/704bbcb3f6d25c5da24b3e0199b178520ad7ca7e/android-processes-1.0.2.aar
    /Users/mao/Downloads/android/sdk/extras/android/m2repository/com/android/support/support-v4/23.1.1/support-v4-23.1.1.aar
    /Users/mao/Downloads/android/sdk/extras/android/m2repository/com/android/support/recyclerview-v7/23.1.1/recyclerview-v7-23.1.1.aar
    /Users/mao/Downloads/android/sdk/extras/android/m2repository/com/android/support/support-annotations/23.1.1/support-annotations-23.1.1.jar

 Enjoy it.
