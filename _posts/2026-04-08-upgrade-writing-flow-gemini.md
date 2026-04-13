---
layout: mypost
author: 咕咚
tags: daily
categories: blog
title: "升级写作流：让小龙虾自动操作浏览器找 Gemini 润色"
---

![封面](https://gudong.s3.bitiful.net/weimd/cover-writing-flow.png)

今天我继续升级了一下自己的写作流程，主要还是用小龙虾去写，我之前的文章中提到过，说我现在已经到了第三阶段，完全是用小龙虾去进行自动化写作。

但我其实对比过几次，发现我的录音稿转成最终的文字效果，还是 Gemini 润色得更好，我用的是 Gemini 3.1 的模型，直接在 AI Studio 上跑几乎是免费的，所以我就在想，怎么用小龙虾配合 Gemini 去做我文章的录音润色。

其实方法有很多，一开始我想到的是最简单的 API 方式，给我的写作智能体直接配一个 Gemini 的模型，但我试了之后发现效果一般，感觉还是没有在网页里直接对话的效果好，所以昨天晚上我突然想，干脆直接写一个 Skill，让智能体去模拟人工操作浏览器。

现在只要我把录音稿发给智能体，它就会自动打开 AI Studio 的网页，把录音稿输入到聊天框里，自动点击发送按钮，然后等待生成，生成完之后再提取网页里的内容，拿回到智能体里继续走我之前的发布流程，绕了一圈发现这样跑下来效果还挺好的。

在写这个操作浏览器的 Skill 时，一开始老是失败，即使能把内容输入到网页聊天框，也总是获取不到最终的返回结果，后来我就想了个办法，把我之前写的自动发微博、发推特的 Skill 文件发给 AI，让它去学习参考，它学了一会儿就领悟到怎么弄了，所以有时候 AI 犯错或者卡壳的时候，我们给它提供一些成功的代码做参考，它就能更好地解决问题。

如果后面没什么问题的话，我的录音稿润色还是会继续交给 Gemini 去完成，它润色的效果确实更加符合我的个人要求，以上就是我今天折腾出来的最新录音润色方案。

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
