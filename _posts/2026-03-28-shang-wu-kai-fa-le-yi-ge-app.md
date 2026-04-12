---
layout: mypost
author: 咕咚
tags: daily
categories: blog
title: "打了会球，顺便开发了一个 APP"
---

今天是周六，上午我一直在休息，忙了一周，确实需要放松放松。

![](https://gudong.s3.bitiful.net/weimd/1774700440696_image.png)

早晨醒来后写了一会教程，然后就想去公园打球，即使这样，上午还是顺手让小龙虾开发了一个 APP。

这听着可能很不可思议，但这是一件很有意思的事。

### 1. 起因

上午我一直在写教程，用的是[小龙虾](https://mp.weixin.qq.com/s/boOwTBKhUvR_-5UE73tfmw)，让它帮我写。

写完之后，我想在手机上阅读，因为文章比较长，我就让它把写完的 markdown 文件发到聊天框。文章里有表格、流程图，我点击文件预览时，系统弹出一堆应用程序，但它们对 markdown 的渲染支持得不好，尤其是表格和流程图。

我觉得也没什么大事，准备出去放松休息。

### 2. 临出门的想法

临出门的时候，我突然想——那我可以搞一个 APP，专门支持 markdown 渲染表格、图表、流程图。

我就告诉小码牛（我的编码[智能体](https://mp.weixin.qq.com/s/xMXyX9AiCK4x7wmO2hRNmQ)），让它帮我开发一个。

我只说了要求：在手机上点击 markdown 文件时，希望我们的软件出现在应用列表里，并且支持渲染表格、图表、流程图。

然后我就出去了，去公园打球。

### 3. 还没到公园就好了

我还没到公园呢，它已经把软件开发好了，安装包也打包好了，上传到云端给了我链接。

我打开链接，发现真可以。

我赶紧试了一下——从手机上点开一个 markdown 文件，看我们的软件会不会出现在列表里，渲染是不是 OK。

完全 OK。

![](https://gudong.s3.bitiful.net/img/836e4ae1.png)

它后来找了一些技术方案，就做到了。

后来我还让它打了一个正式包，也打包好了，最终用的是 Flutter 方案。

全程我只用对话，最终生成了一个 APP。

### 4. APP 成了消费品

我在想，这个 APP 我肯定不会去推广，可能只是我个人用一下。

但成本已经降到了"一句话的事"——只要你有想法，很快它就给你一个产品。

就像之前有些人预测的，以后的 APP 可能就是一个"基础产品"。我需要的时候，让 AI 开发一个，开发完成之后用完可能就不再需要了。

或者下次有别的需求，可以重新让它生成一个。

### 5. 定义问题很重要

所以现在也说，定义问题很重要。

你能准确地把自己的想法、场景想出来，这个事情很重要。

还有就是好奇心——一开始做的时候，我觉得可能会失败，比如安装之后崩溃之类的。但就像试试看效果，结果超预期，用 Agent 开发 App 会越来越简单，门槛也会越来越低。

---

**相关阅读：**

- [消灭 IDE](https://mp.weixin.qq.com/s/xxxxx)
- [最短路径不是最快路径](https://mp.weixin.qq.com/s/gpLWJoFlyXnUX_JUfCcDfNxQilj2nYrtVuj_iQWLQgJZ9V_RmuSkFU6rEEXnrtC3)
- [属于创造者的黄金时代](待发布)

---

**关于咕咚**

inBox 笔记作者，独立开发者，每天用 AI 约 8 小时。

我的作品：
- [inBox 笔记](https://doc.gudong.site/inbox) - 本地笔记，数据自主
- [点亮](https://doc.gudong.site/light/) - 打卡软件，记录坚持
- [咚力圈](https://mp.weixin.qq.com/s/JZM1emcSuehKqzcg3iFZjQ) - AI 实践社群，一起搭建个人智能助手

关注我：
- 即刻：[咕咚同学](https://okjk.co/l8IUzO)
- 公众号：咕咚同学

![公众号二维码](https://blog.gudong.site/assets/profile/gongzhonghao.jpg)
