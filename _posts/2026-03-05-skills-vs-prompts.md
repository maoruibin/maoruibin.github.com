---
layout: mypost
author: 咕咚
tags: daily
categories: blog
title: "Skills vs 提示词：不只是保存文件那么简单"
---

![图 1：纸上谈兵的军师 vs 带兵打仗的指挥官（概念插画）](https://gudong.s3.bitiful.net/weimd/placeholder_skills_vs_prompt.png)

这两天，我一口气写了十几个 Skills（技能）。

不论是公司的项目，还是我个人的独立开发项目，我现在只要遇到重复的活儿，第一反应就是：“能把这事儿写成一个 Skill 吗？”

自从去年 10 月 [`Claude Code`](https://mp.weixin.qq.com/s/tSnxzIxljuRSS-r8xaUzSA) 提出 Skills 以来，这个概念一直很火。我之前的文章里也多次提到过。但我发现，身边依然有很多人（甚至包括刚接触时的我自己）对它感到困惑。

最常见的困惑就是：
**这玩意儿不就是一段提示词（Prompt）吗？无非是把提示词存在了一个名叫 `xxx.skill.md` 的文件里，换个马甲而已，有啥本质区别？**

如果你也有这个疑问，今天这篇文章，我想用大白话把它讲清楚。

### 1. 作用对象的降维打击

要理解两者的区别，首先得搞清楚它们是“给谁用的”。

以前我们攒各种牛逼的提示词，甚至建了庞大的“提示词仓库”，这些东西都是喂给 **Chatbot（聊天机器人，比如 ChatGPT、豆包）** 的。

你把一段精妙的提示词发给豆包，豆包在聊天框里洋洋洒洒给你回了一大段分析、规划甚至代码。
**然后呢？**
然后你得自己把代码复制出来，自己去建文件，自己去运行。

但 Skills 不一样。从诞生之初，它的全称就是 **Agent Skills（智能体技能）**。它是喂给 **Agent（智能体）** 的。

Agent 和 Chatbot 最大的区别，就是 **“Agent 能干活”**。

比如你想整理电脑桌面。

用提示词喂给 Chatbot，它会给你一个完美的归类方案（图片放哪、文档放哪）。
但如果你写了一个整理桌面的 Skill 喂给 Agent，Agent 会直接调用系统的命令，帮你把桌面上乱七八糟的文件，真实地移动到对应的文件夹里。

**一个是军师，一个是干活的工人。这就是本质区别。**

### 2. 什么是 Skill？它由什么构成？

一个完整的 Skill，绝不仅仅是一段文字。它通常分为三个硬核层级：

**第一层：元数据（Metadata）**
这就是这个技能的“名片”。包含技能叫什么名字（Name）、能干啥（Description）以及什么时候该用它（触发词）。
这个设计极其精妙。你在工作区挂载了几十个技能，AI 一开始只会读取这些名片（极大地节省了 Token），只有当你的指令命中了某张名片，AI 才会去加载背后的具体内容。

**第二层：指令与 SOP（Instructions）**
这里面是具体的规则约束。你能干啥、不能干啥、最佳实践是什么。这就相当于给员工发了一本《操作手册》。

**第三层：资源与代码（Resources & Code）**
这是它区别于普通提示词最牛的地方。你可以在 Skill 里直接挂载 Python 脚本、Shell 命令或者参考文档。AI 不仅按指令思考，还能直接运行这些代码去落地。

> 援引：[文章地址](https://mp.weixin.qq.com/s/05NzsYUxQnFolPFwu0Ss0Q)

### 3. 举个栗子：财务报表体检

光说概念太抽象，举个真实的场景。
假设你手头有一份公司的财务报表（Excel），你想检查里面的数据有没有异常。

**如果用传统 Prompt（提示词）：**
你把 Excel 传给聊天框，配上提示词：“请帮我检查这份报表，单笔报销不能超 500……”
AI 看完会告诉你：“C 列第 5 行超标了。”

你只能看着聊天框，自己回去改 Excel。

如果用 Skill（比如写一个 `excel-auditor.skill.md`）：

你可以这样设计：
- **元数据**：name:  `excel-auditor`，description: 财务报表检查技能，当我说“帮忙体检一下这个表格”时触发。
- **指令**：内嵌你们公司全套的财务审计 SOP。
- **代码**：在技能里写明，遇到复杂表格，**自动调用 pandas 数据分析库**去跑脚本。

有了这个 Skill，当你扔给 Agent 一个表格时，它能直接通过运行 Python 代码，把表格里的错误数据挑出来，甚至直接生成一份修改后的新表格存到你的电脑上。

这已经不是聊天了，这就是**雇了一个能干活的财务审计员**。

### 4. 什么时候该写个 Skill？

很多人会觉得：“我平时好像也用不到这么硬核的东西啊？”

其实你只要问自己一个问题：**我在电脑前，有哪些事情是每天/每周都在手动重复的？**

比如：
- 每天固定去某个网站扒两张图。
- 每次写完文章都要花 5 分钟去改错别字、排版、加末尾签名。
- 定期整理某个下载文件夹。

这些有规律、要动手的事情，只要不极端复杂，都可以考虑写个 Skill 把它 SOP（标准化）掉。

像我现在写这篇公众号文章，录音转写、口语去噪、提取关键词、生成标准排版的 Markdown，全部都是靠我后台挂载的 Skills 自动跑完的，包括推送文章到微信公众号后台，我只负责“想法和思考”，剩下的「粗活」，AI 拿着我写的 Skill 去干。



### 写在最后

其实，Skill 这个东西，光看别人说或者逛“技能市场”，体感是很弱的。

这东西必须得自己上手写、自己去用。一开始你可能会觉得抽象，但只要你成功把一个繁琐的日常任务封装成了一个 `xxx.skill.md` 文件，体会过那种“一键触发、看着它在终端里自动把活干完”的爽感，你就会像打通了任督二脉一样停不下来。

它没有固定的章法，就是为了解决你的具体问题而生的。用熟了之后，无招胜有招。

**提示词只会“纸上谈兵”，而 Skills，让你成为了真正的“指挥官”。**

---
另外，skills 具体要用起来，需要结合具体的 Agent 应用去加载，我日常使用 ClaudCode，国内也可以使用 KimiCode，不同的应用对 Skills 的文件夹要求不一样，但原理都一样，就是在本地一个文件夹下放着所有能用到的技能，然后在日常使用 Agent 时，AI 会根据我们的自然语言去判断，是否要去加载技能干活，命中后会自动加载技能全部文件到上下文，然后干活。

![](https://gudong.s3.bitiful.net/weimd/1772723444078_image.png)

另外，目前要学习 AI Agent，不论程序员还是普通人，我推荐有条件直接用 ClaudeCode，国内，咱可以使用 KimiCode，然后日常的办公环境下，能用 AI 的，能用命令行的，尽量去用命令行完成。

这个有点门槛，但是只要上手了，这就是一个新世界。

---

*附：这是一个极简的 Skill 结构 Demo，大家可以感受一下：*

```markdown
---
name: excel-auditor
description: 对财务报表进行规则校验和体检。触发词："检查表格"
---

# 财务报表体检技能

## 1. 审计规则 (SOP)
- 单笔报销金额绝对不能超过 500 元。
- 时间必须是本月。
- 缺少发票附件的记录必须被标记。

## 2. 执行工具
当表格行数超过 100 行时，请优先使用本地的 Python 脚本 `audit_tool.py`（使用 pandas 处理）进行分析，而不是强行阅读。

## 3. 输出要求
- 不要长篇大论。
- 发现错误直接将错误行标红，并生成一个 `audit-report.md` 文件保存在当前目录。
```



**相关阅读**：
- [多 Agent 编排：一人公司的开始](https://mp.weixin.qq.com/s/KDhOnAWhgMlnlyOM3Hxb4A)
- [聊聊 Claude Code：它不是工具，它是实习生](https://mp.weixin.qq.com/s/tSnxzIxljuRSS-r8xaUzSA)



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
<p></p>

<p style="text-align: center; color: #ccc; font-size: 12px; margin-top: 30px;">
排版 by <a href="https://mp.weixin.qq.com/s/qkR_8tHELX3NYlAxG-fkpg" style="color: #999;">weimd</a>
</p>