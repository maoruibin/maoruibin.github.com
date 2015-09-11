---
layout: post
title: "使用Support包，显示MaterialDialog"
description: ""
categories:
  - life
tags: [心得]
---
{% include JB/setup %}
####介绍

今年的Google I/O大会上Google向开发者公布的最新的support-appcompat-v7包(23.0.1),以及全新的support:design，其中包含了很多的新组件，而且很多是为了支持MaterialDesigner，如FloatingActionButton、TextInputLayout，具体更多组件可查阅代码家之前发布在简书的一篇博客[《Google I/O 2015 为 Android 开发者带来了哪些福利？》](http://www.jianshu.com/p/4f7f55471da2)<br>
其实相比那些光鲜的新组件,Google也升级了一部分原有的组件，以向下支持MaterialDesigner风格，其中就有我今天要说的AlertDialog。<br>
在这之前，如果我们的项目中要使用MaterialDialog，对不起，Android5.0以下的设备根本不支持，但是还好，开源界的大神从来都不缺乏无私的奉献精神，在Google更新support包之前，Github上已经出现了几个非常不错的MaterialDialog开源库，如下
<br><br>
[https://github.com/afollestad/material-dialogs](https://github.com/afollestad/material-dialogs)
<br>
[https://github.com/drakeet/MaterialDialog](https://github.com/drakeet/MaterialDialog)
<br><br>
使用上面的开源库，就可以很轻松的在Android5.0以下的设备上实现MaterialDialog的效果。<br>
但是，这次Google更新了support包后，我们就再也不需要使用上面的开源库来获得MaterialDiaolg了。直接正常是调用AlertDialog就可以看大MD风格的Dialog了。

####准备工作

1、将项目targetSdkVersion设为23<br>
2、加入最新的support依赖支持<br>

        targetSdkVersion 23

        compile 'com.android.support:appcompat-v7:23.0.1'

####使用

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

注意：在导包时会有多个AlertDialog的导入提示，这里一定要选择android.support.v7.app.AlertDialog。最终运行显示的Dialog效果如下图所示：
<br><br>
![dialog](/assets/themes/dbyll/img/device-2015-09-11-dialog_theme_bug.png "dialog")
<br><br>

####主题适配

其实通过上面的操作，我们已经可以得到一个非常好看的MaterialDialog了，但是仔细看，发现按钮的文字颜色并不是项目的主色调 colorPrimary,所以这里需要对Dialog进行主题设置，这里先把最终的成功方案给出来，一睹为快.
    
    <style>
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

<br><br>
![dialog](/assets/themes/dbyll/img/device-2015-09-11-dialog_theme_bug_fix.png "dialog")
<br><br>

####总结
