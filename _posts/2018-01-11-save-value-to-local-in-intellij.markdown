---
layout: post
author: 咕咚
title: "开发 Intellij 插件（如AndroidStudio 插件）时如何在本地保存状态值"
catalog: true
cover-color: "#5e73cf"
shang: true
qrcode_mp: true
categories: tech 
tags: Skills
---

开发 Intellij 插件时，比如自己最近开发的一个 AndroidStudio 插件，需要存储一些状态值，方便做一些 UI 上的偏好设置。

比如这次选中了一个选项，希望下次打开插件时继续选中相应的选项，此时就需要做一些本地状态存储。就像 Android APP 常见的设置选项。

Intellij 也提供了响应的 API - `PropertiesComponent` ，使用方式如下所示：
## 存数据到本地
```java
PropertiesComponent.getInstance().setValue("key","valuw");
```

## 获取数据
```java
String value = PropertiesComponent.getInstance().getValue("key");
```

Source frmo [咕咚的个人站点](http://gudong.site/)

## 参考链接
[Persisting State of Components](https://www.jetbrains.org/intellij/sdk/docs/basics/persisting_state_of_components.html?search=Serialization)

