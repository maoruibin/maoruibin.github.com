---
layout: mypost
author: 咕咚
tags: 'daily'
categories: blog
title: "inBox 笔记 2.3.8，把工具栏交给了你"
---

![封面](cover.png)

今天发了 inBox 笔记 2.3.8，一个小优化版本。

### 工具栏，终于能自定义了

这次做了一个新功能：工具栏完全支持自定义，包括顺序。

之前工具栏的顺序是写死的，标签、图片、加粗这几个入口固定在前面，更多功能藏在二级菜单里。发布后不少人反馈，说想把常用的功能提到前面，但我觉得改起来费功夫，一直没动手。

这个月初 token 比较多，想着干脆让 AI 来搞吧。让 AI 重新设计了工具栏的添加方式，现在完全支持自定义，顺序自己定，默认还是原来的。inBox 笔记里接近 20 个功能入口，全部可以自己选择添加或调整。

把权利交给用户，这事不亏。

### 桌面小组件优化了

这个版本也让 AI 优化了桌面小组件。

之前小组件的展示和刷新都有问题，这次让 Gemini 系统性地排查了一遍，做了优化。现在刷新、删除都很流畅，渲染也精简了，去掉了多余的麦克风符号。

### AI 入口，先下了

inBox 笔记很早就加入了 AI 功能，可以设标签、写标题、加批注。

但说实话，用的人不多。我自己用了一段时间也不怎么用了，感觉嵌入方式不够自然，有点硬塞进去的感觉。

还有一个现实问题：某些应用市场对 AI 功能有上架要求，每次更新要打两个包，挺麻烦的。

所以这次干脆把 AI 入口先隐藏了，后面就只打一个包。

不过我一直在想，AI 和笔记的结合到底该怎么做。初步的想法是走智能体的方向——让 inBox 笔记支持更多工具调用，让 AI 去调用，做一个本地的笔记智能体。不过这只是个想法，后面再说。

如果有人真的需要 AI 功能，单独联系我就行。

### 其他优化

侧边栏标签算法优化了，加载更快。主页卡片的代码结构也精简了，这些大家看不见，但用起来会更顺手。

### 618 活动预告

inBox 笔记 618 会做活动，具体时间到时候通知。活动期间会有优惠，有想法的同学可以关注一下。

---

**相关阅读**

- [inBox 笔记 2.3.6 更新了](https://mp.weixin.qq.com/s/4bxKVLpXQXqfJXNhQeWqzA)
- [不只是爱好](https://blog.gudong.site/2026/05/09/not-just-a-hobby.html)

---

<section style="text-align: left;">
  <div><strong>关于咕咚</strong></div>
  <div>inBox 笔记作者，独立开发者，日更写作，每天用 AI 约 8 小时。</div>
  <div>我的作品：</div>
  <table bgcolor="#eff6ff" cellpadding="8" cellspacing="0"><tr><td>
    <a href="https://doc.gudong.site/inbox">✍️ <strong>inBox 笔记</strong><br><small>本地优先 · 隐私安全</small></a>
  </td></tr></table>
  <table bgcolor="#fff7ed" cellpadding="8" cellspacing="0"><tr><td>
    <a href="https://mp.weixin.qq.com/s/JZM1emcSuehKqzcg3iFZjQ">🦞 <strong>咚力圈</strong><br><small>实践社群 · 一起探索</small></a>
  </td></tr></table>
  <br>
  <div>如果觉得不错，随手点个大拇指和爱心～如果想第一时间收到推送，也可以给我个星标⭐</div>
  <div>感谢阅读，明天再见。</div>
</section>


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
