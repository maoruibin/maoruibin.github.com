---
layout: mypost
author: 咕咚
tags: 'inBox 笔记'
categories: blog
title: "inBox 笔记更新：支持导出 PDF，多选不闪了"
---

inBox 笔记更新了一个新版本，主要做了一件事：支持导出 PDF。

说来也巧，这个功能以前真没想过做。但最近有好几个用户提到，说想把笔记导出成 PDF 分享给别人。我一想，确实需要。

本来以为做 PDF 导出得引入一个不小的第三方库，后来调研了一下，发现 Android 官方就有现成的 API，直接拿来用就行。**安装包一点都没变大**，功能还做了。

顺便说一句，Word 导出没做。不是不想做，是如果支持 Word，安装包体积得翻一倍，我觉得不划算。PDF 已经能满足大多数分享场景了。

第二个想说的是多选体验。

之前在主页多选笔记的时候，每点一下卡片就会闪一下，体验不太好。这次花了点时间，让 AI 帮忙定位，发现是每次选中都会把整张卡片重新渲染一遍。现在改成只更新选中状态的边框，点起来顺畅多了。

顺手还修了几个小问题：批注数量有时候显示不一致，这次把渲染逻辑重构了一下；详情页右下角的按钮也调成右对齐了，看着更舒服。

另外，最近 618 有活动，买断有优惠，想上车的可以趁现在。

![618 活动](https://s3.bitiful.net/gudong/images/inbox-239-release/618-activity.png)

详细的更新内容看下面的日志截图吧。

![更新日志截图](https://s3.bitiful.net/gudong/images/inbox-239-release/inbox-update-log.jpg)

---

**关于咕咚**

inBox 笔记作者，独立开发者，每天用 AI 约 8 小时。

我的作品：

- ✍️ [inBox 笔记](https://mp.weixin.qq.com/s/l-EZl5MsXh-Y4uTbPAy80Q) — 本地优先，隐私安全
- 🦞 [咚力圈](https://mp.weixin.qq.com/s/JZM1emcSuehKqzcg3iFZjQ) — AI 实践社群，一起探索

感谢阅读，如果觉得不错，欢迎点赞和爱心～想第一时间收到推送，也欢迎设为星标⭐
