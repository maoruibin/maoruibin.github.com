---
layout: post
author: 咕咚
title: Android使用WebView加载中文时，乱码问题解决
catalog:    true
tags: Experience
categories: tech 
---
在做App+这个项目时，使用了WebView来展示更新日志，但是在加载本地Html文件的时候，出现了乱码问题。这篇博客记录自己错误出现的原因
、以及解决方法。

由于本地Html文件日志文件中包含中文，在加载时就出现了乱码，加载方式如下


    String formatLodString = buf.toString();
    webView.loadData(formatLodString, "text/html", "UTF-8");

解决方案：
使用webView的方法loadDataWithBaseURL。

    String formatLodString = buf.toString();
    webView.loadDataWithBaseURL(null,formatLodString,"text/html","UTF-8",null);




有用的链接  

[Android webview loadData 中文乱码](http://blog.csdn.net/top_code/article/details/9163597)
