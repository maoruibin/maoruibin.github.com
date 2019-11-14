---
layout: post
author: 咕咚
title: "跨进程数据共享问题及解决方案"
description: ""
cover-color: "zzz"
catalog:    true
tags: SharePreference
categories: tech 
---

最近在开发咕咚翻译时，在偏好设置的过程中，出现了一个莫名其妙的 bug，在 A 进程中设置偏好设置后，B 进程不能及时访问到 A 进程中设置的数据，今晚终于得到解决，随即做一次简单的记录。

## 咕咚翻译
这里先简单介绍下咕咚翻译这个 App，如名字所言，它主要的功能是翻译，不过相比其他的翻译软件，他的翻译效率更高。

因为它实现了手机端的"划词翻译"，只要你在手机上复制了任何英文内容，他都会监听粘贴板，然后给出翻译结果，展示在手机界面。效果如下图所示。

<img src="http://7xr9gx.com1.z0.glb.clouddn.com/marketing1.pic_hd.jpg" style="width: 50%;margin: auto;"><br>

当你选择复制 Reactive 这个单词后，屏幕最上方就会显示一个提示框，用于显示单词的意思。

同时，还支持收藏陌生单词到单词本。在这个单词本的基础上，我又做了一个背单词的功能。手机会每间隔一段时间，在手机上显示一个提示框，
用于显示添加到生词本的单词。

这个功能具体就是通过启动后台服务，然后开启一个定时任务，每间隔一段时间，随机的显示出生词本中一个单词。

更多关于咕咚翻译的介绍可参看前一篇文章，[关于咕咚翻译](/product/2016/02/26/gudong_translate.html)

## 问题
上面已经简单介绍了咕咚翻译，如上所述，App 中可以设置提示弹框的显示间隔时间，可以设置每隔1分钟、3分钟、5分钟或10分钟显示一次生词，
这个设置是在 MainActivity 中完成，代码如下。

    SpUtils.setIntervalTipTime(this, EIntervalTipTime.ONE_MINUTE.name());

其实就是简单的操作了 SharePreference 把偏好设置存储在本地,真实的存储代码如下。

    public static void putStringPreference(Context context, String key, String value) {       
        SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(context);
        sp.edit().putString(key, value).apply();
    }

按理说，上面完成了设置，重启 service 后，在 onStartCommand() 中再次执行一次设置定时任务的代码，
那个定时时间间隔就会同时改变。

    //获取本地设置的间隔时间
    EIntervalTipTime tipTime = SpUtils.getIntervalTimeWay(this);
    int time = tipTime.getIntervalTime();
    //通过 RxJava 的 interval 操作符设置定时任务
    Observable.interval(time, TimeUnit.MINUTES)
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe(new Observer<Long>() {
                @Override
                public void onCompleted() {
                    Logger.d("completed");
                }
                @Override
                public void onError(Throwable e) {
                    Logger.e("error")；
                }
                @Override
                public void onNext(Long number) {
                    Result result = getResult();
                    if(result != null){
                        prepareResultContent(getResult());
                        show(false);
                    }
                }
            });

但事实上，我试了不行，不论怎么设置，service 中获取到的时间间隔值总是第一次的值，除非退出应用重新打开 App，才可以。

## 解决方案
    设置 App 的 SharedPreferences 属性为 Context.MODE_MULTI_PROCESS。

    public static void putStringPreference(Context context, String key, String value) {
        SharedPreferences sp = context.getSharedPreferences(context.getPackageName()+"_preferences",Context.MODE_MULTI_PROCESS);
        sp.edit().putString(key, value).apply();
    }

## 原因分析
咕咚翻译中开启了一个监听粘贴板的服务，并且通过在 Manifest 文件中指定 process 属性，为这个service 指定了另一个进程

     <service
                android:name=".listener.ListenClipboardService"
                android:enabled="true"
                android:exported="true"
                android:process=":process"/>
这样 Application 所在的进程就和 ListenClipboardService 处在了不同的进程，此时问题显而易见，在 Application 对应的进程中设置了一个值，
另一个进程就不能及时获取到对应的值。


这个问题可以通过设置 SharedPreferences 的属性为 Context.MODE_MULTI_PROCESS 解决，关于这个数值  

     SharedPreference loading flag: when set, the file on disk will be checked for modification even if the shared preferences instance is already loaded in this process. This behavior is sometimes desired in cases where the application has multiple processes, all writing to the same SharedPreferences file. Generally there are better forms of communication between processes, though.
     This was the legacy (but undocumented) behavior in and before Gingerbread (Android 2.3) and this flag is implied when targetting such releases. For applications targetting SDK versions greater than Android 2.3, this flag must be explicitly set if desired.

这个标志位表示允许 多个进程可以访问同一个 SharePreference 对象，因为在Android 2.3版本之前，这个是默认值，所以不存在问题，但是2.3之后就需要手动开启。             

## 参考链接
[Default Shared Preferences give me wrong values in Service]( http://stackoverflow.com/questions/23674571/default-shared-preferences-give-me-wrong-values-in-service)
