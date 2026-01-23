---
layout: mypost
author: 咕咚
tags: daily
categories: blog
title: "开源免费：我的公众号封面图生成器"
---

![咕咚｜2026-01-23](https://gudong.s3.bitiful.net/images/cover-1769102741.png)

设计微信公众号的封面图，用它就对了，Gudong Cover。

## 1. 缘起

我前几天写了[一篇文章](https://mp.weixin.qq.com/s/j27v2GV3MDst6dGVdLPaqg)，介绍自己如何用 AI 生成封面图。

因为我公众号的封面图都是用 AI 生成的，不过是让 AI 生成 HTML 代码。我自己有一套提示词，所以我的封面图其实都是一个风格。

后来经常有人问我，封面图是怎么做的。

我就想把提示词分享出来。但我发现不行，如果放在 DeepSeek 里面它是不行的。这样的话，提示词只能用在 Trae、Claude Code 这些 IDE 工具里。那对于很多普通人，上手成本太高了。

## 2. 解决方案

所以我灵机一想：我可以直接开发一个网页程序，专门做微信公众号的封面图，还有小红书的封面图。

我只需要把那套提示词内置进去，让 AI 根据提示词生成 HTML 网页格式的封面图。

这样普通人也能直接使用，就解决了必须借助 IDE 或编程工具的问题。

那天早晨有了这个想法后，我很快用 AI Studio 开发了这样一个网页。

## 3. 在线体验

👉 **[https://cover.gudong.site/](https://cover.gudong.site/)**

打开网页，输入文章标题或内容，点生成，就好了。

这个网页很简单，左边是输入文章内容或标题的输入框。

只要输入文章内容或标题，一点生成，AI 就会自动提取文章中的重点信息，再根据提示词的设定，比如显示什么字、背景什么样子，生成指定风格的封面图。

![](https://gudong.s3.bitiful.net/weimd/1769103013015_image.png)

对于很多非技术的同学，如果日常写公众号，完全可以通过这个工具设计封面图，我也提供了下载按钮，设计好之后一点下载就可以，或者截图也行。

## 4. 双模式切换

Gudong Cover 支持两种模式，针对不同平台优化：

**公众号模式 (2.35:1)**

横屏比例，极简深色风格。适合技术文章、深度观点、干货类内容。在微信列表里足够醒目，但绝不花哨。

**小红书模式 (3:4)**

竖屏比例，高饱和配色、大字报风格。更适合移动端浏览，强调情绪价值和视觉冲击力。适合种草、经验分享类内容。

## 5. 开源免费

而且这个工具是开源免费的。

💻 **源码已开源**：[https://github.com/maoruibin/GudongCover](https://github.com/maoruibin/GudongCover)

目前网页用的我自己的 Gemini key，和 DeepSeek key，估计用的人也不多，所以我就先提供免费额度。

国内用户、国外用户都可以用。我还支持自定义 API Key，如果自己有 API key 可以设置自己的 API Key。

**技术亮点**：
- 驱动模型：Gemini 3 Flash
- 生成速度：< 2 秒
- 一键导出高分辨率 PNG

非常欢迎大家去使用，也非常欢迎大家推荐给需要的人。比如做公众号的朋友、做小红书的朋友。

如果有问题也可以提出来，我后面还会继续优化。

## 6. 后续计划

另外我的公众号文章都是通过 [WeiMD](https://mp.weixin.qq.com/s/qkR_8tHELX3NYlAxG-fkpg) 这个工具做排版的，所以现在我已经把 Gudong Cover 集成到了我的微信公众号排版工具 WeiMD 里。

后续在做公众号排版的时候，把文章发给 Gudong Cover，让它生成一个封面图，整个流程就更通顺了。

这就是关于 Gudong Cover 的分享。感谢 AI。

我是咕咚，好工具，值得被更多人看见。

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

---

**相关阅读**：
- [附 Prompt：如何用 AI+代码，打造极简质感的公众号封面？](https://mp.weixin.qq.com/s/j27v2GV3MDst6dGVdLPaqg)
- [为了传图方便，我用 AI 魔改了一个公众号排版工具](https://mp.weixin.qq.com/s/qkR_8tHELX3NYlAxG-fkpg)
- [为了写公众号更爽，我给自己的排版工具加了 3 个"刚需"功能](https://mp.weixin.qq.com/s/j55UD1JheTfe7Ll80fYUzw)

<p style="text-align: center; color: #ccc; font-size: 12px; margin-top: 30px;">
排版 by <a href="https://mp.weixin.qq.com/s/qkR_8tHELX3NYlAxG-fkpg" style="color: #999;">weimd</a>
</p>
