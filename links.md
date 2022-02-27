---
layout: mypost
title: 友情链接
---

欢迎各位朋友与我建立友链，如需友链请到评论区留言，我看到留言后会添加上的，本站的友链信息如下

```
名称：{{ site.title }}
描述：{{ site.description }}
地址：{{ site.domainUrl }}{{ site.baseurl }}
头像：{{ site.domainUrl }}{{ site.baseurl }}/static/img/logo.jpg
```

<div style="display:flex;flex-direction:  column">
  {%- for link in site.links %}
    <div style="display:flex;width:100%;">
      <div style="display:flex;width:100%;margin-bottom:16px;">
        <div style="text-decoration: none;">
          <a href="{{link.url}}" style="display: block;border-bottom:none;">
          <img style="border:0px solid #f00;width:50px;height:50px;border-radius: 50%;" src="{{ link.header }}">
          </a>
        </div>
        <div style="margin-left:12px;margin-top:0px;display:flex;flex-direction:column">
          <p style="border:0px solid #000;height:28px;">
            <a href="{{ link.url }}" title="{{ link.desc }}" target="_blank" >{{ link.title }}</a>
          </p>
          <div style="border:0px solid #000;font-size:12px;height:14px;">{{link.desc}}</div>
          <!-- <div style="border:0px solid #000;font-size:12px;height:24px;">{{link.tag}}</div> -->
        </div>
      </div>
    </div>
  {%- endfor %}
</div>
