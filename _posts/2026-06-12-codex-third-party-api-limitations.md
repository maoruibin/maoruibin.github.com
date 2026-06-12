---
layout: mypost
author: 咕咚
tags: 'Codex'
categories: blog
title: "把 Codex 侧边栏用到极致"
---

![](https://gudong.s3.bitiful.net/img/a4490c20.png)

之前写了一篇教程，讲怎么在国内[用上 Codex](https://mp.weixin.qq.com/s/GWXh_Xs0-HHeg8p4KLRMiw)——通过 DeepSeek API 加 CC-Switch 的方案，可以零门槛跑起来。

用了一段时间，越来越顺手。今天不聊怎么安装配置，想单独说一个我最喜欢的功能——**侧边栏**。

---

![图 0：侧边栏功能展示](https://s3.bitiful.net/gudong/images/codex-sidebar/00-sidebar-showcase.png)

### 1. 侧边栏能干什么？

侧边栏有两个核心能力，一个是对话，一个是文件审核。

分开来说。

### 2. 文件审核与批注

点击侧边栏右上角的加号，可以选择打开项目里的任何文件，如下图所示：

![图 1：如何打开侧边栏](https://s3.bitiful.net/gudong/images/codex-sidebar/01-sidebar-open-file.png)

打开一篇 Markdown 或者其他文档后，Codex 默认会把它渲染出来，你看到的是排版后的效果。

如果要对文档有修改意见，通过鼠标选择后，是没有任何效果的，这是点击文件名旁边的更多菜单，选择「禁用增强视图」，如下图所示：

![图 2：禁用增强视图按钮位置](https://s3.bitiful.net/gudong/images/codex-sidebar/02-disable-enhanced-view.png)

禁用后就可以显示原始文档。

为什么要看原始文档？因为可以**批注**。

用鼠标选中你想修改的文字，直接在上面写批注意见。

![图 3：批注效果展示](https://s3.bitiful.net/gudong/images/codex-sidebar/03-annotation-effect.png)

一篇稿子里需要改的地方可能很多，没关系，一个一个选中、批注。全部批注完成后点发送，Codex 会一次性理解你所有的修改意见，直接帮你改好。

我之前用 Claude Code 或者其他 AI 工具改稿子，得一句一句地说——"第三段那个词改成 xxx"、"第五段加一句 yyy"。现在直接在原文上圈圈画画，批量批注，一键搞定。

不只是写文章。改代码的时候也一样，打开代码文件，选中要改的地方，批注，发送。

效率至少翻倍。


### 3. 分叉对话聊天

这是侧边栏的另一个能力。

正常跟 AI 聊天，一轮接着一轮往下走。但有时候聊到中间，你对某条回复产生了兴趣，想深入探讨一下，又不想打断主线的节奏。

这时候你可以选中那条消息里的内容，鼠标上方会出现一个提示——"在侧边聊天中继续提问"。

点击后，右侧会开出一个新的聊天框。

![图 4：如何在主对话开启侧边对话](https://s3.bitiful.net/gudong/images/codex-sidebar/04-fork-chat-open.png)

点击后，稍等片刻，就可以看到右边展示了另一个聊天框。

![图 5：侧边栏对话效果](https://s3.bitiful.net/gudong/images/codex-sidebar/04-fork-chat-effect.png)

现在你就有了两个聊天窗口：左边是主线任务继续跑，右边是你新开的分支话题。

这个场景太常见了。比如主线在开发一个功能，聊到一半发现一个技术细节值得单独讨论。以前要么打断主线去聊，要么开个新会话从头说背景。现在直接分叉，既有上下文，又不影响主线。

多个思路同时推进，生产力完全不一样。

### 4. 排队与引导

再说一个小细节。

默认情况下，你发了一个问题，AI 正在思考，这时候你又想到新的内容要补充。发送之后，新消息会进入排队状态——等上一个回答完成后才会被读取。

但 Codex 的设置里支持开启"引导"模式。开启后，你新发的消息会自动插入到正在进行的任务中去，AI 会在合适的时机把新内容也纳入思考。对话界面上也会直接提示"引导"按钮，一键切换。

![图 6：思考时发送新提示语的插队方式](https://s3.bitiful.net/gudong/images/codex-sidebar/05-follow-up-guide-chatbox.png)

Codex 默认是排队模式，我们可以去设置页面进行设置，以后默认为引导模式。

![图 7：设置页面开启自动引导](https://s3.bitiful.net/gudong/images/codex-sidebar/06-follow-up-setting.png)


这个功能特别适合那种灵感不断冒出来的场景——想到什么直接发，不用等。

### 5. ALT + 回车发送

还有一个细节值得提一下。默认情况下，输入框里按回车就直接发送消息了。

但 Codex 支持在设置里开启"ALT + 回车"才发送——单独按回车只是换行。

如果你经常写比较长的 Prompt，一定遇到过这种崩溃时刻：写着写着按了一下回车想换行，结果消息直接发出去了，还没写完。开了这个设置之后就没这个烦恼了。

Codex 设置里还有不少这样的小功能，建议大家扫一眼设置页，大概就能发现。

### 6. 关于第三方 API

我现在用的是智谱的 GLM5.1，通过 CC-Switch 接入。

坦白说，有一些限制：图片识别会卡主、插件用不了，Computer Use 用不了。

![图 8：第三方 API 限制说明](https://gudong.s3.bitiful.net/img/e5d1055f.png)

但说实话，这些不影响核心体验。代码编写、对话、文件操作、侧边栏——这些全部正常。

通过三方就能用上目前最先进的 Agent 编程工具，我觉得这就够了，没必要一门心思追求把插件、自动化、Computer Use 全给用起来。

把手上的工具用好，比追求全功能更重要。

---

**关于咕咚**

inBox 笔记作者，独立开发者，每天用 AI 约 8 小时。

我的作品：

- ✍️ [inBox 笔记](https://mp.weixin.qq.com/s/l-EZl5MsXh-Y4uTbPAy80Q) — 本地优先，隐私安全
- 🦞 [咚力圈](https://mp.weixin.qq.com/s/JZM1emcSuehKqzcg3iFZjQ) — AI 实践社群，一起探索

感谢阅读，如果觉得不错，欢迎点赞和爱心～想第一时间收到推送，也欢迎设为星标⭐

你在用 Codex 的时候，最常用的功能是哪个？有没有觉得哪个功能特别好？欢迎评论区说说，我自己也才用了一段时间，还在持续发现新东西。
