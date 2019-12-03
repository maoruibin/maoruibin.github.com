---
layout: post
author: 咕咚
title:  "build.gradle最佳实践之buildConfigField"
description:  "AndroidStudio中使用build.gradle的最佳实践"
catalog:    true
tags: Gradle Collection
categories: tech
---
使用 AndroidStudio 进行开发，其中很重要的一个文件就是 build.gradle，它是整个项目编译打包的控制中心，这里收集一些日常会用到的语法或者使用技巧，以备后用。

## 定义清单文件占位变量
以下为一个清单文件占位符号
```
<intent-filter ... >
        <data android:scheme="http" android:host="${hostName}" ... />
</intent-filter>
```
只需要在 gradle 文件中这样定义，即可使用：
```gradle
android {
        defaultConfig {
            manifestPlaceholders = [hostName:"www.example.com"]
        }
}
```

默认情况下，编译工具还会在 `${applicationId}` 占位符中提供应用的应用 ID。该值始终与当前编译的最终应用 ID（包括编译变体的应用 ID 更改）一致。

> 更多查看 [将编译变量注入清单  \|  Android Developers](https://developer.android.com/studio/build/manifest-build-variables)

## 定义 BuildConfig 常量
```
// 定义 int 常量
buildConfigField("int" , "LimitCount" , "12")
// 定义 bool 常量
buildConfigField 'boolean', 'isPro', 'true'
```



## 定义 Res 资源

```
// string 资源
resValue "string", "app_name", "云图debug"
```

## 定义包名、版本号后缀

```
// 包名后缀
applicationIdSuffix ".debug"
// 版本号后缀
versionNameSuffix "-full"
```

