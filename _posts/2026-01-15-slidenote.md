---
layout: mypost
author: 咕咚
tags: daily
categories: blog
title: "侧边笔记，常伴左右：我用 Claude Code 开发了一个浏览器插件"
---

![](https://gudong.s3.bitiful.net/weimd/1768443166661_image.png)

最近做了一个小工具：SlideNote，中文名「侧边笔记」，如下图所示，这是一个谷歌浏览器插件，在浏览器的右侧会有一个记录区域，方便做简单的记录，开发这个插件的想法源于我自己的需求。

![](https://gudong.s3.bitiful.net/weimd/1768442831583_image.png)


### 1. 我的痛点

我是个开发者，工作中经常要快速记录一些临时信息：常用的命令、API 密钥、服务器 IP 地址、甚至是一些乱七八糟的信息。

这些信息存在哪里最方便？

有些人用系统便签，有些人用专门的笔记软件。但我每天工作，浏览器是花时间最多的地方。为了「最短路径」，我把这些信息都存在了一个浏览器插件里。

这个插件我用了两年多，简单、稳定、没有花哨的功能。

![图 1：我之前用的笔记插件](https://gudong.s3.bitiful.net/weimd/1768442767291_image.png)

但上周，越用越不舒服。

为啥呢？这个插件是「阻断式」的——打开它，整个网页就被遮住了，你只能在插件里操作。复制一条信息，关闭插件，粘贴到网页，想再复制另一条——又要重新打开插件。

来来回回，打断了工作流。

### 2. 解决方案

与此同时，我发现 Chrome 去年新增了一个功能：侧边栏（Side Panel）。

插件可以不再占据整个页面，而是在浏览器右侧留出一片独立空间。点击插件图标，侧边栏滑出；点击网页，侧边栏收起——互不干扰。

豆包和一些 AI 助手已经用上了这个特性。


![图 3：Chrome 侧边栏特性](https://gudong.s3.bitiful.net/weimd/1768443041587_image.png)

那我为啥不做一个自己的笔记插件呢？

说干就干。

在 Claude Code 的帮忙下，两天时间，SlideNote 就诞生了。

### 3. 什么是 SlideNote

SlideNote 是一个 Chrome 浏览器侧边栏笔记插件。

点击图标，侧边栏展开，左右分栏展示：左边是笔记列表，右边是笔记内容。点击即可切换，复制粘贴不再被打断。

它有两个特点：

**第一，极简轻量。**

打包后只有 24KB，没有框架依赖，加载速度小于 100ms。安装即用，不需要注册登录。

**第二，云端同步。**

数据基于 Chrome Storage API，存在你的 Google 账号下。换一台电脑，登录同一个 Google 账号，笔记自动同步。

数据都在本地和谷歌云端，不存在第三方服务器，隐私安全。

**最后，一个承诺：保持简单。**

SlideNote 是便利贴，不是笔记本。

所以它不会有：
- ❌ 复杂的标签分类
- ❌ 知识图谱、双向链接
- ❌ 协作分享、版本历史
- ❌ 跨平台笔记客户端

它只做一件事：让你在浏览器里，快速记录、随时取用碎片信息。

如果你需要写长文章、整理知识库，用 Notion、Obsidian 更合适。

### 4. 适用场景

除了我说的开发者场景，还有很多地方可以用：

**AI 提示词管理。**

在 DeepSeek、Claude 这些 AI 工具里，你可能有常用的提示词模板。放在侧边笔记里，用时复制粘贴，修改一下主题就能发送。

**学习时记笔记。**

在 B 站看视频学习，一边看视频，一边在侧边记笔记。左边播放，右边记录，体验很好。

![图 4：一边看视频一边记笔记](https://gudong.s3.bitiful.net/weimd/1768485167513_image.png)

**运营人员的信息管理。**

客户信息、账号密码、文案模板、素材链接，都可以放在侧边笔记里，随时取用。

### 5. 其他特性

我还顺手做了几个小功能：

- Markdown 支持——输入 Markdown 语法，实时渲染预览
- 富文本复制——复制带样式的文本，可直接粘贴到其他应用
- 搜索过滤——实时搜索标题和内容
- 自动保存——停止输入 1 秒后自动保存

![图 5：Markdown 预览模式](https://gudong.s3.bitiful.net/weimd/1768485046367_image.png)

目前是 v0.0.5 版本，后续也会继续根据自己需求优化，但这个工具一定会保持简单，不会做复杂。

### 6. 如何安装

SlideNote 已经上架 Chrome 应用商店。

**方式一：在线安装（推荐）**

[点击这里前往 Chrome 应用商店](https://chromewebstore.google.com/detail/appaojacakbjbbellfehlgjophpdpjom)

点击「添加至 Chrome」即可安装使用。

**方式二：本地安装**

下载地址1：[https://gudong.s3.bitiful.net/asset/SlideNote-v0.0.5.zip](https://gudong.s3.bitiful.net/asset/SlideNote-v0.0.5.zip?no-wait=on)

或者从 [GitHub Releases](https://github.com/maoruibin/SlideNote/releases) 下载安装包，解压后在 `chrome://extensions/` 开启开发者模式，加载即可。

**方式三：从源码构建**

```bash
git clone https://github.com/maoruibin/SlideNote.git
cd SlideNote
npm install
npm run build:prod
```

然后加载 `dist` 文件夹到 Chrome 扩展程序。

### 7. 写在最后

SlideNote 的 Slogan 是「侧边笔记，常伴左右」。

它解决的是我的一个小痛点，但也可能帮到更多人。如果你也需要在浏览器里快速记录、随时取用信息，不妨试试。

目前支持 Chrome 浏览器，微软 Edge 应该也可以。国内浏览器暂未测试，推荐用 Chrome 体验。

项目已开源，[GitHub 链接](https://github.com/maoruibin/SlideNote)。

如果觉得有用，欢迎给个 Star，也推荐给有需要的人。

---

我是咕咚，好工具，值得被更多人看见。

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
