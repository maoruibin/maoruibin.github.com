---
layout: post
author: 咕咚
title: "使用 RxJava 重构一段判断逻辑"
description: ""
catalog: false
tags: RxJava App 
categories: tech 
---

这么晚了我还在给咕咚翻译加在线发音功能！！还好有音乐作陪...

其实实现发音很简单，金山的 API 支持单词发音。访问 [http://dict-co.iciba.com/api/dictionary.php?type=json&w=nice&key=3BE8E8ACA43FDA088E52EC05FA8FA203](http://dict-co.iciba.com/api/dictionary.php?type=json&w=nice&key=3BE8E8ACA43FDA088E52EC05FA8FA203)

即可在返回单词解释的同时，返回单词的发音 URL，如下所示，自己使用了三家翻译 API ，只有金山支持发音，也算是良心，给金山翻译 API 点个赞。

    {
        ph_en: "naɪs",
        ph_am: "naɪs",
        ph_other: "",
        ph_en_mp3: "http://res.iciba.com/resource/amp3/oxford/0/24/8a/248a2aa9259a98ecb7a1ff677a0feed2.mp3",
        ph_am_mp3: "http://res.iciba.com/resource/amp3/1/0/7c/64/7c6483ddcd99eb112c060ecbe0543e86.mp3",
        ph_tts_mp3: "http://res-tts.iciba.com/7/c/6/7c6483ddcd99eb112c060ecbe0543e86.mp3",
    }

在已经知道发音 MP3 路径的条件下，其实做发音功能很简单。MediaPlayer 支持播放 url

    String url = "http://........"; // your URL here
    MediaPlayer mediaPlayer = new MediaPlayer();
    mediaPlayer.setAudioStreamType(AudioManager.STREAM_MUSIC);
    mediaPlayer.setDataSource(url);
    mediaPlayer.prepare(); // might take long! (for buffering, etc)
    mediaPlayer.start();

使用上面的代码块，传递一个 url 进去就可以播放单词发音。

但是个人觉得，尽管发音文件很小，但是每次都去做网络请求，也未免太暴力了，所以自己想每次请求发音时，先去本地缓存找，有没有缓存的音频文件，如果有，就直接使用，没有再去网络下载，下载完成后播放，顺便把文件缓存在本地，所以就有了下面的下载、播放、缓存逻辑。

其实这个逻辑写完整了还是挺长的，如下所示，首先要拿到数据实体，然后做各种判断，还要多 url 做解析判断，最终执行网络请求等等一系列操作。真是『一会儿排成个人字，一会儿排成个一字』 具体代码如下所示。


      //判断实体是否为空
      if (entity == null) {
           return;
       }

       //拿到 entity 中的 result
       Result result = entity.getResult();
       if (result == null) {
           return;
       }

       //获得发音 URL
       String amMp3Url = result.getEnMp3();
       if (TextUtils.isEmpty(amMp3Url)) {
           return;
       }

       //判断 URL 是否合法
       if (!amMp3Url.startsWith(DownloadService.KEY_URL)) {
           return;
       }

       //解析包装 URL
       String url = amMp3Url.replace(DownloadService.KEY_URL + "resource/amp3/", "");
       String[] param = url.split("/");
       if (param.length != 5) {
           return;
       }

       //去本地查询
       File cacheFile = mFileManager.getChacheFileByUrl(mActivity,amMp3Url);
       if(cacheFile != null && cacheFile.exists()){
           playSound(cacheFile);
           return;
       }

      // 封装网络请求
       Call<ResponseBody> call = mDownloadService.downloadFileWithDynamicUrlSync(param[0], param[1], param[2], param[3], param[4]);

       //发动网络请求
       call.enqueue(new Callback<ResponseBody>() {
           @Override
           public void onResponse(Response<ResponseBody> response, Retrofit retrofit) {
               if (response.isSuccess()) {
                   try {
                      //执行本地存储
                       cacheAndPlaySound(mActivity,amMp3Url,response.body().bytes());
                   } catch (IOException e) {
                       e.printStackTrace();
                   }
               }
           }

           @Override
           public void onFailure(Throwable t) {
               Logger.e(t.getMessage());
               t.printStackTrace();
           }
       });     


使用 RxJava 后

      Observable.just(entity)
               .filter(new Func1<AbsResult, Boolean>() {
                   @Override
                   public Boolean call(AbsResult absResult) {
                       return absResult != null;
                   }
               })
               .map(new Func1<AbsResult, Result>() {
                   @Override
                   public Result call(AbsResult absResult) {
                       return absResult.getResult();
                   }
               })
               .filter(new Func1<Result, Boolean>() {
                   @Override
                   public Boolean call(Result result) {
                       return result != null;
                   }
               })
               .map(new Func1<Result, String>() {
                   @Override
                   public String call(Result result) {
                       return result.getEnMp3();
                   }
               })
               .filter(new Func1<String, Boolean>() {
                   @Override
                   public Boolean call(String s) {
                       return !TextUtils.isEmpty(s) && s.startsWith(DownloadService.KEY_URL);
                   }
               })
               .map(new Func1<String, String>() {
                   @Override
                   public String call(String s) {
                       return s.replace(DownloadService.KEY_URL + "resource/amp3/", "");
                   }
               })
               .map(new Func1<String, String[]>() {
                   @Override
                   public String[] call(String s) {
                       return s.split("/");
                   }
               })
               .filter(new Func1<String[], Boolean>() {
                   @Override
                   public Boolean call(String[] strings) {
                       return strings.length == 5;
                   }
               })
               .subscribe(new Subscriber<String[]>() {
                   @Override
                   public void onCompleted() {

                   }

                   @Override
                   public void onError(Throwable e) {

                   }

                   @Override
                   public void onNext(String[] param) {
                       File cacheFile = mFileManager.getChacheFileByUrl(mActivity, entity.getResult().getEnMp3());
                       if (cacheFile != null && cacheFile.exists()) {
                           playSound(cacheFile);
                           return;
                       }

                       Call<ResponseBody> call = mDownloadService.downloadFileWithDynamicUrlSync(param[0], param[1], param[2], param[3], param[4]);
                       call.enqueue(new Callback<ResponseBody>() {
                           @Override
                           public void onResponse(Response<ResponseBody> response, Retrofit retrofit) {
                               if (response.isSuccess()) {
                                   try {
                                       cacheAndPlaySound(mActivity, entity.getResult().getEnMp3(), response.body().bytes());
                                   } catch (IOException e) {
                                       e.printStackTrace();
                                   }
                               }
                           }

                           @Override
                           public void onFailure(Throwable t) {
                               Logger.e(t.getMessage());
                               t.printStackTrace();
                           }
                       });

                   }
               });

从表面看到的是，代码一下子公正了很多，再看逻辑，很清晰有木有！               
