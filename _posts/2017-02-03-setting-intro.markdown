---
layout: post
author: 咕咚
title:  "使用 Android 原生 API 开发设置界面"
description: ""
catalog:    true
tags: Skills
categories: tech 
---
算是 17 年第一篇文章，初衷就是简单介绍下用 xml 配置设置界面，为自定义设置界面 UI 做一个铺垫。


## 场景介绍

为了更好的用户体验，现在的大多数的应用都会提供一个设置界面，供用户去设置一些应用属性，比如用户名、昵称等信息的修改，或者还会有一些消息开关等都会在设置界面中完成。如下所示就是一个常见的设置界面截图（from 咕咚翻译）

<img src="http://7xr9gx.com1.z0.glb.clouddn.com/pref_translate_msg.jpg" style="width:50%;">


 类似这样的设置界面在一个应用中都会或多或少的存在。对于开发者而言，如何快速开发这样的设置界面呢？

如果他对 Android 提供的设置 API 不了解，可能会自然而然的想到使用 layout 去画出来。然后在Activity 中实例化每个 item 对应的 view，接着处理对应的 click、check 等事件。但是这样有很多不足和麻烦。

你需要自己编写布局文件，设置样式，还需要处理设置数据的本地存储逻辑。

其实，Android 早就提供了相应的设置 API 可以方便开发者快速开发设置 UI 。

这就是现在要说的 PreferenceActivity / PreferenceFragment 。


更多关于设置相关的官方介绍可通过 [Setting](https://developer.android.com/guide/topics/ui/settings.html) 查阅。

> 建议直接看官方文档，比这里更加全面。


## 主要API 介绍

见名知意

* [PreferenceActivity](https://developer.android.com/reference/android/preference/PreferenceActivity.html)  偏好设置 Activity 
* [PreferenceFragment](https://developer.android.com/reference/android/preference/PreferenceFragment.html)  偏好设置 Fragment

这俩是 Android 系统提供的两个跟设置相关的 API 组件，使用他们就可以方便快捷的开发出具有统一体验的设置UI。鉴于灵活性，大多数时候个人使用 ·PreferenceFragment 较多，官方也推荐使用 Fragment。

## 开发指南

这部分建议直接看官方文档，很清晰。下面罗列自己简单总结的一些点。

### 几个要点

* 不同于一般的 Fragment, PreferenceFragment  的布局是通过在XML 文件中声明的 `Preference` 类的各种子类构建而成，而不是使用 `View` 对象构建用户界面。
* 您必须将 XML 文件保存在 res/xml/ 目录中。尽管您可以随意命名该文件，但它通常命名为 preferences.xml
* XML 文件的根节点必须是一个 PreferenceScreen 元素。您可以在此元素内添加每个 Preference。在 <PreferenceScreen> 元素内添加的每个子项均将作为单独的项目显示在设置列表中。

如下所示就是一个常规的设置配置文件。

```xml
<?xml version="1.0" encoding="utf-8"?>
<PreferenceScreen xmlns:android="http://schemas.android.com/apk/res/android">
    <CheckBoxPreference
        android:key="pref_sync"
        android:title="@string/pref_sync"
        android:summary="@string/pref_sync_summ"
        android:defaultValue="true" />
    <ListPreference
        android:dependency="pref_sync"
        android:key="pref_syncConnectionType"
        android:title="@string/pref_syncConnectionType"
        android:dialogTitle="@string/pref_syncConnectionType"
        android:entries="@array/pref_syncConnectionTypes_entries"
        android:entryValues="@array/pref_syncConnectionTypes_values"
        android:defaultValue="@string/pref_syncConnectionTypes_default" />
</PreferenceScreen>
```



### 使用配置文件

```
public static class SettingsFragment extends PreferenceFragment {
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Load the preferences from an XML resource
        addPreferencesFromResource(R.xml.preferences);
    }
    ...
}
```

然后，正如您对其他任何 `Fragment` 的处理一样，您可以将此片段添加到 `Activity`。例如：

```
public class SettingsActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Display the fragment as the main content.
        getFragmentManager().beginTransaction()
                .replace(android.R.id.content, new SettingsFragment())
                .commit();
    }
}
```

至此，启动 SettingsActivity 就可以看到一个设置界面了。

## 原理分析

这里简单说下背后的原理。

PreferenceFragment 和 PreferenceActivity 的布局本身包含一个 ListView ，使用 `addPreferencesFromResource` 方法后，PreferenceFragment 他们会去解析 xml 文件中定义的 Preference 对象，并把它们实例化，然后通过 Adapter 的形式填充到 ListView。然后就是我们看到的设置界面了。



## 关于

这篇文章属于技术介绍类文章，主要是为下一篇文章《自定义设置 UI 》做铺垫，其实没什么干货可写的，因为官方文档已经很详细，所以文章一开头，我也建议直接去看官方提供的文档，现在已经有很好的中文版本了，而且讲得很详细，很权威。
