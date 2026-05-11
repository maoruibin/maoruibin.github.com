---
layout: mypost
author: 咕咚
tags: 'daily'
categories: blog
title: "token 焦虑又又没了"
---

![封面](https://gudong.s3.bitiful.net/weimd/cover.png)

4 月 27 号，给智谱的套餐做了续费，续了一年的 Max 套餐。一年 4500 还是有点高，所以这次跟一个朋友合租，两个人一起用。

先说下 Max 套餐的限制。它有两个额度：一个是 5 小时额度，5 小时内用超了就得等；另一个是周额度，一周的总量用完也得停。之前我一个人用的时候，最多就是把 5 小时的额度用完过。但这次合租之后，两个人一起用，昨天写着写着需求，发现一周的额度也快见底了。后来继续用，最终彻底用完。恢复时间是 5 月 11 号，也就是今天上午 11 点。

来说说这次用完的主要原因——Superpowers。

这是今年出来的一个 Claude Code 插件，给 AI 加上了软件开发的工作流程和最佳实践。它让 AI 像资深开发者一样工作，有设计文档、任务拆解、测试驱动开发、代码审查等环节。

不再是拿到需求就开始写代码，而是：

讨论需求 → 写设计文档 → 拆解任务 → 写代码 → 跑测试 → 审查

每一步都有检查点。

它有 15 个技能模块，会在合适的时候自动触发。比如 brainstorming 会通过提问理解需求，subagent-driven-development 会启动多个子代理并行工作，test-driven-development 会强制先写测试。你不用手动调用，它们自己会跳出来。

整套流程下来确实很科学。但代价就是——特别费 token。

我是真的深刻体会到了。用的时候感觉很爽，尤其在做具体需求的时候，比如我想给应用加上备份和还原能力，本来是个挺模糊的需求，Superpowers 会先进行头脑风暴，收集我的信息，跟我确认具体要做什么；确认完之后写一个实施计划；我阅读确认后，它就开始拆解任务，用多个不同的 Agent 去执行，甚至还会包含测试环节。

但 token 真的是哗哗地烧。

昨天上午额度用完之后，还有很多功能要做，我就开始想办法。本来想借用朋友的 token，但不太合适。后来发现 Android Studio——谷歌那个官方安卓开发工具，它自带的 AI 升级后挺好用的，支持 Agent，速度也快。如果你做安卓开发，可以考虑用这个。

另外也试了 Solo，理论上能编程，但一言难尽——太慢了。它有个高速通道，999 一个月，我真想不通这个定价是怎么定的。用免费模型的话，速度慢得离谱。

总之，昨天因为 token 用完，小项目就停摆了。今天上午 11 点恢复之后，又可以继续干活了。但后面还是觉得，token 得省着用，不能像以前那样放开了用了。

所以我现在也开始优化用法了。复杂任务用 Superpowers 的完整流程，普通任务就用快速模式，不再什么都走完整流程。省着点用，细水长流。

**相关阅读**

- [token 焦虑又没了](https://blog.gudong.site/2026/04/28/token-anxiety-gone.html)
- [token 在燃烧](https://blog.gudong.site/2026/03/10/burning-token.html)


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
