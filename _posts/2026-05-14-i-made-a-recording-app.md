---
layout: mypost
author: 咕咚
tags: 'daily'
categories: blog
title: "我做了一个录音 App"
---

![封面](https://gudong.s3.bitiful.net/weimd/cover.png)

五一前有一次打电话需要录音，手边没有录音软件，就从应用市场随便下了一个。录完之后需要转成文字，正当我要导出的时候——收费。

花了 11 块钱导出一个录音。当时就想，这也太坑了，自己做一个吧。

### 为什么做

市面上录音软件很多，我以前也想过开发，但觉得没什么难度，一直没动手。这次是被 11 块钱逼的。

因为 AI 开发很快，确实没用多久就做出来了。当时 API 套餐的 token 也用不完，很快就搞定了。

### 录音 + 转文字

一开始只是简单做了个录音界面，后来发现光有录音还不够。录音要能自动转成文字才方便。

市面上类似的 App 都有这个功能，但比较费钱，因为语音转文字的 API 要收费。我问了 AI 用什么好，它推荐了阿里云。去阿里云后台注册、添加项目、申请 API，全程让 AI 帮忙集成进去。

阿里的费用不贵，速度很快，准确性也高。之前也对接过讯飞，但使用起来有点费劲。这次全程 AI 搞定。

### 再加个 AI

录音转出来的文字都是口语化的，我说"嗯""啊"全在里面。想着能不能让 AI 再处理一下，把口语化的内容整理成更通顺的文字。

于是又加了个 AI 功能，支持两个引擎：智谱和 DeepSeek。很快就搞好了。

### 录音咚

App 叫"录音咚"，图标我很喜欢。



目前功能还比较简单：录音、转文字、AI 处理、分类、标记、倍速。

### 怎么用

这个 App 我打算自己先用一段时间。因为 API 要收费，太多人用费用我承担不起。

不过我发现一个特别好的使用场景——对着它说话，写日记、记录想法。之前在笔记工具里也有这个需求，但总觉得别扭。现在直接在录音 App 里记录，主体是录音，留下的都是我的声音，感觉更合适。

以后每天想写日志，直接在这里录就行。

另外，今天这篇文章的录音稿，就是用录音咚录的。之前用微信输入法，说完语音资料就留不下来。现在通过录音咚，录音都能保留下来了。

如果有兴趣试用的同学，可以加我微信交流。后面有什么动态，也会在公众号说。

**相关阅读**

- [让笔记不再石沉大海](https://mp.weixin.qq.com/s/YK9Ju70XS73wW-93Kur1aw)
- [inBox 笔记 2.3.3：一个人 + AI，两周 32 项更新](https://mp.weixin.qq.com/s/mhVirAa1vEGLPxW63NKE4A)
- [普通人也可以用上 inBox 笔记的 API 了～](https://mp.weixin.qq.com/s/WpvyG6YEB5vE9oKfS0QGUw)


---

**关于咕咚**

inBox 笔记作者，独立开发者。每天用 AI 约 8 小时，每天在公众号和博客写作。

我的作品：
- [inBox 笔记](https://doc.gudong.site/inbox) - 本地笔记，数据自主
- [点亮](https://doc.gudong.site/light/) - 打卡软件，记录坚持
- [咚力圈](https://mp.weixin.qq.com/s/JZM1emcSuehKqzcg3iFZjQ) - AI 实践社群，一起搭建个人智能助手
- 公众号「咕咚同学」- 每天更新，记录思考与实践

关注我：
- 即刻：[咕咚同学](https://okjk.co/l8IUzO)
- 博客：[blog.gudong.site](https://blog.gudong.site)

<img src="/assets/profile/gongzhonghao.jpg" width="200" alt="公众号二维码" style="display:block;margin-left:0;">
