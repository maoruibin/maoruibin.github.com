---
layout: mypost
author: 咕咚
tags: daily
categories: blog
title: "token 在燃烧"
---

首先让大家看一个数字：103,558,892。

一亿零三百五十五万八千八百九十二。

大家可以猜一下，这是什么数字？

这是我今天一天花掉的 token 数量。

![图 1：智谱 Coding 后台截图，显示今日 token 用量](占位符：智谱后台截图)

先说说 token 是什么。

之前我写过一篇文章介绍过，AI 大模型的计量单位就是 token。它按照字符去切割，正常一个汉字大概 1 到 2 个 token，英文的话一个单词大概是一个 token。这样大家对 token 就有一个大概的概念了。

### 1. 一亿 token 是怎么花的

我之前其实没有怎么算过自己一天的用量。

昨天看的时候，后台有个统计是最近 7 天，我看了一下也才一个亿左右。结果今天一天就用了这么多。

我想了一想，这一天我都干了什么。

从早晨到晚上，在家里做自己的项目：研究 Skills、做 [inBox 笔记](https://mp.weixin.qq.com/s/l-EZl5MsXh-Y4uTbPAy80Q)（手机端和客户端）、写代码、做封面图（我的封面图都是用 HTML 做的）。

到了公司，用 AI 设计技术文档、读代码、实现代码方案，还会调用 MCP 去执行一些事情。

总之，所有这些事情加起来，无论是业余还是工作，我全天候基本都在用 [Claude Code](https://mp.weixin.qq.com/s/tSnxzIxljuRSS-r8xaUzSA)。

不论是写文档、写代码，还是写文章，我现在基本都用它完成。

所以我之前没什么概念，今天一看一天到一个亿，真的是很夸张的一个数字。

### 2. 算一下这笔钱

后来我就想算一下，按照正常计费，这一天这么多 token，如果用各家 AI 模型厂商的官方价格，大概要花多少钱。

算下来之后，真的是让我大吃一惊。

token 分为输入和输出。我发给 AI 的文字，和 AI 响应我的内容，都算 token。我就按输入 25%、输出 75% 这个比例去算：

**103,558,892 Token**
- 输入：25,889,723 Token
- 输出：77,669,169 Token

**1）OpenAI GPT-4o（当前主流）**
- 输入 $2.5 / 1M，输出 $10 / 1M
- 合计约 $841.42 / 天
- 人民币约 ¥6,058 / 天

**2）DeepSeek V3（国内性价比）**
- 输入 ¥2 / 1M，输出 ¥8 / 1M
- 合计约 ¥673.13 / 天

**3）Claude Opus 4.6（最贵）**
- 输入 $5 / 1M，输出 $25 / 1M
- 合计约 $2,078 / 天，约 ¥14,963 / 天

也就是说，如果用 OpenAI 的 GPT-4o，这一天要 6000 块；用 DeepSeek，成本算低的，也得 670 块一天；如果用 Claude 的 Opus（最好的模型），算起来是 15000 块一天——我用的就是 Opus。

![图 3：一天 1 亿 Token 的成本对比](占位符：AI 生成价格对比图)

看到这个数字，我真的觉得是天文数字。

### 3. token 在燃烧的感觉

其实我整天高强度用 AI 的时候，有种感觉：token 在燃烧。

因为使用的时候，我会把大段的内容发给 AI。

比如开发 [inBox 笔记](https://mp.weixin.qq.com/s/l-EZl5MsXh-Y4uTbPAy80Q) 时如果有报错，我会把报错日志发给 AI，那些日志有时很长。数据同步的日志，我可能两三百行一下子都拷给 AI 了。

让 AI 生成封面图，我都是让它用 HTML 生成，它要生成代码，也是巨量的文字字符。还有生成代码、生成文档、读代码，这些都是大量的字符。

当我发送一长串 token 过去，AI 再响应我，我觉得这个过程很疯狂。

最直观的感觉就是：token 在燃烧，烧的都是钱。

![图 4：Token 燃烧概念图](占位符：AI 生成 token 燃烧图)

![图 2：智谱后台显示用量仅占额度的 5%](占位符：智谱后台额度截图)

不过，我用这么多 token，也只占额度的 5%。

也就是说，我其实还有大量额度没有用到。

所以我能明显感受到，大模型厂商现在在疯狂烧钱。当然这个也不是我最关心的。

### 4. 放开手脚用最好的

我个人觉得，在这个时代，如果你有使用 AI 的场景，就应该去用最好的模型。

最好不要去管 token，把它当作 AI 的发展期，去学习用 AI，去跟 AI 交互，找那种跟 AI 交流的感觉。

你应该放开手脚去用 token，不应该去考虑钱。

现在有一些公司已经开始鼓励大家用 AI 模型，花的钱公司可以报销。我觉得这是对的，在用 AI 方面不应该考虑 token。

我看到同事说，他们在用公司内部的 AI 工具，因为是免费的，但用的人越来越多就会卡、会慢。其实我会在内部鼓励大家去买外部的大模型，这样速度更快。

AI 现在就是生产力，token 就像人类的电，或者像汽车的油。

你把它加满，加最好的油，电充得满满的，你的发动机就可以跑得更快。

大模型就是发动机，需要 token，你就让它跑就对了。在这个跑的过程中，我们会逐渐对 AI 的认识越来越多、越来越深入。

我最近这段时间，写代码、写文档，确实用的过程中用的越多，就会越发现工具越来越熟练。

### 5. 国内怎么用

国内的话，我一直在推荐大家用 [Claude Code](https://mp.weixin.qq.com/s/Mg5c89lvARevhi5X3egIuA)。

我现在还是继续推荐，之前我写过一篇文章，讲怎么在国内通过智谱用 [Claude Code](https://mp.weixin.qq.com/s/Mg5c89lvARevhi5X3egIuA)。那篇文章的转发量相当高，是我写过的文章里转发量最高的，昨天看的时候是 800 多转发。

大家如果在国内用 AI，用 Claude Code 的话，我觉得智谱的方案是最好的。其他家的我也不推荐，我也没有用过。

让你的 token 也燃烧起来吧。

---

**相关阅读**：
- [国内也能用！Claude Code 完整上手指南](https://mp.weixin.qq.com/s/Mg5c89lvARevhi5X3egIuA)
- [聊聊 Claude Code：它不是工具，它是实习生](https://mp.weixin.qq.com/s/tSnxzIxljuRSS-r8xaUzSA)
- [从 DeepSeek 到 Claude Code：AI 发展这一年](https://mp.weixin.qq.com/s/cNJ7idT9Y1QS0fW-yHH9Ig)

---

<section style="margin: 40px 0 20px; padding: 24px; background: #f9f9f9; border-radius: 12px; border: 1px solid #eee;">
<div style="font-weight: bold; font-size: 18px; margin-bottom: 8px; color: #333;">关于咕咚</div>
<div style="font-size: 13px; color: #666; margin-bottom: 16px; letter-spacing: 0.5px;">
<a href="https://mp.weixin.qq.com/s/l-EZl5MsXh-Y4uTbPAy80Q" style="color: inherit; text-decoration: none; border-bottom: 1px dashed currentColor;">inBox 笔记</a> 作者 | 独立开发者 | AI 编程实践者
</div>
<div style="font-size: 15px; color: #333; line-height: 1.8;">
爱开发，爱分享。<br/>
在这里，持续分享有价值的 AI 实践与开发感悟。<br/>
关注我，一起探索<a href="https://mp.weixin.qq.com/s/7SYcsdO0NOaq72P8W_ZMIA" style="color: inherit; text-decoration: none; border-bottom: 1px dashed currentColor;">「AI 编程」</a>的实践与思考。
</div>
</section>
