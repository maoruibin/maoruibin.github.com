---
layout: post
author: 咕咚
title: App中主题Theme使用以及Theme切换
catalog:    true
tags:  Experience
categories: tech 
---
在众多Android应用中，尤其是阅读类App，为了给用户提供更好的使用体验，App设计者一般都会提供两套主题，最常见的就是Light Theme和Dark Theme,分别对应了日间模式和夜间模式。比如第三方微博客户端Smooth,知乎等等他们都有这样的实现。


因为自己对这块一直也比较感兴趣，所以自己就先尝试着做了一次，目前只是简单的尝试了下，下面记录一下这个过程，如果能帮助到更多的人，再好不过啦！


关于主题，我分两步走，第一步 主体使用，第二部主题切换


# 1、主题使用

其实，Android已经为我们提供了一套成型的主题，我们要做的就是在他的基础上个性化自己的主题样式，首先在项目目录的values/styles.xml建立一个Light主题，如下

    <style name="Theme_AppTheme" parent="Theme.AppCompat.Light.NoActionBar">

        <!-- 主题对应主色调 -->
        <item name="colorPrimary">#673AB7</item>

        <!-- 主题对应深色调 在Android 5.0上主要表现在StatusBar上-->
        <item name="colorPrimaryDark">#512DA8</item>

        <!-- 主题中的强调色 -->
        <!--比如你的App使用了FloatActionBar，那么他的颜色默认就是他了-->
        <item name="colorAccent">#FF4081</item>

        <!-- 下面这三个属性比较有意思，也是后面切换主题的关键  单独拿出来说-->
        <item name="title_text">@android:color/black</item>
        <item name="body_text">#303030</item>
    </style>


很明显，上面的两个属性“title_text”和“body_text”是Android没有提供的。但其实这里才是后面切换主题的关键点。


说道这里，先让我们先想想，如果让我们自己做主题切换，我们怎么才能做到点击一个主题切换按钮，就能让全局的样式都改变呢？
比方说，我们的布局中有一个TextView 如下

    <TextView
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:textColor="@android:color/black"/>

现在他的颜色是black，此时如果我们的用户选择了另一个主题，我们怎么才能让他的颜色变成white,最常见的方法就是 通过代码的方式设置颜色（textView.setTextColor(****)），但是对于全局那么多的View，很明显，这样做事做不可能的，此刻联想一下App的国际化我们是怎么做到的，无非是在需要显示文本内容的地方，不使用具体的文字，而是用一个string的资源标识符去占位！如下

values/layout.xml文件

        <Button
            android:text="@string/hello_world"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content" />

values/strings.xml文件

       <string name="hello_world">Hello world!</string>

对应的中文
values-zh-rCN/strings.xml

       <string name="hello_world">你好 世界！</string>

其实就是一个占位思想，试想一下，如果所有textView的color也使用此种方式，那么主题切换不就变得很简单了，事实上，Android就是可以采用这种方式！只是这里需要自定义一个颜色属性，如下所示

values/attrs.xml

    <attr name="title_text" format="color"/>

然后再使用到color的地方使用title_text进行占位，如下

    <TextView
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:textColor="?title_text"/>

此时只要在不同的主题中，指定不同的title_text颜色值，就可以做到view颜色的改变，如下

    <!-- 亮色主题-->
    <style name="Theme_AppTheme" parent="Theme.AppCompat.Light.NoActionBar">
        <item name="title_text">@android:color/black</item>
    </style>
    <!-- 暗色主题-->
    <style name="Theme_AppTheme_Dark" parent="Theme.AppCompat.NoActionBar">
        <item name="title_text">@android:color/white</item>
    </style>

这里只是拿TextView的color来举例子，其实view的各种属性都可以通过这样方式来主题化，你可以更具自己的需求，举一反三。如ImageView的Icon在不同的主题下 需要显示不同的图片，都是可以做到的。


如果现在想试试效果，可以直接在MainFest文件中指定App的主题，看看是否起作用。
先说到着，打会球去

具体设计到用代码切换主题时，可以使用Activity的一个方法 reload方法；
也可以使用下面的方式

    public void reload() {
        Intent intent = getIntent();
        overridePendingTransition(0, 0);
        intent.addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION);
        finish();
        overridePendingTransition(0, 0);
        startActivity(intent);
    }
