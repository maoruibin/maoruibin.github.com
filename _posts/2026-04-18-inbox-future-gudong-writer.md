---
layout: mypost
author: 咕咚
tags: 'daily'
categories: blog
title: "inbox-future-gudong-writer"
---

最近这段时间一直在频繁更新 inBox 笔记，越更新越觉得不够好。

很多细节、体验、设计，还有很大的提升空间。

先说数据同步吧，这段时间花了不少时间在优化，重新设计了一套新的同步方案——原子数据格式，一篇笔记一个 JSON 文件。我自己对这个方案还挺满意的，也是一个会长期坚持的方案。

说实话，这个方案是我跟 AI 一起聊出来的。当时让 AI 去分析研究市面上其他本地笔记软件的做法，给出建议，后来就一起设计了这套方案。

目前数据同步已经比较 OK 了，但与此同时发现标签、关联笔记、批注这些核心功能还有很多可以优化的地方。图片存储也一直被很多用户吐槽，确实可以做得更好，后面还会继续花时间去优化。

另外想聊聊 inBox 笔记跟 AI 的一些思考。

最近很多关注笔记的同学应该都知道了一个东西叫 LLM Wiki，这是 Andrej Karpathy（OpenAI 联合创始人之一）提出的一套本地知识库方案。我对这个方案也很感兴趣，也在思考 inBox 笔记能不能借鉴 LLM Wiki 的一些做法。

当然到现在还没想太清楚，后面会专门开一个分支去思考这件事。

我想让 inBox 笔记里存下的数据，能够持续给我们带来灵感上的碰撞，让笔记成为一个活的系统。

其实 inBox 笔记从一开始我就很注重回顾，很注重历史笔记的展示。第一个页面是记录，第二个页面就是回顾。但回顾的方式一直比较简单，只是把过去的笔记通过规则筛选出来，像刷抖音一样划着看，我觉得还不够。

LLM Wiki 最核心的思路，是用 LLM 对原始知识库做原子化的映射，动态维护一个 Wiki，把笔记数据交给本地 AI 智能体去管理。inBox 笔记也是一个本地笔记软件，理论上可以借鉴这种思想，对每一条笔记建立一个 Wiki，更好地展示笔记之间的相关性。

具体怎么做现在还没有想清楚，如果大家对这方向有兴趣，欢迎私信我交流。

以上就是这两天对 inBox 笔记未来的一些想法，后面会基于这些继续重新思考 inBox 笔记的方向。

**相关阅读**

- [inBox 笔记的下一步](https://mp.weixin.qq.com/s/mhVirAa1vEGLPxW63NKE4A)
- [当 AI 有了记忆](https://blog.gudong.site/2026/04/09/when-ai-has-memory.html)


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
