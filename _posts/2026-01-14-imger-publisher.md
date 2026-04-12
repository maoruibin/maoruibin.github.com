---
layout: mypost
author: 咕咚
tags: daily
categories: blog
title: "imger publisher"
---

![封面图](https://gudong.s3.bitiful.net/images/cover-2026-01-14-imger-publisher.png)

大家好，我是咕咚。

---

写技术博客时，最烦的是什么？

对我来说，插入图片绝对算一个。

---

### 以前的流程

以前我的流程是：
1. 截图 / 导出图片
2. 打开浏览器，登录图床
3. 拖拽上传
4. 等待上传完成
5. 复制图片链接
6. 回到编辑器，粘贴链接

一遍两遍还好，写一篇长文章要插入十几张图片，真的会让人崩溃。

---

### 现在的方案

最近在玩 [Claude Code](https://claude.ai/code)，发现它的技能系统特别好玩。

于是我就写了一个小技能：**Image Publisher**，把这个流程简化成一句话。

---

### Image Publisher 是什么？

Image Publisher 是一个 Claude Code 技能，让你用一句话就能上传图片到图床。

**使用前：**
```
打开浏览器 → 登录图床 → 上传图片 → 复制链接
```

**使用后：**
```
"上传图片 screenshot.png"
```

就这。完事。

---

### 实际效果

在 Claude 激活环境下，直接说这句话：

> 上传图片 /Users/gudong/Files/screenshot.png

然后图片就上传成功了，很快。

![演示效果图](https://gudong.s3.bitiful.net/images/演示效果图.png)

上传成功后会返回图片地址。

---

### 支持哪些图床？

目前支持两类：

**1. GitHub 图床**
- 完全免费
- 稳定可靠
- 自带 jsDelivr CDN，全球加速

**2. S3 兼容存储**
- 七牛云
- 阿里云 OSS
- 腾讯云 COS
- 缤纷云
- 其他 S3 兼容服务

---

### 怎么用？

**第一步：安装技能**

```bash
git clone https://github.com/maoruibin/image-publisher.git
cp -r image-publisher ~/.claude/skills/
```

**第二步：配置**

```bash
cd ~/.claude/skills/image-publisher
cp .env.example .env
```

编辑 `.env` 文件，填入你的 GitHub Token 或 S3 凭证。

**第三步：在 Claude Code 中使用**

```
我：上传图片 ~/Desktop/screenshot.png

Claude：上传成功！
     https://cdn.jsdelivr.net/gh/user/repo@master/images/screenshot.png
```

---

### 为什么要做这个？

1. **专注**：只做图片上传，不搞那些花里胡哨的功能
2. **简单**：配置一次，永久使用
3. **开源**：[MIT 许可](https://github.com/maoruibin/image-publisher/blob/main/LICENSE)，随便改随便用
4. **集成**：和 Claude Code 无缝集成，自然语言操作

---

### 关于 Claude Code

[Claude Code](https://claude.ai/code) 是 Anthropic 官方的 CLI 工具。简单说，你可以在终端里直接和 Claude 对话来编程。

它的技能系统允许用户自定义功能扩展。我这个小技能就是基于这个系统开发的。

如果你也在用 Claude Code，欢迎试试这个技能。

---

### 项目地址

**GitHub**：https://github.com/maoruibin/image-publisher

如果觉得有用，给个 Star ⭐️

---

这个小工具已经解决了我的痛点，希望也能帮到你。

有问题欢迎在 [GitHub](https://github.com/maoruibin/image-publisher) 提 Issue，或者直接留言交流。

我是咕咚，好工具，值得被更多人看见。

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
