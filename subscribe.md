---
layout: mypost
title: 订阅
---


感谢您对我的博客感兴趣！您可以通过以下几种方式订阅我的博客内容：

### 1. RSS 订阅

如果您使用 RSS 阅读器，可以通过以下链接订阅我的博客更新：

<div class="link-container">
  <a href="{{ site.baseurl }}/static/xml/rss.xml" class="subscribe-btn">RSS 订阅链接</a>
  <div class="rss-url">
    <p>订阅链接: <code>{{ site.domainUrl }}{{ site.baseurl }}/static/xml/rss.xml</code></p>
  </div>
</div>

### 2. 微信公众号

您也可以通过关注我的微信公众号【咕咚同学】获取最新文章和动态。扫描下方二维码即可关注：

<div class="qrcode-container">
  <img src="assets/profile/gongzhonghao.jpg" alt="咕咚同学公众号二维码" class="qrcode">
  <p>微信扫一扫关注公众号</p>
</div>

### 3. 定期访问

您还可以将本站 <a href="{{ site.domainUrl }}{{ site.baseurl }}">{{ site.domainUrl }}{{ site.baseurl }}</a> 添加到您的收藏夹，定期访问获取最新内容。

## 订阅内容

订阅后您将获得：

- 独立开发、技术探索分享
- "咚记"系列日常思考和感悟 
- inBox笔记等产品的更新动态
- 其他有趣的技术和生活内容

感谢您的关注和支持！

<style>
.subscribe-btn {
  display: inline-block;
  padding: 8px 16px;
  background-color: #fff;
  color: #666;
  border: 1px solid #ddd;
  border-radius: 4px;
  text-decoration: none;
  margin: 10px 0;
  transition: all 0.2s;
}

.subscribe-btn:hover {
  background-color: #f5f5f5;
  border-color: #ccc;
}

.qrcode-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin: 20px 0;
}

.qrcode {
  width: 200px;
  height: 200px;
  border: 1px solid #eee;
  padding: 10px;
  border-radius: 4px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.qrcode-container p {
  margin-top: 10px;
  font-size: 14px;
  color: #666;
}

.link-container {
  margin-bottom: 20px;
}

.rss-url {
  margin-top: 10px;
  background-color: #f5f5f5;
  padding: 10px;
  border-radius: 4px;
  border-left: 3px solid #ddd;
}

.rss-url code {
  background-color: #f0f0f0;
  padding: 3px 5px;
  border-radius: 3px;
  font-family: Consolas, Monaco, 'Andale Mono', monospace;
  font-size: 0.9em;
  color: #555;
  word-break: break-all;
}
</style> 