---
layout: post
author: 咕咚
title:  "用 Support 包显示 MaterialDialog"
description: ""
cover-color: "zzz"
catalog:    true
tags: Experience
categories: tech 
---

如果自己做个人App项目，很可能在一些情况下用到Dialog,Android自己也提供了系统Dialog,但是在MaterialDesigner出现之前，样子确实很丑，这篇博客讲解如何使用Support包中
的API来实现MD风格的Dialog。

Support V7包在22.1.0之前的任何一个版本，AlertDialog一直都是Android4.0风格，直到Support-V7:22.1.0，在这之前，如果我们的项目中要使用Material样式的Dialog，对不起，Android5.0以下的设备根本不支持，但是还好，开源界的大神从来都不缺乏无私的奉献精神，在support-v7包更新到V22.1.0之前，Github上已经出现了几个非常不错的MaterialDialog开源库，如下
[https://github.com/afollestad/material-dialogs](https://github.com/afollestad/material-dialogs)<br>
[https://github.com/drakeet/MaterialDialog](https://github.com/drakeet/MaterialDialog)<br>
使用上面的开源库，就可以很轻松的在Android5.0以下的设备上实现MaterialDialog的效果。<br>
但是，如开始所说，support-v7更新到22.1.0之后，我们就再也不需要使用上面的开源库来获得MaterialDiaolg了。直接使用Support中的AlertDialog就可以实现MD风格的Dialog了。

####准备工作

1、将项目targetSdkVersion设为22或者以上<br>
2、加入对应的support依赖支持

    targetSdkVersion 22
    compile 'com.android.support:appcompat-v7:22.1.0'

####使用

直接上代码

     new AlertDialog.Builder(getActivity())
                    .setTitle(R.string.title_export)
                    .setMessage(contentInfo)
                    .setPositiveButton(R.string.dialog_confirm_yes, new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialogInterface, int i) {
                            copyFile(srcFile, exportFile);
                        }
                    })
                    .setNegativeButton(R.string.dialog_now_watch, new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialogInterface, int i) {
                            browseFile(exportFile.getParentFile());
                        }
                    })
                    .show();

注意：在导包时一定要选择android.support.v7.app.AlertDialog。否则Dialog将不会是Material样式。最终使用support包得AlertDialog显示的Dialog效果如下图所示：
<br>
<img src="/assets/device-2015-09-11-dialog_theme_bug.png" style="width: 50%;">
<br>
``小发现``：support-v7:22.1.0版本的Dialog显示的拐角是直角，其实这不符合真正规范，并且Dialog的默认背景颜色也不是白色，但是如果使用support-v7:23.1.0，这个问题就没了。

####主题适配

其实通过上面的操作，我们已经可以得到一个非常好看的MaterialDialog了，但是仔细看，发现按钮的文字颜色并不是项目的主色调 colorPrimary,所以这里需要对Dialog进行主题设置，这里先把最终的成功方案给出来，一睹为快.

    <!-- 应用主题 -->    
    <style name="AppTheme" parent="Theme.AppCompat.Light.NoActionBar">
            <item name="theme_color">@color/colorPrimary</item>
            <item name="theme_color_dark">@color/colorPrimaryDark</item>
            <item name="theme_accent_color">@color/colorAccent</item>
            <!-- 自定义的Dialog主题 -->
            <item name="alertDialogTheme">@style/AlertDialogCustom</item>
    </style>
    <!-- 自定义Dialog显示风格 -->
    <style name="AlertDialogCustom" parent="Theme.AppCompat.Light.Dialog.Alert">
        <item name="colorPrimary">@color/colorPrimary</item>
        <item name="colorPrimaryDark">@color/colorPrimaryDark</item>
        <!-- NeutralButtonStyle -->
        <item name="buttonBarNeutralButtonStyle">@style/buttonBarNeutral</item>
        <!-- NegativeButtonStyle -->
        <item name="buttonBarNegativeButtonStyle">@style/buttonBarNegative</item>
        <!-- PositiveButtonStyle -->
        <item name="colorAccent">@color/colorAccent</item>
    </style>
    <style name="buttonBarNegative"  parent="@style/Widget.AppCompat.Button.ButtonBar.AlertDialog">
        <item name="android:textColor">@color/md_grey_700</item>
    </style>
    <style name="buttonBarNeutral"  parent="@style/Widget.AppCompat.Button.ButtonBar.AlertDialog">
        <item name="android:textColor">@color/md_grey_700</item>
    </style>

上面通过在自定义Dialog主题的方式，最终得到了一个比较Material的Dialog。其中要改变按钮文本的样式，需要设置不同Button的上style,如最右边的positive Button的样式就是通过buttonBarNeutral来设置，为什么是这个属性呢，其实扒一扒源码就可以找到。<br>
其实MaterialDialog的通过一个布局文件控制布局，下面是源码（appcompat-v7-22.1.0/res/layout/abc_alert_dialog_material.xml）中的布局代码，如下所示

        <LinearLayout
            android:id="@+id/buttonPanel"
            style="?attr/buttonBarStyle"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layoutDirection="locale"
            android:orientation="horizontal"
            android:paddingLeft="12dp"
            android:paddingRight="12dp"
            android:paddingTop="8dp"
            android:paddingBottom="8dp"
            android:gravity="bottom">
        <Button
                android:id="@android:id/button3"
                style="?attr/buttonBarNeutralButtonStyle"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"/>
        <android.support.v4.widget.Space
                android:layout_width="0dp"
                android:layout_height="0dp"
                android:layout_weight="1"
                android:visibility="invisible"/>
        <Button
                android:id="@android:id/button2"
                style="?attr/buttonBarNegativeButtonStyle"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"/>
        <Button
                android:id="@android:id/button1"
                style="?attr/buttonBarPositiveButtonStyle"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"/>
    </LinearLayout>

可以发现不同的Button具有不同的style name，这里如果想要改变那个按钮的颜色样式，只要修改对应的style即可。不过注意的是，不论是修改Dialog的样式还是按钮的样式，一定要主要对应的parent不能出错。否则你可能达不到自己的目的，从而修改主题失败。不过他们的parent通过源码都可以找到，这里细心点就好。
<br>
<img src="/assets/device-2015-09-11-dialog_theme_bug_fix.png" style="width: 50%;">
<br>

####总结
使用MaterialDialog很容易，但是要控制Dialog的显示样式(按钮文本颜色，Dialog背景颜色等等)，需要去自定义主题。
