---
layout: post
author: 咕咚
title:  "Android 项目开发清单"
description: ""
catalog:    true
tags: 架构
categories: tech 
---

良好的开始是成功的一半，对于一个 Android 项目更是，一个好的项目基础架构可以对项目的后续发展有至关重要的作用。所以我们在项目开发之初，应该花费一些时间去调研、设计符合自己项目的基础架构。而且从项目长远的发展来看，这些时间花的非常值得。

下面就从项目的方方面面出发，介绍一下自己搭建项目时的一些经验。当然个人水平经历有限，自己的分享可能有片面性和不足性，欢迎指正补足。

## 代码质量保证

项目开发是一个团体活动，每个人都有自己不同的技术风格以及代码风格，但是为了项目后续的可维护性、健壮性，我们需要项目开发过程中，尽早采用统一的编码风格和代码质量检测跟进，防止后续的代码管理变得混乱不堪。下面介绍几个已经被大家广泛采用的代码质量保证工具。


- [CheckStyle](https://github.com/checkstyle/checkstyle)
- [FindBugs](http://findbugs.sourceforge.net/)
- [PMD](https://pmd.github.io/)
- [Android Lint](http://tools.android.com/tips/lint)

### CheckStyle

CheckStyle 是一个帮助开发者严格按照指定的编码规范标准编写代码的一个工具，它能结合 Android Studio 与相应的插件在开发过程中自动检测 Java 编写规范，以减少人工检测代码的成本。也可以使用 Gradle 通过 task 去检测代码是不是符合指定的规范。

具体如何在 AndroidStudio 中使用，可以参考之前的一篇文章[使用 CheckStyle 检查代码](2016-04-07-checkstyle.markdown)

### FindBugs

FindBugs 这个名字本身已经揭示了它的作用

>“FindBugs uses static analysis to inspect Java bytecode for occurrences of bug patterns.” 

FindBugs 是一个工具，它能通过静态分析方式扫描 Java `字节码`，发现其中的可能出现 bug 的代码，它能发现一些常规的低级的错误，例如一些错误的逻辑操作，也能发现一些比较隐晦的错误。

### PMD

PMD 是一个非常强大的工具，它的作用类似 Findbugs，但是它的检测扫描是基于`源码`的，而且 PMD 不仅仅能检测 Java 语言，还能检测其他语言。PMD 的目标和 Findbugsd 非常的相似，都是通过定义的规则静态分析代码中可能出现的错误，为什么要同时使用 PMD 和 Findbugs呢？由于 Findbugs 和 PMD 的扫描方式不一样，PMD 能发现的一些 Findbugs 发现不了的问题，反之亦然。

PMD 可以发现程序中的无用变量、空的catch块、不必要的对象创建等。

### Android Lint

>“The Android lint tool is a static code analysis tool that checks your Android project source files for potential bugs and optimization improvements for correctness, security, performance, usability, accessibility, and internationalization.” 

正如官网所说，Android Lint 是另一个静态代码分析工具,专门针对 Android 工程。Android Lint 除了对代码扫描，分析潜在问题之外，还能对Android的资源进行检测，无用的资源，错位的dip资源等。同时， AndroidStudio 以及集成了 lint ，你可以很方便的使用。步骤如下。

AndroidStudio -> 菜单 -> Analyze -> Inspect Code

另外，你可以通过 gradle 脚步指定自己的 lint 规则，以及报告生成路径

    android {
        lintOptions {
            abortOnError true
             lintConfig file("${project.rootDir}/config/quality/lint/lint.xml")
            // if true, generate an HTML report (with issue explanations, sourcecode, etc)
            htmlReport true
            // optional path to report (default will be lint-results.html in the builddir)
            htmlOutput file("$project.buildDir/reports/lint/lint.html")
        }
    }

`代码质量保证工具终究只是一些辅助手段，如何在项目开发过程中，保持持续高质量代码的输出更多的要依靠开发者自身对自己的要求，以及团队长期的技术文化建设上。`

## 持续集成

- [travis](https://travis-ci.org/)
- [jenkins](https://jenkins.io/index.html)
- [flow.ci](https://flow.ci/)

如果是开源项目可以使用 travis 进行持续集成，travis 跟 github 结合的特别好。使用起来也比较简单，如果你的开源项目已经跟 travis 结合成功，你可以使用下面的 bubble 代码为自己的项目加一个 bubble，方便在项目主页查看项目最新的编译状态。

    ![Build Status](https://travis-ci.org/maoruibin/TranslateApp.svg?branch=master)

效果如下

[![Build Status](https://travis-ci.org/maoruibin/TranslateApp.svg?branch=master)](https://travis-ci.org/maoruibin/TranslateApp)


如果是企业项目，还是自己搭建个持续集成工具比较好玩，嗯，就是 Jenkins。你可以按照 Jenkins 的安装文档在自己公司的内网环境下安装 Jenkins，然后就可以随意配置各种 task 。

另外，前段时间发现另一个国内的持续集成工具也不错，是在线形式的，类似 Travis， 叫做 [flow.ci](http://flow.ci/) ,比较有意思的是他有一个工作流的东西，比较好玩，而且跟 fir 天然支持。

## 生产力 / 效率

真实的团队项目开发是一个持续的过程，一个项目的生命周期有长有短，参与的人数有多有少，但即使比较短也可能要持续数月之久，所以一般的项目都需要花费不少时间精力。对于研发来讲，我们可以不关注效率方面的信息，使用最原始的工具、API 通过刀耕火种的方式完成开发，其实 Android 刚流行的时候，我们的开发确实是这样过来的，各方面的工具，开源方案较少。

但是经过 10 年的发展，Android 开发生态已经有了长足的进步和完善，包括开发工具、开源方案都已经非常完善，所以有必要在开发中留意并使用一些已经被其他团队证明可行的方案技术以及一些生产力工具。

下面列举一些对 Android 开发效率有提升的工具以及相关的东东。


### AndroidStudio Templete

项目开发过程中，随着开发框架的成熟，总会有一些代码经常重复性的编写，这时，你可以通过使用 AndroidStudio 的 templete 来快速生成代码。如新建 Activity, 现在大项目都会有一个 BaseActivity, 尽管 AS 也提供了 Activity 的模板，但是跟我们项目需要差别很大，所以，这时可以自定义自己项目的模板。

其实模板的适用范围特别大，不仅仅是 Activity 所有一些重复性比较强的模块类代码都可以使用自定义模板，这里的想想空间比较大，结合项目中的一些成熟的开发框架，你可以使用模板去把一些重复性的工作用模板完成。

至于如何自定义模板，网上的文章很多。

- [神奇的Android Studio Template \- Hongyang \- 博客频道 \- CSDN\.NET](http://blog.csdn.net/lmj623565791/article/details/51592043)



#### 参考链接

- [android\-guidelines/project\_and\_code\_guidelines\.md at master · ribot/android\-guidelines](https://github.com/ribot/android-guidelines)
- [Android\-Studio\-MVP\-template](https://github.com/benoitletondor/Android-Studio-MVP-template)

### AndroidStudio 插件

下面列举一些自己常用的 AS 插件。

#### GsonFormat

首推 `GsonFormat`， 这个插件我在 2015 年开始使用，简直是神器。尤其是自己已经手工写了很久的实体类后，当时发现这个插件后，欣喜若狂，具体它是干什么的，简单说，就是帮助开发者快速将服务端返回的一个 JSON 实体字符串转化为 Java 实体类的 AS 插件。具体可以查看项目主页。

[zzz40500/GsonFormat: 根据Gson库使用的要求,将JSONObject格式的String 解析成实体](https://github.com/zzz40500/GsonFormat)

#### ButterKnife

butterknife 是 JW 主导开发的一个 View 注入工具。它使用注解简单明了的替换传统的 `findViewById` ，还可以简化事件点击的监听等等，更多使用介绍可以看官网或者之前的一篇关于 ButterKnife 的介绍文章。

上面提到的这些用法只是让你提速，但真正意义的效率飞跃是使用它提供的 AS 插件 - ButterKnifer Zelezny，使用他后可以让你的 View 实例化从此自动化，工具化，无需手动码代码。

### 生产力/效率总结

在开发中，个人非常注重生产力效率。因为你的效率提升意味着你在同样的时间里产出就比别人多，侧面体现了你的价值比别人大，而这仅仅是因为你比别人会使用一个工具，多么神奇的结论。

使用工具后，在节省你工作时间的同时，从另一方面讲也是节省公司的人力成本，所以如果有工具可以提升自己的工作效率，那么我会非常乐意的分享使用它。

另外，对于效率的追求没有终点，你应该花点时间和心思去收集和整理一些效率工具，从而使自己的工作生活更加轻松。其实，如果你关注过一些大公司的话，在大公司里甚至会有一个专门的部门用于研究生成企业内部的生产力效率工具。可想而知，生产力/效率是一个多么重要的话题。

## 开源框架

选择合适的开源框架可以有效的避免自己重复创建轮子，所以项目中针对一个应用场景恰当的使用一些开源的大家比较任何的开源项目可以让开发事半功倍。

其实关于开源框架的选型，GitHub 上已经有很多项目做了总结，并且总结的很全面

* [UltimateAndroidReference](https://github.com/aritraroy/UltimateAndroidReference)

下面是自己整理出来的开源框架选型指导。

### 网络

- OkHttp
- Retrofit

### 数据库

- [LiteOrm](https://github.com/litesuits/android-lite-orm)
- [LitePal](https://github.com/LitePalFramework/LitePal)
- [sugar](https://github.com/satyan/sugar)
- [greenDAO](https://github.com/greenrobot/greenDAO)
- [Realm](https://realm.io/)

### 事件总线

- EventBus
- Otto

### 图片

- Glide
- Picasso
- Freso

### 网络解析

- [Gson](https://github.com/google/gson)
- [Jackson](https://github.com/codehaus/jackson)
- [FastJson](https://github.com/alibaba/fastjson)
- [HtmlPaser](https://sourceforge.net/projects/htmlparser/)
- [Jsoup](https://github.com/jhy/jsoup)

### Log 

- [logger](https://github.com/orhanobut/logger)
- [timber](https://github.com/JakeWharton/timber)
- [hugo](https://github.com/JakeWharton/hugo)

### 调试

- [stetho](https://github.com/facebook/stetho)

- [Chuck](https://github.com/jgilfelt/chuck)

- [TinyDancer](https://github.com/friendlyrobotnyc/TinyDancer)

- [AndroidPerformanceMonitor](https://github.com/markzhai/AndroidPerformanceMonitor)

- [BlockCanaryEx](https://github.com/lqcandqq13/BlockCanaryEx)

- [Battery-historian](https://github.com/google/battery-historian)]

- [Recovery](https://github.com/Sunzxyong/Recovery)(a crash recovery framework.)

  这里也有一篇国外的文章介绍了目前 Android 中比较有用的一些开发工具，具体可以查看[Android Development Useful Tools](https://blog.mindorks.com/android-development-useful-tools-fd73283e82e3)

### SharePreference

- [AptPreferences](https://github.com/joyrun/AptPreferences)
- [Esperandro](http://dkunzler.github.io/esperandro/)
- [Tray](https://github.com/grandcentrix/tray)

### 路由框架

- [ARouter](https://github.com/alibaba/ARouter)
- [AndRouter](https://github.com/campusappcn/AndRouter)
- [Android-Router](https://github.com/TangXiaoLv/Android-Router)


## 技术文档

在项目开发过程中，必然会涉及到团队成员的沟通，如何更好的沟通？QQ ？微信 ？？ 对于一般的非技术性的事务，这些桌面沟通工具确实可以很便捷的完成我们的需求，但是对于我们开发者，大多时候需要沟通一些技术上的问题，对于技术上这种非常严肃的问题，如果只是在群里讨论，粘代码会很容易把答案淹没，无法形成一个长久的记录。

所以，文档就显得特别重要。在实际开发中，不同的人负责的模块不一样，但是不论你负责那个模块，只要你的模块有可能为其他成员提供支持，那么你都应该写一份简单的使用文档，方便其他人在使用时，直接看你的文档就可以解决问题。

不至于其他人在用到你写的模块时，缅甸的同事在项目中搜索你在什么地方使用了相关的 API ，然后大海捞针般的搜到相关的代码后，一边阅读你的代码一遍思考怎么在自己的业务场景中使用。直率点的同事可能不顾你现在是不是忙工作，直接会发消息给你，询问相关 API 的使用，然后你的工作遭到打断，马上指点如何使用自己设计的 API。

然后这样的事情，一遍遍的发生在开发过程中，不同的同事遇到同样的问题，每次都是直接去询问当事人。

这是一种非常低效的开发模式。尤其是那种大项目，模块可能很多，这种问题也会很多。

所以，如果大家在开发自己的模块时，使用文档把一些技术要点简单罗列出来，然后把文档放在一个统一的地方，大家以后有问题，直接找文档，如果文档还没解决问题，再去找负责人，是不是会节省很多沟通成本。

关于文档，这里不仅仅是技术文档，开发中的文档有很多类型，下面列举一些文档。

### 技术说明文档

如上所述，就是典型的技术模块说明文档，应该包括简单明了使用说明以及一些特殊情况处理。

### 规范说明类文档

比如代码中的命名规范，提交规范等。下面是 GitHub 上自己的一些开源文档。

- [ribot 公司的代码规范](https://github.com/ribot/android-guidelines/blob/master/project_and_code_guidelines.md)
- [LoranWong/Android\-Code\-Style: A common Android coding style. 可在组内推行的Android代码规范](https://github.com/LoranWong/Android-Code-Style)
- [Blankj/AndroidStandardDevelop: 安卓开发规范\(updating\)](https://github.com/Blankj/AndroidStandardDevelop)


### 工具使用类文档

比如项目中一些开发工具使用说明。  

### 常用信息检索类文档

比如项目中的全局属性类介绍。

### 其他类

- [Commit message 和 Change log 编写指南 \- 阮一峰的网络日志](http://www.ruanyifeng.com/blog/2016/01/commit_message_change_log.html)
- [ruanyf/document\-style\-guide: 中文技术文档的写作规范](https://github.com/ruanyf/document-style-guide)


## 参考链接

- [Android通用流行框架大全 \- Android技术漫谈 \- SegmentFault](https://segmentfault.com/a/1190000005073746)
- [AndroidStudio好用的插件 \- Android技术漫谈 \- SegmentFault](https://segmentfault.com/a/1190000005092842)
- [从零开始的Android新项目11 \- 组件化实践（1） \| markzhai's home](http://blog.zhaiyifan.cn/2016/10/20/android-new-project-from-0-p11/)
- [cctanfujun/android\-tips\-tricks\-cn: 震惊！这么多的安卓开发Tips](https://github.com/cctanfujun/android-tips-tricks-cn)


