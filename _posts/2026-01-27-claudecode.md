---
layout: mypost
author: 咕咚
tags: daily
categories: blog
title: "聊聊 Claude Code：它不是工具，它是实习生"
---

![图 1：Claude Code 命令行界面](https://gudong.s3.bitiful.net/weimd/1769434232144_image.png)

如果是我的老读者，应该发现我的编程工具一直在变。

从最早推荐 Trae 到 Gemini，到后来的 AI Studio，就像神农尝百草一样，我试了很多 AI 编程工具。

但最近一个月，我几乎只用一个工具：**Claude Code**。

经常有朋友问我：“咕咚，Claude Code 到底是个啥？跟 Trae、Cursor 有啥区别？非程序员能用吗？”

说实话，一句话还真讲不清楚。

今天我就从一个软件工程师的视角，抛开那些复杂的安装、购买教程，单纯聊聊：**它到底是个什么物种，以及为什么我觉得它颠覆了游戏规则。**

*(注：这篇虽是技术话题，但我尽量说人话。如果你完全不懂代码，也可以当个热闹看，因为它能干的事儿，远不止写代码。)*

---

## 1. 什么是 Claude Code？

首先，别被名字骗了。虽然带个 `Code`，但它不仅仅是个写代码的工具。

**它是一个住在你命令行里的"AI 实习生"**（这个概念我在[之前的文章](https://mp.weixin.qq.com/s/JlNAwGnYsRw0Sc9rqk64hA)里也提到过）。

这就好比：
*   **以前的 AI（ChatGPT/豆包）**：像个**顾问**。你问它问题，它给你建议。但具体的活儿，还得你自己干（复制粘贴、改文件、运行）。它没有手。
*   **Claude Code**：像个**实习生**。你给它权限，它真的能上手干活。

你可以直接对它说：“把这个文件夹里的所有图片压缩一下”、“帮我分析一下这个项目的代码结构”、“读一下这个 Excel 账单算出总数”。

它会直接在你电脑里**操作文件**、**运行命令**，最后把结果交给你。

它不仅仅是“说话”，它是真的在“做事”。

## 2. 为什么它不一样？

有人会问：“Trae 和 Cursor 也能写代码啊，有啥区别？”

区别在于**交互方式**和**权限**。

传统的工具（VS Code / Cursor）是有界面的，你需要点按钮、开文件。

但 Claude Code 是一个**命令行工具（CLI）**，它没有花里胡哨的界面，就是一个黑框框。

这时候神奇的事情发生了：因为它是命令行工具，它天然拥有了你操作系统的“上帝视角”。

*   它可以调用你电脑里的 `git` 命令提交代码。
*   它可以调用 `node` 运行脚本。
*   它可以随时访问你电脑里任何角落的文件。

这就给了它极大的自由度。**它不再被困在一个软件窗口里，而是直接接管了你的操作系统。**

## 3. 它是怎么“记住”事的？

用过 AI 的人都知道，AI 最大的毛病是**“健忘”**，聊着聊着，上下文就丢了。

Claude Code 有个很聪明的做法：**崇尚文档**。

当你开始一个项目时，运行一下 `init`，它会扫描整个项目，把项目是干嘛的、用了什么技术、结构是啥，通通写进一个叫 `claude.md` 的文件里。

这就像是给 AI 实习生写了一份**“入职手册”**。

每次它开始干活前，先读一下这个手册。这样，无论你什么时候回来，它都能立马接上之前的思路，绝不把上下文弄丢。

---

## 4. 程序员的福音：跨项目操作

这点是我最爽的体验。

我现在同时开发 **[inBox 笔记](https://mp.weixin.qq.com/s/l-EZl5MsXh-Y4uTbPAy80Q)** 的安卓版和 PC 版，这是两个完全独立的项目文件夹。
![](https://gudong.s3.bitiful.net/weimd/1769434780655_image.png)

如果是传统工具，我得开两个窗口，两边不仅不互通，还得我自己当传话筒。

但在 Claude Code 里，我可以告诉它：

> “请读取一下安卓项目的逻辑，参照它，给现在的 PC 版写一个同步功能。”

因为它在命令行里，它可以跨越文件夹的限制，去读取另一个项目的信息。

甚至，我可以同时开 6 个命令行窗口。
*   窗口 A：写 PC 端代码。
*   窗口 B：帮我写产品文档。
*   窗口 C：帮我分析安卓端的旧逻辑。

**这就是真正的多线程工作。** 

而且上手后，有很多人只恨自己没有三头六臂，去同时跟多个 AI 去交互对话下命令。

---

## 5. 普通人的神器：不仅仅是代码

重点来了。如果你不是程序员，它对你有用吗？

**非常有用。**

Claude Code 的核心逻辑是：**“给我一个文件夹，我给你个世界。”**

你可以在桌面上建个空文件夹，把你想处理的任何东西扔进去：
*   **扔一堆账单截图** -> 告诉它：“分析这个月的支出，做个表格。”
*   **扔一堆会议记录** -> 告诉它：“帮我整理成周报，按时间线排列。”
*   **扔一堆素材** -> 告诉它：“帮我规划一下年度计划，按月生成文件夹。”

它会像一个全能秘书，帮你操作文件、整理数据、生成图表。

这就是我为什么说它不只是编程工具，它是**生产力工具**。

---

## 6. 最难懂但也最强大的：技能 (Skill)

最后聊聊 Claude Code 的杀手锏——**技能**（其实就是 MCP，Model Context Protocol，但我们不扯技术名词）。

简单说，**技能就是把你要重复干的事，封装成一个“快捷指令”。**

举个我自己的例子：
我经常需要 AI 帮我解释一些生僻的技术概念。但我每次都要啰嗦一大堆：“请通俗解释一下，最好举个生活中的例子，不要掉书袋……”

太麻烦了。

于是我做了一个“**解释技能**”。
只要我对它说 `explain 智能体`，它就会自动触发我预设好的一套流程：
1.  扮演科普作家。
2.  用大白话解释。
3.  必须举一个生活案例。

这就是技能。

同理，你可以做一个“上传技能”（自动把图片上传到服务器），做一个“翻译技能”（自动把文档翻译成中英对照）。

**只要是你重复在做的事，都可以变成 Claude Code 的一项“肌肉记忆”。**

![](https://gudong.s3.bitiful.net/weimd/1769435037279_image.png)

具体关于如何创建技能，这篇文章限于篇幅，就不介绍了，大家感兴趣，随便搜索一下 Claude Skills 这个关键词就可以搜索到很多教程。

---

## 写在最后

用了这一个月，我发现我的工作模式彻底变了。

以前我 100% 的时间在写代码。
现在，我一半时间在写代码，另一半时间在指挥它写文档、做调研、整理资料。

如果你想尝试，门槛其实很低：
1.  装好 Claude Code。
2.  建一个空白文件夹。
3.  告诉它：“我想做一个 [填入你的想法]。”

无论是写个 APP，还是做个 PPT，只要你敢迈出那一步，剩下的路，它会陪你一起走。

---

**相关阅读**：

- [侧边笔记，常伴左右：我用 Claude Code 开发了一个浏览器插件](https://mp.weixin.qq.com/s/nivLWAkYWiMHRHMENko0UQ) — Claude Code 实战案例
- [什么是 Vibe Coding？或者，你可以叫它"对话式编程"](https://mp.weixin.qq.com/s/7SYcsdO0NOaq72P8W_ZMIA) — 理解对话式编程的理念
- [10分钟，我用"说话"写了一个App：对话式编程极简实战指南](https://mp.weixin.qq.com/s/PNh2NYanQGhM9SmrpRqbDQ) — 从零开始的完整流程

---

我是咕咚，好工具，值得被更多人看见。

<section style="margin: 40px 0 20px; padding: 24px; background: #f9f9f9; border-radius: 12px; border: 1px solid #eee;">
<div style="font-weight: bold; font-size: 18px; margin-bottom: 8px; color: #333;">关于咕咚</div>
<div style="font-size: 13px; color: #666; margin-bottom: 16px; letter-spacing: 0.5px;">
<a href="https://mp.weixin.qq.com/s/l-EZl5MsXh-Y4uTbPAy80Q" style="color: inherit; text-decoration: none; border-bottom: 1px dashed currentColor;">inBox 笔记</a> 作者 | 独立开发者 | AI 编程实践者
</div>
<div style="font-size: 15px; color: #333; line-height: 1.8;">
爱开发，爱分享。<br/>
在这里，持续分享有价值的 AI 实践与开发感悟。<br/>
关注我，一起探索<a href="https://mp.weixin.qq.com/s/7SYcsdO0NOaq72P8W_ZMIA" style="color: inherit; text-decoration: none; border-bottom: 1px dashed currentColor;">「对话式编程」</a>的实践与思考。
</div>
</section>
<p></p>

<p style="text-align: center; color: #ccc; font-size: 12px; margin-top: 30px;">
排版 by <a href="https://mp.weixin.qq.com/s/qkR_8tHELX3NYlAxG-fkpg" style="color: #999;">weimd</a>
</p>