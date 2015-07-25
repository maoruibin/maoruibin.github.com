---
layout: post
title: Android使用WebView加载中文时，乱码问题解决
categories:
  - Android
tags: [WebView,Encode]
---
今天在做软件版本日志信息介绍时（当用户第一次打开软件、或者是软件新版本，那么打开首页就会显示一个软件的版本介绍。这里我用Dialog来显示这些信息，但是因为Android中提供的Dialog对文字的格式化支持的不够好，如果粗体换行等控制，所以就在本地写了一个html文件，然后自定义了Dialog的View，使用WebView作为显示日志更新信息，从而让文本控制变得更加容易。），用到的WebView。日志文件中包含中文，在加载时就出现了乱码，加载方式如下
    
    String formatLodString = buf.toString();
    webView.loadData(formatLodString, "text/html", "UTF-8");

解决方案：
使用webView的方法loadDataWithBaseURL。
    
    String formatLodString = buf.toString();
    webView.loadDataWithBaseURL(null,formatLodString,"text/html","UTF-8",null);
  
  


有用的链接  

[Android webview loadData 中文乱码](http://blog.csdn.net/top_code/article/details/9163597)