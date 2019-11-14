---
layout: post
author: 咕咚
title:  "Android 6.0 设备上自定义文本操作栏"
description: ""
catalog:    true
shang    :  true
tags: Skills
categories: tech 
---
该篇文章主要讲解 Android 6.0 设备上自定义文本操作栏。

通过以下文章你会学习到以下几点。

* 什么是 Android 设备上的文本操作栏
* 如何在 Android 6.0 设备上为自己的 App 自定义文本操作

首先说说什么是 Android 设备上的文本操作栏。

## 文本操作栏

我们在平时使用手机的过程中，总是避免不了去操作一些文本，比如常见的复制、粘贴等功能。

一般我们只需要长按输入框内或者网页上的文本，系统即可弹出一个文本操作栏 ，上面会显示复制、粘贴、剪切等操作按钮 ，如下图所示。

<img src="http://upload-images.jianshu.io/upload_images/588640-fa2869c8f881efbb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" style="width:50%;"/>

这就是文本选择操作栏，但是一直以来，这个操作栏上面的按钮都是系统级别的，通过一般的方法是不能去自定义该操作栏上面的按钮的。

比如说，你做了一个翻译 App，为了更好的用户体验，你想让用户长按英文单词后，在这个系统文本操作栏上显示一个自定义的翻译按钮，然后用户点击这个按钮后，就可以直接查询网络释义，显示单词解释，那将是多么友好的用户体验。

但是这在 6.0 之前的 Android 设备上都是无法实现的，因为 Android 没有提供相关的 API 供开发者自定义文本操作按钮。

直到 Android 6.0，Android 开始支持在文本操作栏上自定义操作按钮 ，开发者可以根据自己 App 的需要，为自己的 App 自定义文本操作按钮。

这不，去年年初我发布了一款自己开发的软件 — [咕咚翻译](https://github.com/maoruibin/TranslateApp)，咕咚翻译是一个手机上用于划词翻译的开源 App，长按文本后选择复制操作，咕咚翻译即可 以悬浮窗的形式展示单词释义，如下所示。
![demo](http://upload-images.jianshu.io/upload_images/588640-bb21211def7c14a3.gif?imageMogr2/auto-orient/strip)

后来发布市场不久后，就有人在市场上建议我适配 6.0 的新 API 。

![Paste_Image.png](http://upload-images.jianshu.io/upload_images/588640-850ee20a4705b9fa.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


当时还不知道 Android 6.0  已经可以支持自定义文本操作按钮，但是一经提示，我觉得这个 API 确实很适合咕咚翻译的应用场景。

之前的咕咚翻译，用户都是选择复制操作后，App 监听系统粘贴板然后进行查词，算是通过一种取巧的方式完成了划词翻译功能。但是如果使用自定义文本操作 Action，那么用户是使用时可能更加容易接受这样的操作。

所以后来便实现了自定义文本操作栏 Action。

## 自定义文本操作栏按钮 

> 注意：以下操作只支持 Android 6.0 及以上设备

首先，既然自定义文本操作栏按钮，那么拿到用户选择的文本后，就需要一个可以处理文本的组件。这里 Android 定义使用一个 Activity 去完成这个处理操作。

> 注意，可能有人会想使用 Service 处理获取到的文本，这里 Android 对这个处理组件做了限制，只能使用 Activity。

### 创建处理文本的 Activity

这里我们给处理文本的 Activity 起名叫 `ProcessTextActivity`，接着创建Activity，比较简单。


![Paste_Image.png](http://upload-images.jianshu.io/upload_images/588640-1fd5c3a336de7e5f.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


这里通过一个名为 `Intent.EXTRA_PROCESS_TEXT` 的 key 来获取用户选择的文本，可以看到获取文本很简单。拿到文本后，这边就可以对文本做操作了。

但是别忘了，Android 中每个使用到的 Activity 都需要注册，但是这个 Activity 的注册跟一般的 Activity 不一样。如下所示

### 注册自定义文本处理 Activity


![Paste_Image.png](http://upload-images.jianshu.io/upload_images/588640-47f558b05973e28e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


可以看到上面跟一般 Activity 注册不一样的地方就是 Intent Filter 的配置。这里的配置写法是固定的，表示这个 Activity 用于处理用户从文本操作栏点击自定义按钮后的操作。

然后自定义的文本选择操作就完成了。

至于拿到文本后怎么操作，那就看自己 App 的需求了。示例中的咕咚翻译是拿到文本后去请求公开的翻译 API 去翻译文本，然后以悬浮窗的形式显示出来，如下所示。

![Paste_Image.png](http://upload-images.jianshu.io/upload_images/588640-a102e5d23a4cd5a2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

当然，由于自定义文本操作栏按钮是 Android 6.0 设备上才有的 API ，所以 6.0 之前的设备上咕咚翻译还是采取了监听粘贴板来达到划词翻译的效果。

如果对源码感兴趣，因为咕咚翻译是一个开源 App ，你可以随意查看源码实现。链接如下

[https://github.com/maoruibin/TranslateApp](https://github.com/maoruibin/TranslateApp)

可能还有一些细节文中没有提到，大家可以查看参考链接对应的一篇译文。

## 参考链接
* [自定义文本操作栏的方法文档地址](http://developer.android.com/reference/android/content/Intent.html#ACTION_PROCESS_TEXT)

* [使用ACTION\_PROCESS\_TEXT来创建自定义的文本选择操作 \- 泡在网上的日子](http://www.jcodecraeer.com/a/anzhuokaifa/androidkaifa/2016/0116/3877.html)