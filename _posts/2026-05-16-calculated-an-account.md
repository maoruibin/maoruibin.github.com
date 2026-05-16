---
layout: mypost
author: 咕咚
tags: 'daily'
categories: blog
title: "算了一笔账"
---

![封面](https://gudong.s3.bitiful.net/weimd/cover.png)

录音咚支持录音转文字和 AI 润色，一开始只想给自己用，后来想开放出去。这就涉及成本了。

阿里云的语音转文字，每小时 1.56 元。说高不高，但每个用户用一次我就要花一次钱。

今天花了很多时间算定价，反复算了好几遍。

目前的方案：

- 免费用户：每天 6 分钟，每个录音最多 2 分钟
- Pro：68 元/年，每天 20 分钟
- Pro Plus：128 元/年，每天 60 分钟

如果每个买了 Pro 的用户每天用满 20 分钟，一年下来我反而要亏 120 到 122 元。用户越多，亏得越多。

而且还没算 DeepSeek 做 AI 润色的费用。录音转文字是一笔，AI 润色我用的是自己的 DeepSeek Key，免费给用户用，也没算进去。实际成本只会更高。

但暂时我不管了。

开发软件就是这样，尤其是个人软件，没必要一开始就把价格定得那么精确。首先就没有流量，如果可丁可卯地计算，可能用户本来就很少，一二百块钱的额度根本用不完。

先不考虑那么多，用低价吸引一部分用户，让软件先跑起来。如果后续真的有大量用户进来，我这边能监测到，到时候再调整价格。

要真有人多用，那是好事。

今天开发完之后，给自己留了后路——在云端配置了不同用户权益的调整入口。如果后续发现使用时长导致花费太多，可以缩小额度。

当然，这只是一个后话。很可能软件最后都没人用，不必想太多，先做出来。

今天录音咚已经用起来了，每天用它写公众号、写日记，很舒服。

**相关阅读**

- [inBox 笔记 2.3.3：一个人 + AI，两周 32 项更新](https://mp.weixin.qq.com/s/mhVirAa1vEGLPxW63NKE4A)
- [也得紧巴巴过日子了](https://mp.weixin.qq.com/s/xeVOy8PvFYe6KiUpdnRNlQ)
- [token 焦虑又没了](https://mp.weixin.qq.com/s/sL9W9DF3_D0-4z1hKG8JBQ)


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
