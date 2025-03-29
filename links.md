---
layout: mypost
title: 友情链接
---

欢迎各位朋友与我建立友链，如果您想和我交换友链，可以通过以下方式联系我：

1. 在评论区留言
2. 发送邮件至 [1397516172@qq.com](mailto:1397516172@qq.com)

本站的友链信息如下：

```
名称：{{ site.title }}
描述：{{ site.description }}
地址：{{ site.domainUrl }}{{ site.baseurl }}
头像：{{ site.domainUrl }}{{ site.baseurl }}{{ site.profile_icon }}
标签：随笔 生活 技术 写作 Android 独立开发 
```

<div class="friend-links-container">
  {%- for link in site.links %}
    <div class="friend-link-card">
      <div class="friend-link-avatar">
        <div class="avatar-wrapper">
          <a href="{{link.url}}" target="_blank">
            <img src="{{ link.header }}" alt="{{ link.title }}" onerror="this.style.display='none';this.nextElementSibling.style.display='flex';" style="pointer-events: none;">
            <div class="avatar-fallback">{{ link.title | slice: 0, 1 }}</div>
          </a>
        </div>
      </div>
      <div class="friend-link-info">
        <a href="{{ link.url }}" title="{{ link.desc }}" target="_blank" class="friend-link-title" style="text-decoration: none !important;">{{ link.title }}</a>
        <div class="friend-link-desc">{{link.desc}}</div>
        <div class="friend-link-tags">
          {%- assign tags = link.tag | split: ' ' -%}
          {%- for tag in tags %}
            <span class="tag">{{tag}}</span>
          {%- endfor %}
        </div>
      </div>
    </div>
  {%- endfor %}
</div>

<style>
.friend-links-container {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 15px 20px;
  margin-top: 30px;
}

@media (max-width: 768px) {
  .friend-links-container {
    grid-template-columns: 1fr;
  }
}

.friend-link-card {
  display: flex;
  padding: 15px;
  border-radius: 12px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  background-color: #fff;
}

.friend-link-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
}

.friend-link-avatar {
  margin-right: 15px;
  flex-shrink: 0;
  width: 60px;
  height: 60px;
}

.avatar-wrapper {
  width: 100%;
  height: 100%;
  overflow: hidden;
  border-radius: 50%;
  border: 2px solid #eee;
}

.friend-link-avatar a {
  display: block;
  width: 100%;
  height: 100%;
  text-decoration: none;
}

.friend-link-avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
  pointer-events: none;
  -webkit-user-drag: none;
  user-select: none;
}

.avatar-fallback {
  width: 100%;
  height: 100%;
  background: #f0f0f0;
  color: #666;
  font-size: 24px;
  display: none;
  align-items: center;
  justify-content: center;
}

.friend-link-info {
  display: flex;
  flex-direction: column;
  flex: 1;
}

.friend-link-info a {
  text-decoration: none !important;
}

.friend-link-title {
  position: relative;
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 6px;
  color: #333;
  transition: color 0.3s ease;
  display: block;
  text-decoration: none !important;
  padding-bottom: 6px;
  border-bottom: 1px solid #ddd !important;
}

.friend-link-title:hover {
  color: #4a4a4a;
}

.friend-link-desc {
  font-size: 13px;
  color: #666;
  line-height: 1.5;
  margin-bottom: 8px;
  margin-top: 6px;
}

.friend-link-tags {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
}

.tag {
  font-size: 12px;
  padding: 2px 8px;
  border-radius: 4px;
  background: #f5f5f5;
  color: #666;
}

/* 暗色模式适配 */
html.dark .friend-link-card {
  background: #1a1a1a;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
}

html.dark .friend-link-title {
  color: #e1e1e1;
  border-bottom-color: #444 !important;
}

html.dark .friend-link-title:hover {
  color: #fff;
}

html.dark .friend-link-desc {
  color: #999;
}

html.dark .tag {
  background: #333;
  color: #aaa;
}

html.dark .avatar-wrapper {
  border-color: #333;
}

html.dark .friend-link-avatar img {
  border-color: #333;
}
</style>
