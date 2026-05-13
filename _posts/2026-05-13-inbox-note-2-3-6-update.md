---
layout: mypost
author: 咕咚
tags: 'daily'
categories: blog
title: "inBox 笔记 2.3.6 更新了"
---

![封面](https://gudong.s3.bitiful.net/weimd/cover.png)

inBox 笔记 2.3.6 打包好了，马上就更新出来。

### 导出功能，终于好用了

这个版本最大的优化，是导出功能。

之前一直有人反馈：只能导出笔记内容，不能导出附件。希望导出的时候，把笔记里的图片和附件都导出到一个文件夹里，笔记里引用图片用相对路径。这样就可以直接在 Obsidian 用了。即使不在其他地方用，至少也是一个完整的笔记包。

之前的导出页面是我自己设计的，说实话有点混乱。inBox 支持导出 JSON、CSV、纯文本、Markdown，还能导出到 Obsidian 和思源，但这些东西全混在一起，我自己说着都觉得乱。

这次让 AI 帮忙重新设计了一下，它很快给出了一个方案——把格式和目的地拆开。新的界面确实比我好太多了，不得不说。

### 活动通知，不再错过

inBox 笔记每年搞三次活动：618、双 11、春节。

之前活动的时候，我只能在微信群或朋友圈发公告。App 里没有通知入口，很多用户根本不知道在搞活动。

这次加了一个活动弹窗，后端改个配置就能下发，用户打开 App 就能看到。对软件收入影响很直接，但我一直拖着没做，这次终于搞定了。

不过这个弹窗只有活动的时候才会出现，平时看不到。看到了就是 bug。

### AGP 大版本升级

这个版本还做了一件我一直想做的事——AGP 升级。

AGP 是安卓构建的核心插件，我一直用的 4.x 版本。不是不想升级，是升级要改的地方太多了，之前自己手动试过，失败了。

这次升级了 Android Studio，必须要升到 7.0+。一狠心，让 AI 全程操作，跨了几个大版本，顺畅了很多。

当然，非常费 token。还好用的是谷歌免费的额度，但升级完当天就把额度耗光了。

---

下面是完整的更新日志，后续会逐步上架到各个市场。

<!-- 更新日志截图位置 -->


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
