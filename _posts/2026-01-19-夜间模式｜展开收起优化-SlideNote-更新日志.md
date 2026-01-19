---
layout: mypost
author: 咕咚
tags: daily
categories: blog
title: "夜间模式｜展开收起优化 ：SlideNote 更新日志"
---

![咕咚｜2026-01-19](https://gudong.s3.bitiful.net/images/cover-slidenote-001.png)

在写今天的文章之前，先说个小插曲。

昨天写了篇《微信输入法越来越香了》，是有感而发。

这段时间经常用语音输入，电脑上用闪电说，但发现总有些小问题。

后来发现微信输入法在手机端的语音转文字特别准，说完会有个 AI 校正的过程。

就因为这一点，我觉得微信输入法真好。有感而发，就给"打了个广告"。

没想到这篇文章被微信推荐了，现在 1 万多阅读，成了我阅读量最高的一篇。

反正想来想去，微信怎么都不亏，自家推荐自家的产品。

---

今天要说的是 SlideNote 的更新。

SlideNote 是我上周发布的 Chrome 浏览器侧边栏笔记插件。具体可以看这篇：[侧边笔记，常伴左右：我用 Claude Code 开发了一个浏览器插件](https://mp.weixin.qq.com/s/nivLWAkYWiMHRHMENko0UQ)

发布后数据比我预期的好：GitHub 80+ star，Chrome 商店 400+ 下载。

![SlideNote 下载量](https://gudong.s3.bitiful.net/images/slidenote%20下载量.png)

我之前给 inBox 笔记做过一个浏览器插件，到现在才 40 多个用户。

SlideNote 用的人多，可能是因为这个需求确实存在。

GitHub 和微信上都收到一些用户反馈，所以这周修了几个 bug，加了些新功能，发布了 0.0.6 版本。

## 1. 夜间模式

之前一直是浅色，浏览器变黑后它也不变黑，有点突兀。

这次适配了夜间模式，会跟随浏览器的主题自动切换。

![适配了夜间模式](https://gudong.s3.bitiful.net/images/适配了夜间模式.png)

## 2. 侧边栏交互优化

展开收起的交互做了调整。

这个改动是和 AI 讨论后，它给了一个方案，我觉得挺好。

现在展开收起的按钮放在顶部。点击收起后，侧边栏会展示笔记的名称，再次点击就展开。

![收起状态优化](https://gudong.s3.bitiful.net/images/收起状态优化.png)

## 3. 后续计划

还有几个功能在计划中：

- 划词收藏：选中网页文字，快速收藏
- 数据导出：备份自己的笔记

暂时先放到后面的版本。

---

如果你也有在浏览器里记录临时信息的需求，欢迎试试 SlideNote。

有其他想法也欢迎反馈。

我是咕咚，好工具，值得被更多人看见。

---

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
