---
layout: mypost
author: 咕咚
tags: 'AI 实践'
categories: blog
title: "Codex 这么好用啊，在国内如何用上"
---

前段时间我写过一篇文章，介绍在国内怎么用上 Codex。

但发布之后，我发现有些地方写得不好，想重新再写一遍。

这是一个完整版本，你完全可以照着这个教程，把 Codex 用起来。全程不需要海外账号，不需要信用卡，顶多花 10 块钱就能上车。

Codex 现在很火，用的人越来越多，它确实能干活，而且干得不错。

![图 0：社交媒体时间线上铺天盖地的 Codex 推送](https://s3.bitiful.net/gudong/images/codex-guide/10-so-many-codex-article.png)

不论是我的同事还是朋友，各行各业都在用它做各种事。

做 PPT、写报告、做项目，甚至做后期特效。

它能清理电脑垃圾，能写代码，但凡电脑上能干的事，好像都可以找它帮忙。

但卡住很多人的就是第一步——它是 OpenAI 的，按理得有个 ChatGPT 账号。

连我自己都没有 ChatGPT 账号。

不过我想，它终究是个桌面智能体，一定有办法在国内用起来。

最后用 CC Switch 加 DeepSeek 跑通了。

整个过程很简单，我先把步骤列出来，让你心里有个数。

---

### 先看全貌：就这几步

在国内用上 Codex，核心就这么几步：

第一步，下载 Codex。

第二步，下载 CC Switch。

第三步，注册一个 DeepSeek 账号，创建一个 API Key。

第四步，在 CC Switch 里选 OpenAI，添加一个供应商，选 DeepSeek，填上 API Key。

第五步，去 CC Switch 的设置里开启本地路由，勾选 Codex。

做完这几步，退出 Codex 重新打开，就能用了。

下面是详细教程。

---

### 1. 下载安装 Codex

打开 Codex 官网 [openai.com/codex](https://openai.com/codex/)，下载安装包。

支持 Mac 和 Windows，安装跟普通软件一样，下一步下一步。

![图 1：Codex 官网下载页面](https://s3.bitiful.net/gudong/images/codex-guide/01-codex-download-page.png)

### 2. 安装 CC Switch

CC Switch 是一个 AI 智能体网关代理工具，开源免费。

你可以把它理解成一个"转接头"——把国产的 AI 服务（比如 DeepSeek）转接到 Codex 里。

去 [ccswitch.io](https://ccswitch.io/zh/) 下载。

**注意：CC Switch 必须是 3.16.1 以上版本**，低于这个版本不支持接入 Codex。

![图 2：CC Switch 官网下载页面](https://s3.bitiful.net/gudong/images/codex-guide/02-ccswitch-download-page.png)

### 3. 注册 DeepSeek，拿到 API Key

打开 [deepseek.com](https://www.deepseek.com/)，选开放平台（不是聊天页面）。

![图 3-2：DeepSeek 开放平台控制台](https://s3.bitiful.net/gudong/images/codex-guide/03-2-deepseek-dev-consold-page.png)

注册要实名认证，正常，要用就认证。

然后充值。我这个月充了 30 块，日常用绰绰有余。

![图 4：DeepSeek 充值页面](https://s3.bitiful.net/gudong/images/codex-guide/04-deepseek-recharge-page.png)

进控制台，API Key 管理，新建 Key。

![图 3：DeepSeek API Key 管理页面](https://s3.bitiful.net/gudong/images/codex-guide/03-deepseek-apikey-page.png)

### 4. 在 CC Switch 里配置供应商

打开 CC Switch，先在左侧选中 GPT，然后点右边的加号。

选 DeepSeek，把 API Key 填进去。

![图 5-a：CC Switch 供应商主页面，选中 GPT 后点击加号](https://s3.bitiful.net/gudong/images/codex-guide/05-ccswitch-config-deepseek.png)

![图 5-b：CC Switch 配置 DeepSeek 节点](https://s3.bitiful.net/gudong/images/codex-guide/05-ccswitch-config-node.png)

### 5. 开启本地路由（这步最容易漏）

前面填好的供应商，只是"登记"了一下。

真正让 Codex 的请求走到 DeepSeek，还得开本地路由。

打开 CC Switch 的设置，进入路由页面，选"本地路由"。

![图 12：CC Switch 设置入口](https://s3.bitiful.net/gudong/images/codex-guide/12-ccswitch-setting-entry.png)

然后打开路由总开关，在"路由启用"那里勾选 Codex。

![图 11：CC Switch 路由设置，开启总开关并勾选 Codex](https://s3.bitiful.net/gudong/images/codex-guide/11-codex-route-setting.png)

**这步不做，前面全白搭。** 默认情况下本地路由是关的，必须手动打开，再勾上 Codex。

这步做好之后，相当于在本地起了一个服务。Codex 后面发出的 AI 请求，都会走到 CC Switch 这边，再转发给 DeepSeek。

退出 Codex 重新打开，就能正常用了。

另外建议把 CC Switch 设成开机启动，这样后面就不用每次手动打开了。如果你用得比较多，这个设置很省心。

---

### 场景一：用 Codex 管理你的文档工作台

配置好只是第一步，关键得把它用起来。

我最核心的用法——写公众号。

这不是简单的"用 AI 写文章"，而是一套完整的文档管理工作流。

我在电脑上建了个文件夹，然后告诉 Codex：

> 这是我的写作工作区。我在这里写公众号稿子，我的写作风格是怎样的，我关注哪些领域。

它不会上来就写文章，而是先想怎么帮我组织这个文件夹——素材放哪、草稿怎么命名、截图存哪个子目录。

它给方案，我确认，就这么定了。

![图 6：写作工作区文件夹目录结构](https://s3.bitiful.net/gudong/images/codex-guide/06-workspace-folder-structure.png)

每个人的文件夹结构可能不一样，按自己的习惯来。

但核心是一样的：这个文件夹就是你的文档工作台。

每次写新文章，我开一个新会话，把想法丢给它，它帮我捋思路。

然后把素材、语音转文字的稿子、截图都丢进去，它帮我整理。

一篇长文不是一蹴而就的，是个渐进的过程——今天冒个想法，明天补点素材，后天再打磨一下。

Codex 在这个文件夹的上下文里都记得。

这篇文章本身也是这么写的。我跟它聊需求，它帮我理结构，然后一段一段地改。

![图 7-a：Codex 整体界面，极简设计但功能强大](https://s3.bitiful.net/gudong/images/codex-guide/07-codex-chat-context.png)

Codex 的界面特别极简、特别干净，我很喜欢。

功能又很强，这是个很好的产品。

还有一个我特别喜欢的功能——侧边聊天。

对话过程中，你对某段内容有疑问，可以选中这段文字，选在侧边聊。

这时候可以基于当前对话分叉，去聊另一个话题，而且不会丢当前上下文。

顺便吐槽一下 Claude Code。它也有类似功能，有个命令叫 `btw`，能离开当前会话去问问题。

但命令行操作很麻烦，不能连续对话，总之用着费劲。

![图 7-b：Codex 侧边聊天功能](https://s3.bitiful.net/gudong/images/codex-guide/07-codex-chat-slide.png)

Codex 用侧边栏这种界面的方式，很好地解决了这个问题。

在那边聊完，结果可以直接拿回主对话，这个设计太贴心了。

这套方法还能扩展到很多场景——学习笔记管理、工作文档撰写、产品文档维护。

而且 Codex 支持技能扩展。

比如我写文章时要上传图片、处理图片、发布到公众号和博客，它都有对应的技能可以调用。

它就是我的文章控制台。

---

### 场景二：清理电脑

除了写文章，Codex 还能干很多事。

比如清理电脑垃圾，我用它一句话清了 94G，之前用的清理软件才清出 1G。

具体怎么操作的，可以看这篇：[清理软件只能清 1G，Codex 一句话清了 94G](https://mp.weixin.qq.com/s/kWjjpoDPGROLgWLxBsCVTQ)。

---

### 到底聪明在哪

用了这段时间，我一直在想一个问题：为什么 Codex 干活的效果就是不一样？

其实不论 Claude Code 还是小龙虾，底层用的是同一批大模型。

DeepSeek 还是那个 DeepSeek，在哪用都一样。

**真正的差距，在智能体本身的设计上。**

不同的智能体，差别在本地的工具调用设计，还有任务编排。

Codex 在这块做得更精妙——它知道什么时候该调什么工具，什么时候该问你，什么时候该自己琢磨。

![图 10：Codex 工具调用与任务编排决策流程图](https://s3.bitiful.net/gudong/images/codex-guide/ai-agent-orchestration-flow.jpeg)

用了一段时间，我有个挺直观的感受：相比小龙虾和其他智能体，Codex 确实更聪明一点。

有时候就是觉得，用 Codex 干活更让人放心。

当然，我现在还是一半 Codex 一半 Claude Code，没全切过去。

但同样是写代码、跑任务，Codex 那种"先研究再动手"的劲头，确实让我更踏实。

---

### 关于模型：DeepSeek 和 GLM 怎么选

接进来之后，用哪个模型也有讲究。

我用下来，DeepSeek 的速度很快，响应利落。

智谱的 GLM 用起来会慢一点。

不过现在有个共同的短板——GLM 和 DeepSeek 都不支持图片。

所以在 Codex 里，最好别让它去分析、识别图片，很容易卡死。

我现在用的时候，已经明确在配置里告诉它不要读图片。

凡是涉及图片的活，我自己处理，不让它碰。

好消息是，DeepSeek 后面会支持图片，我看它网页上已经支持了。

等接口跟上，这个问题就解决了。

---

### 为什么这套方案值得推荐

省钱。几十块钱，对比 ChatGPT Plus 一个月 20 刀。

数据在本地。所有文件都在你电脑上，不强制上传。

灵活。想换模型，换个 API Key 就行，DeepSeek、通义千问、Gemini 随便切。

它不是简单的问答工具，是理解你项目上下文的协作伙伴。

---

### 写在最后

这套方案我用了好一阵，真的很香。

如果你也是"想用 Codex 但卡在第一步"的人，按上面的步骤试试，10 分钟就能用上。

关于 Mac 和 Windows，多说一句。

我自己一直用 Mac，Codex 在 Mac 上确实更顺手，毕竟开发团队主要在 Mac 上干活。

但很多同学用的是 Windows，如果跑不起来也不用死磕，可以试试腾讯的 WorkBuddy，国内直接能用。

它的工作流、自动化插件、更多玩法我都还在摸索，估计现在只用了不到两成。

但这反而是好事，说明天花板很高。

关注我，后面有新用法我接着分享。

---

**关于咕咚**

inBox 笔记作者，独立开发者，每天用 AI 约 8 小时。

我的作品：

- ✍️ [inBox 笔记](https://mp.weixin.qq.com/s/l-EZl5MsXh-Y4uTbPAy80Q) — 本地优先，隐私安全
- 🦞 [咚力圈](https://mp.weixin.qq.com/s/JZM1emcSuehKqzcg3iFZjQ) — AI 实践社群，一起探索

感谢阅读，如果觉得不错，欢迎点赞和爱心～想第一时间收到推送，也欢迎设为星标⭐
