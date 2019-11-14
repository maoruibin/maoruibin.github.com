---
layout: post
author: 咕咚
title: "Flutter 概览"
description: "Flutter 是谷歌今年初推出并开源的一套移动跨平台开发框架，相比其他跨平台方案，Flutter 使用自己的渲染引擎做到了真正的跨平台，这篇文章简单介绍一下 Flutter，算是自己最近学习的一个简单总结。话说现在文章写得越来越少了... "
catalog: true
cover-color: "#60caf6"
shang: true
qrcode_mp: true
author: gudong
categories: tech
tags: Skills Dart Flutter
---


## Flutter

[Flutter](https://flutter.io/) 是 Google 开发并开源的一套**跨平台移动开发框架**，它使用 [Dart](http://dart.goodev.org/guides/language) 语言进行应用层的开发，一套代码可编译出 iOS、Android 双平台的应用包。

Flutter 拥有出众的开发体验，支持热重载。同时提供了一整套丰富、灵活、有表现力的 UI 组件。Flutter 使用 Native 引擎进行视图渲染，小组件提供完整的原生性能。



## 框架介绍

Flutter 框架整体分为两层，包括上层的应用层以及底层的 Engine 层，应用层主要使用 Dart 语言开发，Engine 层使用 C++ 开发，整体框架图如下所示：

![](https://ws3.sinaimg.cn/large/006tNbRwgy1fxon9qzhwuj315s0p6t8x.jpg)

> 图片来自：flutterchina.club

**Flutter Framework**: 这是一个纯 Dart实现的 SDK，Dart 之于 Flutter 就像 Java 之于 Android。这一层用 Dart 实现了一套基础库 ，用于处理动画、绘图和手势等，并且基于绘图封装了一套 UI组件库，然后根据 `Material` 和`Cupertino`两种视觉风格区分开来。这个纯 Dart实现的 SDK 被封装为一个叫作 `dart:ui`的 Dart库。我们在使用 Flutter 写 App 的时候，直接导入该库即可使用组件等功能。

**Flutter Engine**: 这是一个纯 C++实现的 SDK，其中囊括了 Skia 引擎、Dart运行时、文字排版引擎等。不过说白了，它就是 Dart的一个运行时，它可以以 JIT、JIT Snapshot 或者 AOT的模式运行 Dart代码。在代码调用 `dart:ui`库时，提供 `dart:ui`库中 Native Binding 实现。 不过别忘了，这个运行时还控制着 VSync信号的传递、GPU数据的填充等，并且还负责把客户端的事件传递到运行时中的代码。 

> 源引：stephenwzl.github.io

看完了 Flutter 的大体概况，下面从 UI 、网络、线程三个方面分别聊聊 Flutter。

### UI

在 Flutter UI 设计中 ，**“Everything’s a Widget ”**，Widget 是 Flutter 构建界面的基本元素，除了通常意义上的 Button、TextView 等，在 Flutter 中控制居中、设置 Padding、甚至点击事件都是通过 Widget 实现的，下面就是一个简单实例：页面居中显示一个 Text。

![](https://ws2.sinaimg.cn/large/006tNbRwly1fxpdu2vbnvj318c0u00tm.jpg)

如上所示，整个页面是 HelloPage 就是一个 Widget，继承自 StatelessWidget，这个类只有一个重要的方法 build()，他用来返回页面显示对应的 Widget，可以看到 Widget 是一种树结构，通过嵌套来组织布局，有点像 Android 中的 ViewGroup。

关于 Widget，它是组织 UI 的关键元素，大部分时候我们都需要去用它进行页面制作，需要注意的是在 Flutter 中 Widget 分为两种，即**不可变、没有状态的 StatelessWidget**，以及**有状态可更新的 StatefulWidget**。

怎么理解？什么是不可变、没状态？ 一些页面或者元素没有任何交互，比如一个 Text，给定了文字内容，对于 Text 这个 Widget 就不会发生变化了，所以他就是一个 StatelessWidget，而对于一些组件，如输入框、选择器…他们在使用过程中根据交互，UI 会发生变化，这样的 Widget 就是 StatefulWidget。Flutter 推荐在可使用 StatelessWidget 的情况下尽可能使用 StatelessWidget，因为他有更好的性能。

但是应用开发中，很多情况下我们还是要使用 StatefulWidget，在使用 StatefulWidget 时，如何更新 UI 状态呢，具体可看 [小部件简介-更改小部件以响应输入](https://flutter.io/docs/development/ui/widgets-intro#changing-widgets-in-response-to-input)。

另外在 Flutter 中所有的界面都是不可变的一部分，每次更新时都会重建 Widget 树结构进行渲染，只是这里 Flutter 会有一套自己的 diff 算法，尽可能执行最小更改，所以页面使用越多的 StatelessWidget，渲染性能也就会越好，当然也好因地制宜。

关于 Flutter 的渲染，他跟其他的跨平台方案不一样，直接在应用框架层加入了自己的跨平台渲染引擎-skia，这样就完全接管了应用的绘制，Flutter 的绘制过程直接跟设备的 GPU 对话，完全跳过了平台的 UI 那层东西，所以说 FLutter 才是真正的跨平台方案。

在运行期，Flutter 会把自己的 Widget 树结构转化为 RenderObject 的树结构，这个树结构是真正的渲染树。



### 网络请求

得益于 Dart 语言的特性，利用 Flutter 进行网络请求很简单，可以利用 `http`包进行各种各样的网络请求，如下是一个简单的 Get 请求示例：

```dart
import 'package:http/http.dart' as http;

var url = "http://example.com/whatsit/create";
http.post(url, body: {"name": "doodle", "color": "blue"})
    .then((response) {
  print("Response status: ${response.statusCode}");
  print("Response body: ${response.body}");
});
```

更多关于网络请求的内容可参看 [在 Flutter 中发起 HTTP 网络请求](https://flutterchina.club/networking/)



### 线程

Flutter 是单线程模型，这块是由 Dart 语言所决定的，Dart 支持良好的单线程模型，并提供了多种异步操作的方法。具体参看 [dart：异步库 \- Dart API](https://api.dartlang.org/stable/2.1.0/dart-async/dart-async-library.html)。

## 总结

Flutter 提供了一套彻底的移动跨平台方案，核心在于自己的渲染层设计，目前看来，Flutter 野心很大，同时它也提供了非常丰富的文档支持，如果是自学，把官网的文档看一篇基本就可以进行正常的开发了。跨平台开发一定是未来的趋势，我们应该拥抱变化。另外学习应用把握核心知识点，关于 Flutter，我们一定要花时间精力去搞清楚它的渲染绘制原理。

## 参考链接 / Flutter 好文

- [Flutter原理简解 · stephenwzl](https://www.stephenw.cc/2018/05/14/flutter-principle/)
- [Flutter \- 不一样的跨平台解决方案 \- 掘金](https://juejin.im/post/5afd77466fb9a07aab2a12da)
- [Flutter · 闲鱼技术 · 语雀](https://www.yuque.com/xytech/flutter)