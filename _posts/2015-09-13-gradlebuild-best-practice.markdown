---
layout: post
author: 咕咚
title:  "build.gradle 最佳实践集合"
description:  "AndroidStudio中使用build.gradle的最佳实践"
catalog:    true
tags: Gradle Collection
categories: tech
---
使用 AndroidStudio 进行开发，其中很重要的一个文件就是 build.gradle，它是整个项目编译打包的控制中心，这里收集一些日常会用到的语法或者使用技巧，以备后用。

## 排除依赖包中的 support 依赖

```groovy
implementation ('com.github.anzewei:parallaxbacklayout:1.1.9'){
     exclude group: "com.android.support"
}
```

通过 exclude 排除掉依赖包中的 support 依赖，这样可以解决跟主工程的冲突问题，其他的重复也可通过类似的方式解决。

## 指定签名信息

签名信息比较隐私，不应该直接出现在项目中，可以把密钥文件、密码、账号，存储在本地的文件夹，然后把这个信息定义在 lcoal.properties 文件中，并且让该文件不受 git 版本控制，通过 .gitignore 文件过滤。

如下是具体的签名信息指定方式

在主 app 的 build.gradle 文件中这样配置

```groovy
defaultConfig{
    signingConfigs {
        //指定名叫release的一个签名对象，下面会动态根据配置文件设置属性
        releaseConfig
    }
    buildTypes {
        release {
            if (signingConfigs.releaseConfig != null) {
                signingConfig signingConfigs.releaseConfig
            }
        }
}
```

在 gradle 文件 android 同级配置下设置 releaseConfig 信息

```groovy
Properties props = new Properties()
def propFile = file('../local.properties')
if (propFile.exists()) {
    props.load(new FileInputStream(propFile))
    if (props != null &&
            props.containsKey('SIGN_FILE') && props.containsKey('SIGN_KEYSTORE_PASS') &&
            props.containsKey('SIGN_KEYSTORE_ALIAS') && props.containsKey('SIGN_KEYSTORE_ALIAS_PASS')) {
        android.signingConfigs.releaseConfig.storeFile = file(props['SIGN_FILE'])
        android.signingConfigs.releaseConfig.storePassword = props['SIGN_KEYSTORE_PASS']
        android.signingConfigs.releaseConfig.keyAlias = props['SIGN_KEYSTORE_ALIAS']
        android.signingConfigs.releaseConfig.keyPassword = props['SIGN_KEYSTORE_ALIAS_PASS']
    } else {
        android.buildTypes.release.signingConfig = null
    }
} else {
    android.buildTypes.release.signingConfig = null
}
```

local.properties 文件内容

```groovy
SIGN_KEYSTORE_PASS=******
SIGN_FILE=/Users/ruibin1/Downloads/work/key/****.jks
SIGN_KEYSTORE_ALIAS_PASS=******
SIGN_KEYSTORE_ALIAS=******
```



## 定义清单文件占位变量
以下为一个清单文件占位符号
```groovy
<intent-filter ... >
        <data android:scheme="http" android:host="${hostName}" ... />
</intent-filter>
```
只需要在 gradle 文件中这样定义，即可使用：
```groovy
android {
        defaultConfig {
            manifestPlaceholders = [hostName:"www.example.com"]
        }
}
```

默认情况下，编译工具还会在 `${applicationId}` 占位符中提供应用的应用 ID。该值始终与当前编译的最终应用 ID（包括编译变体的应用 ID 更改）一致。

> 更多查看 [将编译变量注入清单  \|  Android Developers](https://developer.android.com/studio/build/manifest-build-variables)

## 定义 BuildConfig 常量
```groovy
// 定义 int 常量
buildConfigField("int" , "LimitCount" , "12")
// 定义 bool 常量
buildConfigField 'boolean', 'isPro', 'true'
```



## 定义 Res 资源

```groovy
// string 资源
resValue "string", "app_name", "云图debug"
```

## 定义包名、版本号后缀

```groovy
// 包名后缀
applicationIdSuffix ".debug"
// 版本号后缀
versionNameSuffix "-full"
```

