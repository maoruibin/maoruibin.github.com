---
layout: mypost
author: 咕咚
tags: daily
categories: blog
title: "从飞书开源 CLI，聊聊 GUI 和 CLI"
---

昨天我在微信群，突然看到有群友说：飞书开源 CLI 了。

![](https://gudong.s3.bitiful.net/img/4e42751b.png)

我一个激灵就起来去安装了飞书的 CLI 工具。

因为这个事情非常不一样。

![](https://gudong.s3.bitiful.net/img/90197a56.png)

### 1. 为什么激动

我最近在给咚力圈写一些教程，这个过程不可避免的要用 AI 去辅助编写，文章都是本地的 Markdown 格式，目前已经写了大概 10 篇。

写好之后，我需要把 markdown 文件一个一个复制到飞书文档里——打开飞书文档，新建文档，粘贴，保存。

这个过程有没有问题？没问题，因为我们一直都是这样做的。

但我之前就在想：既然 AI 已经帮我把教程写好了，我能不能一键就把文档上传到飞书文档里？

以前完全不可以，因为飞书没有提供接口。

现在，可以了。

### 2. 什么是 GUI，什么是 CLI

很多朋友可能不知道 CLI 和 GUI 到底是个啥，我简单说一下。

**GUI，Graphical User Interface，图形用户界面。**

说人话就是，你现在看到的一切。

你手机上的微信界面，你电脑上的飞书窗口，你每天点来点去的那些按钮、菜单、对话框，全部都是 GUI。

它的逻辑是：把所有功能变成你看得见摸得着的东西，你不需要记任何命令，看到按钮就点，看到输入框就填，简单直观，傻瓜式操作。

**GUI 是为人类设计的。**

因为人类是视觉动物，我们需要看到东西才能理解东西。

**而 CLI，Command Line Interface，命令行界面。**

就是那种黑乎乎的屏幕，你敲一行字，电脑给你吐一行结果的东西。

![](https://gudong.s3.bitiful.net/img/6e20d0b0.png)

很多人一看到这个界面就头大，觉得这玩意是程序员才用的。

以前确实是。

但是，时代变了。

### 3. CLI 天然适合 AI

现在很多 Agent 都是在 CLI 上跑效果最好，比如大名鼎鼎的 Claude Code。

因为 CLI 有一个 GUI 永远比不了的优势：**它天然适合被 AI 操控**。

在这个年头，AI 最核心的交互方式，依然是文字，是指令，是一句一句的代码命令。

而 CLI，恰好就是用命令来操作一切的。

所以你就能理解，为什么飞书要开源一个 CLI 了。

它不是给你用的。

嗯，也不完全是，你也可以用，但它最核心的用户，是 AI。

是你的 AI Agent。

是 Claude Code，是 Codex，是 OpenCode，是[小龙虾](https://mp.weixin.qq.com/s/boOwTBKhUvR_-5UE73tfmw)，是那些未来所有帮你干活的 AI 助手。

### 4. GUI → CLI，路径反过来了

以前，软件的演化路径是：CLI → GUI。

电脑最早就是命令行的，后来有了 Windows、有了 Mac 的图形界面，普通人才开始用得上电脑。

而现在，路径反过来了：GUI → CLI。

不是因为我们要回到过去，而是因为那个新的用户来了。

这个新用户，叫 Agent。

AI 不需要看到按钮，AI 不需要花里胡哨的动画。

AI 需要的是：你给我一个接口，告诉我能做什么，我来调用。

一行命令，一个功能。

### 5. 飞书这一步迈得挺大

飞书这一步，走得很漂亮，直接把整个产品压缩成了一套命令行工具。

但也确实有点狠。

因为很多传统产品都会看所谓的 DAU、所谓的停留时长——这种口径都要打开你的 GUI 产品才算。

但是当你把 CLI 开源出来之后，所有的 Agent 都可以通过命令行来直接调用你，那我有些时候就不需要打开飞书了。

传统口径上的日活肯定会掉，但对用户真正的价值，反而上升了。

这说明飞书想得很清楚：一个效率工具，就应该为了用户的效率去服务。

### 6. 对创造者更有用

这个工具对生产者、创造者更有用，可以提高我们的效率，把文件高效率地上传到各个平台。

我现在写教程，写完之后只需要说"同步"，就自动上传到飞书云文档了。

以后我只需要维护一份文档——电脑上的 markdown 文件，那是唯一的地方。

不需要这边写完再去那边粘贴，也不怕两边同步出问题。

### 7. 飞书只是开了一个口子

钉钉文档也在做 CLI，后面很多效率工具都会朝着这个方向走——面向 AI Agent，面向智能体，这些软件都需要面向智能体再做一遍。

谁先做，谁就可能获得更多用户。

飞书做了，其他家肯定也会跟着走——钉钉、Notion，大概率都会跟进。

飞书只是开了一个口子，后面跟随者会越来越多。



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
