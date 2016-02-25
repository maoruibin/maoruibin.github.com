---
layout: post
author: 咕咚
title: "通过 SharePreference 设置偏好后在 Service 中不生效"
description: ""
cover: "zzz"
categories: Technology
tags: SharePreference Bug Service
---

最近在开发咕咚翻译时，在偏好设置的过程中，出现了一个莫名其妙的 bug，今晚终于得到解决，随即做一次简单的记录。

## 咕咚翻译
这里先简单介绍下咕咚翻译这个 App，如名字所言，它主要的功能是翻译，不过相比其他的翻译软件，他的翻译效率更高。

因为它实现了手机端的"划词翻译"，只要你在手机上复制了任何英文内容，他都会监听粘贴板，然后给出翻译结果，展示在手机界面。

同时，还支持收藏陌生单词到单词本。在这个单词本的基础上，我又做了一个背单词的功能。手机会每间隔一段时间，在手机上显示一个提示框，
用于显示添加到生词本的单词。

这个功能具体就是通过启动后台服务，然后开启一个定时任务显示生词。

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
    设置 App 的 SharedPreferences 属性为 Context.MODE_MULTI_PROCESS,先做个记录~

    public static void putStringPreference(Context context, String key, String value) {
        SharedPreferences sp = context.getSharedPreferences(context.getPackageName()+"_preferences",Context.MODE_MULTI_PROCESS);
        sp.edit().putString(key, value).apply();
    }

## 参考链接
[Default Shared Preferences give me wrong values in Service]( http://stackoverflow.com/questions/23674571/default-shared-preferences-give-me-wrong-values-in-service)
