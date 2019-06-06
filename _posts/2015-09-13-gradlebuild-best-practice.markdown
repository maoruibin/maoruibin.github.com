---
layout: post
author: 咕咚
title:  "build.gradle最佳实践之buildConfigField"
description:  "AndroidStudio中使用build.gradle的最佳实践"
catalog:    true
tags: Experience Gradle Collection
categories: blog 
---
使用AndroidStudio进行开发，其中很重要的一个文件就是build.gradle,他是整个项目的控制中心，这里收集一些日常会用到的语法或者使用技巧，以备后用。这篇博客主要说明
buildTypes节点下使用buildConfigField。


下面是默认的buildTypes形式
```groovy
    buildTypes {
        release {
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
            signingConfig signingConfigs.release
        }
    }
```
但是这里其实默认还有一个debug type,只不过默认不显示，显示完整如下
```groovy
    buildTypes {
        release {
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
            signingConfig signingConfigs.release
        }
        debug{
        }
    }
```
这两者用于指定不同的build type，当我们打包编译项目时，我们能不能这里就可以设置一些参数信息，直接可以作用于项目，从而在项目中,动态根据build.gradle中设置的信息，进行一些代码层面的逻辑处理，比如在debug type下正常输出日志信息，但是release type下，屏蔽日志输出。那么就可以通过buildConfigField进行动态设置如下
```groovy
    buildTypes {
        release {
            buildConfigField "boolean", "LOG_DEBUG", "false"
            proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'
            signingConfig signingConfigs.release
        }
        debug{
            buildConfigField "boolean", "LOG_DEBUG", "true"
        }
    }
```
可以看到在上面指定了一个key为LOG_DEBUG的field,在release type下为false，在debug type下为true，具体在代码中就可以这样使用。


因为我在项目中使用了开源库[Logger](https://github.com/orhanobut/logger)进行日志输出，这个lib可以在Application的onCreate方法中进行开关设置，从而控制Log日志是否显示在console，所以最终使用如下：
```java
    if(BuildConfig.LOG_DEBUG){
        Logger.init("AppPlusLog").setLogLevel(LogLevel.FULL);
    }else{
        Logger.init("AppPlusLog").setLogLevel(LogLevel.None);
    }
```
可以看到在build.gradle中设置的属性LOG_DEBUG，在这里可以直接通过BuildConfig这个类进行访问，此时就可以动态的控制Log的输出了，这里当然可以指定更多的关键字，自己根据项目需求发挥即可。


为 Mainfest 文件设置动态变量
```groovy
    manifestPlaceholders = [
            appId:"com.sina.android.ota.debug"
    ]
```

[官方文档地址](https://developer.android.com/studio/build/manifest-build-variables.html)
