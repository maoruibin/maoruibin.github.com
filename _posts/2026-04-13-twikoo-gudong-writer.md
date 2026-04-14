---
layout: mypost
author: 咕咚
tags: 'daily'
categories: blog
title: "10 分钟，换了博客评论系统"
---

博客换了新评论系统，从开始到搞定，只用了10分钟，说实话我自己都没想到。

之前的评论系统用了好几年，一直有个硬伤——得注册 GitHub 账号才能评论。开发者倒是无所谓，但普通读者哪有 GitHub 账号，很多人想留言却留不了，挺亏的。

有个读者在评论里提了一嘴 Twikoo，说这个不错，我就去搜了一下。

![](https://gudong.s3.bitiful.net/img/435a9e98.png)

一看就觉得挺对味，支持多种部署方式，其中有一个是 Docker 部署。正好我阿里云轻应用服务器上装了 Docker，这不就是现成的基础设施嘛。



我的博客从 2015 年开始折腾，中间换过好几个评论系统，从 Disqus 到 Gitment，再到 Gitalk，每次换都是一番折腾。但这次，我想换个方式。

![](https://gudong.s3.bitiful.net/img/2ff9d977.png)


我把需求直接丢给了 Claude Code，大意就是：帮我把博客评论系统换成 Twikoo，用 Docker 部署到我的阿里云服务器上。

Claude Code 很快给了一整套操作流程，一步一步，清清楚楚。

那一刻我突然觉得，自己特别像电影里的特工。

![](https://gudong.s3.bitiful.net/weimd/file_12---4b29af40-21ff-4225-98bc-69b8d9edf911.jpg)



戴着耳机，耳机那头是一个超级大脑，冷静地指挥你：第一步，打开宝塔面板，添加一个新站点；第二步，配置 SSL 证书，启用 HTTPS；第三步，在宝塔配置反向代理，在 Cloudflare 添加 DNS 记录；第四步，验证服务是否正常；最后一步，替换博客里的评论组件。

![](https://gudong.s3.bitiful.net/img/8fea2ad4.png)



我就这么一步一步照着做，每做完一步，Claude Code 就告诉我下一步该干嘛。

整个过程我给自己设了30分钟的时限，想着再怎么慢，半小时也该搞完了。

结果10分钟就全部搞定，包括 SSL 证书和 Cloudflare 配置，别写这篇文章的时间都要短😂。

说实话，那种感觉挺好的，像真的完成了一次任务。

![](https://gudong.s3.bitiful.net/img/ad81d1b2.png)



新的评论系统用起来简单多了，不用注册任何账号，输入昵称和邮箱就能直接评论，跟以前逛论坛一样。而且评论数据全部存在我自己的云服务器上，不依赖第三方，心里踏实多了。

![](https://gudong.s3.bitiful.net/img/3a8a7dfe.png)


从 2015 年到现在，博客写了快十年，评论系统换了一轮又一轮，这次是最快、最满意的一次。不是因为我技术多厉害，是因为有了 Claude Code 这个"耳机里的超级大脑"，把本来要折腾半天的事情，压缩到了喝杯咖啡的时间。

挺好的，工具就该这样，让人把精力花在真正重要的事情上。如果你也有个一直拖着没搞的技术债，不妨试试 AI 助手，也许 10 分钟就搞定了。


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
