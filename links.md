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
```

<div class="friend-links-container">
  {%- for link in site.links %}
    <div class="friend-link-card">
      <div class="friend-link-avatar">
        <a href="{{link.url}}" target="_blank">
          <img src="{{ link.header }}" alt="{{ link.title }}">
        </a>
      </div>
      <div class="friend-link-info">
        <a href="{{ link.url }}" title="{{ link.desc }}" target="_blank" class="friend-link-title">{{ link.title }}</a>
        <div class="friend-link-desc">{{link.desc}}</div>
      </div>
    </div>
  {%- endfor %}
</div>

<style>
.friend-links-container {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 15px 20px;
}

@media (max-width: 768px) {
  .friend-links-container {
    grid-template-columns: 1fr;
  }
}

.friend-link-card {
  display: flex;
  padding: 10px 15px;
  border-radius: 8px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease;
  background-color: #fff;
}

.friend-link-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.friend-link-avatar {
  margin-right: 15px;
}

.friend-link-avatar img {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  object-fit: cover;
  border: 1px solid #eee;
}

.friend-link-info {
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.friend-link-title {
  font-size: 16px;
  font-weight: 600;
  margin-bottom: 5px;
  color: #333;
  text-decoration: none;
}

.friend-link-desc {
  font-size: 12px;
  color: #666;
  line-height: 1.5;
}
</style>
