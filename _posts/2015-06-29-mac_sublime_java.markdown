---
layout: post
author: 咕咚
title: MAC 系统如何使用 Sublime Text 3 直接编译运行java代码
catalog:    true
tags: Mac Tools
categories: tech 
---
在Mac下使用Sublime时，如果要编译java文件，直接使用command+B命令就可以达到编译的效果，此时会在java源文件的目录下生成对应的.class文件，但这显然不能够满足我们的需求。
如何才能直接编译并运行java代码呢？


我最终通过如下解决方案，达到了command+B 在Sublime控制台显示运行结果的效果


## 第一步

打开Finder 应用程序-> Sublime Text -> 右击 显示包内容 -> /Contents/MacOS/Packages/Java.sublime-package

## 第二步

替换这个压缩文件夹下面 JavaC.sublime-build 的文件内容为

    {
    "cmd": ["java", "$file_base_name"],
    "file_regex": "^ *\\[javac\\] (.+):([0-9]+):() (.*)$",
    "selector": "source.java"
    }

ps:这个地方小费了点功夫，在mac上没有合适的软件可以编辑Java.sublime-package 这个文件里面的内容，后来我是这么做的，把文件发送到windows电脑上，然后用360压缩解决。

## 第三步  

 重新打开Sublime，使用快捷键command+B进行编译然后直接运行，然后控制台打印出 HelloWorld字符串，如下所示，妥妥的。

 ![运行成功](/assets/sublime_java.png "运行成功效果图")
