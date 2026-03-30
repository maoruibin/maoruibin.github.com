---
layout: mypost
author: 咕咚
tags: daily
categories: blog
title: "小龙虾（OpenClaw）到底是不是 AI？"
---

这两年，在技术圈，各种新概念、新技术层出不穷。

但在跟不少朋友交流的过程中我发现，很多人对这些五花八门的概念，其实并没有建立起一个清晰的坐标系。

比如有人就会问："小龙虾也是 AI 吗？它跟豆包、DeepSeek 到底是什么关系？"

所以我今天想单独写篇文章，梳理一下它们之间的关系，帮你快速建立一个正确的认知。

首先抛出结论：**小龙虾不等于 AI。**

小龙虾本身并不智能，它终究只是一个运行在电脑上的应用程序而已。它到底有多聪明，完全取决于我们给它配置了什么底层的 AI 模型。

但这就会引出很多人的下一个疑问：既然它不是大模型，为什么现在大家都要折腾着往自己的电脑里装一个小龙虾？直接用 DeepSeek 不行吗？打开手机用豆包不香吗？为什么偏偏是它？

为了把这个问题讲透，我们需要搞懂 AI 时代的两个核心概念：**大脑（智商）** 与 **爪子（动手能力）**。

### 1. 大脑 vs 爪子

像 DeepSeek、GPT-4 这样的基座模型，就是拥有极高智商的"超级大脑"。

但问题是，大脑被关在机房的小黑屋里，它没有手脚，只能通过网线陪你聊天。

像豆包这样的消费级应用，就像是一个温柔的"前台客服"，它能听懂你的话，去问大脑，再把答案告诉你。但它的能力边界，被死死锁在了那个聊天框里——它碰不到你电脑里的文档，看不了你的代码。

而小龙虾，就是给这个"超级大脑"安装了一堆可以干活的"爪子"。

### 2. 小龙虾是怎么工作的

当你在小龙虾里输入一个需求时，中间其实发生了一件非常巧妙的事情：

小龙虾每次去跟背后的 AI 沟通时，不仅会带上你的问题，还会把自己拥有的所有"技能卡（Tools/Skills）"一起甩给 AI，并告诉它："你看，这是我能调用的所有工具，你看着办。"

AI 这个超级大脑接收到信息后，就会根据你的问题进行推理和决策，然后反过来告诉小龙虾："我懂了，现在你先去调用 A 工具，再调用 B 工具。"

这样一来，AI 提供了智慧和决策，而具体的工具都在你的电脑本地执行。

### 3. 有了爪子，大脑能干什么

有了这些爪子，大脑就真的可以借助小龙虾开始"搬砖"了。

比如写文章、做 PPT、写代码。更强大的是，它可以结合电脑里各种各样的命令行（CLI）工具，极大地扩展 AI 原本被束缚的能力：

- 调用 CLI 去查邮件、查天气
- 钻进你本地的数据库里去跑查询
- 自动帮你写日志、查日历日程

这些曾经 AI 绝对触碰不到的本地领地，现在全部被彻底打通了。

### 4. 不止小龙虾

其实如果你看透了这个本质，就会发现目前市面上最前沿的那些"干活神器"，底层逻辑都是一样的。

比如最近极其惊艳的 Claude Code、Claude Cowork，以及腾讯最近推出的 WorkBuddy。

它们本身都不生产智能，它们都是把"智能"外包给了 ChatGPT、Claude、Gemini 这些大语言模型。

它们真正在做的，是在你的电脑端铺设了一整套"工具层"，让云端的 AI 大脑有能力调用本地的技能去干活。

### 5. 别把它当聊天机器人

最后，我想补充一个我重度使用小龙虾后的真实感悟：**千万别把它当成普通的聊天机器人。**

很多人装了小龙虾之后，还是习惯性地问它各种日常问题，然后抱怨："它怎么回复得这么慢？"

这就大错特错了。

既然小龙虾的定位是"干活"，那就必然意味着它在速度上会慢一点。因为它在后台需要去调用工具、读取本地数据、执行代码，然后再把结果整合给你。

干活和快速对话，完全是两码事。如果你只是想快速查个百科、问个简单问题，那最正确的做法是直接打开网页去用 DeepSeek，或者打开手机用豆包。

对于小龙虾这类的智能体，正确的打开姿势应该是：审视一下自己的日常工作场景，找出那些繁琐的、重复的事情（比如做深度的长文分析、生成日报报告，甚至是一些需要定时跑的自动化任务），然后试着搞一个 Skill（技能），把它塞进小龙虾里。

让它在后台慢慢跑，这才是真正的"赛博外包"。

### 6. 门槛确实有点高

不过话说回来，小龙虾目前的上手门槛相对还是有些高，安装和配置环境可能会劝退一部分非技术同学。

如果国内的朋友想体验这种"AI 智能体直接帮你干活"的爽感，我比较推荐试试国内的一些可视化 AI 工具，比如腾讯的 WorkBuddy。

至于它具体怎么用，我后面会单独再写一篇文章来详细介绍。

---

**总结一下：**

过去两年，我们一直在惊叹 AI 多么会"聊天"；但现在的趋势，是 AI 终于长出了爪子，开始真正"干活"了。

理解了这一点，你才算真正拿到了下一代 AI 工具的入场券。

---

**相关阅读：**

- [从飞书开源 CLI，聊聊 GUI 和 CLI](https://mp.weixin.qq.com/s/VsxXsQ9WW0sfL3LXTs-7dQ)
- [打了会球，顺便开发了1个APP，小龙虾，真牛](https://mp.weixin.qq.com/s/iw_jGuYoh9x0un8LWZbqtw)

<section style="margin: 15px 0 8px; padding: 10px; background: #f0f4f8; border-radius: 6px; border: 1px solid #e1e8ed;">
<strong style="font-size: 14px; color: #333;">关于咕咚</strong>
<br/>
<span style="font-size: 12px; color: #666;">独立开发者，每天用 AI，在这里分享真实心得。</span>
<br/><br/>
<div style="padding: 6px; background: #fff; border-radius: 4px; border: 1px solid #e8e8e8; margin-bottom: 8px;">
  <span style="font-weight: 600; font-size: 13px; color: #333; display: block; margin: 0; padding: 0;">
    <a href="https://mp.weixin.qq.com/s/l-EZl5MsXh-Y4uTbPAy80Q" style="color: inherit; text-decoration: none;">📝 inBox 笔记</a>
  </span>
  <span style="font-size: 11px; color: #888;">本地优先，记录灵感与想法</span>
</div>
<div style="padding: 6px; background: #fff; border-radius: 4px; border: 1px solid #e8e8e8; margin-bottom: 8px;">
  <span style="font-weight: 600; font-size: 13px; color: #333; display: block; margin: 0; padding: 0;">
    <a href="https://mp.weixin.qq.com/s/JZM1emcSuehKqzcg3iFZjQ" style="color: inherit; text-decoration: none;">🦞 咚力圈</a>
  </span>
  <span style="font-size: 11px; color: #888;">小龙虾实践社群</span>
</div>
<span style="font-size: 11px; color: #666; display: block; padding-top: 8px; padding-bottom: 8px; border-top: 1px solid #e0e0e0;">重复的事交给 AI，把时间留给自己 · 关注我一起探索「小龙虾」的实践</span>
</section>
