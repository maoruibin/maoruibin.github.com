---
layout: post
author: 咕咚
title: "关于AppPlus的点点滴滴"
description: ""
cover:  "#3F51B5"
categories: Technology
tags: Android App
---
AppPlus从今年7月份开始开发，到现在不知不觉已经过了5个多月了，今晚刚发布完0.3.0版本，突然想写点什么，所以就有了这篇文章。

关于 AppPlus 是什么，可以查看我的另一篇文章，关于[AppPlus](),今晚刚发布了 AppPlus 的0.3.0版本，其实在定版本号时，
我一直在犹豫要不要直接设为1.0.0版本呢，因为相比之前的版本迭代，这次的更新内容超多，下面是这次的更新日志

    0.3.0
    
        修改:   更改应用名称为AppPlus(12-06)
        新功能: 增加App详情展示页(12-06)
        新特性: 增加版本号标示(在应用详情页会展示)(12-07)
        优化:   更改导出APK的文件默认名称，增加版本标示(感谢 @于世新 建议)(12-07)
        修复:   Android4.4以上机型更换主题后，状态栏颜色不一致问题 (12-07)
        新特性: 适配 Android L 转场动画(12-08)
        新特性: 在Android L 以上设备无需获取权限即可获取正在运行的进程信息(感谢 @Jared Rummler)(12-11)
        新特性: 增加了英文版(12-16)
        调整:   首页右上角菜单按钮增加 意见反馈项(12-17)
        调整:   修改APK文件的本地存储目录为AppPlus(12-17)
        优化:   极大的改善应用的稳定性(12-17)

这次版本相比前面的版本，变化挺大，主要有以下几点。

* 加入数据库框架([lite-orm](https://github.com/litesuits/android-lite-orm))，用于存储应用信息
* 使用开源库 [AndroidProcesses](https://github.com/jaredrummler/AndroidProcesses),用于查询最近运行的程序
* 对主页的 Item 优化，变得更简洁
* 增加应用详情页


 
 
        