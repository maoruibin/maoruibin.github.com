---
layout: post
author: 咕咚
title: "AppPlus：传送、分享 APK 到其他手机"
description: "一个主要用 Android 用户间传送 Apk 文件、管理手机应用的工具软件。"
cover-color:  "#3F51B5"
catalog:    true
tags: 随想 App 效率 Android
categories: product
---
AppPlus 是自己2015年七月份开始做的一个小产品，它是一个主要用Android用户间传送Apk文件、管理手机应用的工具软件。

目前已开源，[开源地址](https://github.com/maoruibin/AppPlus)

## 为什么要做这个软件

### 一、我想用最少的步骤打开最近运行的应用详情界面

 因为是开发者的缘故，我经常需要清理应用缓存数据，一般的做法时，找到系统设置->应用管理->找到对应的应用->打开应用详情界面，然后清理数据，
 而且手机应用那么多，找应用也是个很麻烦的事，这个过程至少需要30秒左右的时间不止。

 不过在这一点上，MIUI 做的不错，点击桌面菜单，显示出最近运行的应用列表，长按即可打开应用详情，在其他 ROM 上你只能去系统设置中找，好麻烦。

 当然在使用 AndroidStudio 进行开发的过程中，AS 插件库里也已经有插件([adb-idea](https://github.com/pbreault/adb-idea))
 可以做到一键清数据，但是他只能针对调试中的应用，如果我想清理其他 APP 的缓存，他就不行了。

 所以我需要一个 APP 能帮助我显示出最近打开的应用，并且提供一个按钮可以打开应用详情界面。

 Update:最近刚看到一个有用的Api可以方便的清除应用的缓存数据

    /**
    * Permits an application to erase its own data from disk.
    * This is equivalent to the user choosing to clear the app's
    * data from within the device settings UI.It erases all dynamic
    * data associated with the app -- its private data and data in its
    * private area on external storage -- but does not remove the
    * installed application itself, nor any OBB files.
    */
    ActivityManager.clearApplicationUserData()

这个方法由 `ActivityManager` 提供，可一键清理app产生的用户数据。   

### 二、我想方便快捷的导出手机中已安装应用的安装包

 一些情况下，开发者需要一些应用的安装包，比如自己以前因为做手机卫士没有合适的图标，所以只好找到360手机卫士的安装包，然后解压缩，从而使用
 现成的素材，谁叫自己不会 PS 呢，很多时候下载软件好办，Android市场那么多，只要自己想找，下载软件还是不难的，但是拿到对应的软件安装包好像不是那么容易。
 但事实上，只要在 Android 手机中安装了应用，这个应用的安装包就已经存在于手机了。

 这里说明一个事实，安装在我们手机中的每一个的 APP ，在手机中都存在他对应的安装包文件，不像Windows程序，
 当你下载好 QQ 的安装包 QQ.exe,点击安装后，除非你人为保存安装包，系统是不会给你把安装包存下来的，Android 不一样，他会把应用的安装包
 都存在本地。

 所以在 Android 手机上，只要知道了应用的安装包路径，导出还是挺容易的，不就是复制到一个自己指定的目录吗。这也不是什么高深的技术。

 另外，尽管市场上已经有很多可以提供导出安装包功能的软件，我为什么还要自己做一个?

 因为，他们都做得太 low 了。糟点太多。举个例子说明下。

 自己曾经用过一个安装包导出软件，首页用一个列表展示所有已安装的应用，然后只要点击一个 item ，安装包就会导出。

 导出成功后会『友好』的弹出一个 Toast ，提示安装包已导出，顺便在 Toast 中指明导出的路径，如下所示

![](http://7xr9gx.com1.z0.glb.clouddn.com/appplus_about_1.png)

 但是因为 Toast 的弹出时间太短了，以至于我一次很难记住安装包到底被导出到那个路径下了，所以一般你需要再次导出一次，然后
 特意去注意 Toast 上提示的路径，你才可以记住导出的路径。It's too bad !

 当然，我在 AppPlus 中在实现导出 Apk 这一功能时，这个问题肯定得到了很好的解决。具体怎么解决，可以自己体验下试试。[立即下载](http://fir.im/appplus)

### 三、不喜欢广告。

  用户体验这么差，怎么好意思加广告！

### 四、学习

  一方面学习 GoogleIO 2015大会新放出的最新的一些组件，另一方方面是学习实践 MaterialDesign，因为自己太喜欢 MD 的设计风格了，
  没办法，尽管目前国内 MD 的设计风格 还没有流行开，但是自己就是这么喜欢。

综上所述，就是自己开发这个 App 的所有原因。
