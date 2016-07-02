---
layout: post
author: 咕咚
title: "当 Dagger2 应用在 MVP 框架中"
description: ""
cover:  "#5FAD9C"
categories: Technology
tags: Dagger MVP
---
关于 Dagger2 自己一只想搞明白，但是从去年开始到现在，说真的，看过不少介绍 Dagger2 的文章，但自己一只云里雾里，最近打算把 Dagger2
应用到 MVP 框架中去，所以就重新翻看相关技术文章，重新学习下，下面算是自己这两天学习 Dagger2 后对 Dagger2 的认识，不一定都正确，如果
错误，欢迎指正，只要从代码角度出发，认识 Dagger2。

Note:如果你对 MVP 和 Retrofit 都不熟悉，这篇文章可能不适合你阅读。

### 学习初衷 

前段时间按照 MVP 架构重构过一个妹子客户端 [GankDaily](https://github.com/maoruibin/GankDaily),关于 MVP 具体在
GankDaily 中如何使用，自己也专门写过一篇文章介绍过，[MVP 模式在 GankDaily 中的应用](),如果看过 GankDaily 的代码，其实不仅仅是
 GankDaily 这个项目，所有 使用 MVP 架构的项目，都会存在一个问题，那就是每个 Activity 中一定会有一个 Presenter 实例对象，如下所示
 
     /**
      * the presenter of this Activity
      */
     private MainActivityPresenter mPresenter;
     
它是 Activity 的控制器，所有的数据请求、界面更新都直接或间接的被它控制。然后每个Activity 都需要在 onCreate 中
去实例化它，如下所示

     mPresenter = new MainActivityPresenter(this, user);

上面看上去没什么不妥，但是如果你听过依赖注入(关于依赖注入，这里一哥们写的文章介绍的不错，[依赖注入原理](http://codethink.me/2015/08/01/dependency-injection-theory/))，就知道这种使用 new 关键字去实例化一个对象有诸多不好的地方，
这种 new 实例的方式 其实是一种硬编码。为什么？
 
试想一下，如果以后 MainActivityPresenter 的构造方法中的参数发生变化，那么此时，不仅仅在 MainActivityPresenter 类中改动了 MainActivityPresenter
的构造器相关的代码，你还需要在所有使用到 MainActivityPresenter 的地方修改代码，这不就是硬编码吗？

那你肯定想问？ "你说说除了这样的方法，还有什么方法能避免你上面说的这种问题呢?"

答案就是今天的主题 -- Dagger2 

试想一下，如果把 MainActivityPresenter 实例的获取，事先通过一个辅助类约定好，那么具体使用的时候，通过辅助类
去生成 MainActivityPresenter 的对象，那么是不是会好点，其实这个辅助类，在我理解而来就是 Dagger2 中的 Module 概念。
 
当然 Dagger2 除了可以解决硬编码的问题，还有其他很多好处，如方便测试等等。
 
以上算是自己学习的初衷，总结一下，我使用 Dagger2 的愿景或者最终的预期的结果就是 在Activity 中看不到 new Presenter()
 这样的代码，直接在 定义 Presenter 实例时，用 @Inject 注解一下，Presenter 的实例就生成。
 
### 最终结果
  
下面自己将会使用 Dagger2 + MVP架构模式 + Retrofit 演示一个简单的 demo 。

这个demo 只有一个 MainActivity界面，最终的效果是在 MainActivity 通过  MainActivityPresenter 获取到一个
字符串显示在 MainActivity 。

这里关于 Dagger2 和 MVP 你应该已经了解他们为什么存在，但是对于 Retrofit 可能有点疑惑，关于 Retrofit：

Retrofit：用来模拟一般的网络数据获取,这个目前大家用的比较多，也确实是一个很方便的库，加上支持 RxJava ,它用于获取数据真是极方便的。
既然要用 Retrofit ，就应该知道整个应用中，最好只存在一个 Retrofit 实例。


### 环境配置 

根目录的 build 文件加入 android-apt 支持

    // Top-level build file where you can add configuration options common to all sub-projects/modules.
    
    buildscript {
        repositories {
            jcenter()
        }
        dependencies {
            classpath 'com.android.tools.build:gradle:1.1.0'
            classpath 'com.neenbedankt.gradle.plugins:android-apt:1.4'
            // NOTE: Do not place your application dependencies here; they belong
            // in the individual module build.gradle files
        }
    }
    
在 app 目录的 build 文件中加入 apt plugin 的支持
     
     apply plugin: 'com.neenbedankt.android-apt'
     
加入 Dagger2 retrofit OkHttp 依赖
     
    //dagger2
    compile 'com.google.dagger:dagger:2.0'
    apt 'com.google.dagger:dagger-compiler:2.0'
    provided 'org.glassfish:javax.annotation:10.0-b28'

    //Square
    compile 'com.jakewharton:butterknife:6.1.0'
    compile 'com.squareup.retrofit:retrofit:1.9.0'
    compile 'com.squareup.okhttp:okhttp:2.3.0'
    
###在 Application 中实践 Dagger2 
    
现在依赖都已经加入，开始动手使用 Dagger2 ,第一步考虑我们的 Application。

先创建 AppApplication，并在 AndroidMainfest.xml 注册好。
   
   public class AppApplication  extends Application{
            
            @Override
            public void onCreate() {
                super.onCreate();
            }

   }
   
    <application
           android:name=".AppApplication"
           android:allowBackup="true"
           android:icon="@mipmap/ic_launcher"
           android:label="@string/app_name"
           android:theme="@style/AppTheme" >
    
    </application>
 
这里想想，在 Application 中应该做点什么呢？Application中一般可以做一些全局性相关的事。

对于 Retrofit ，前面也说了应该在全局中只存在一个实例，所以 Application 中可以有一个全局性的 Retrofit。
 
说到这里，感觉说的有点费劲，主要是自己理解的也还不够深入，先这样吧，反正是写给自己以后看的，如果对你，正在读文章的你造成了
 困惑，还请见谅。如果读文章有点费劲，建议直接看已经存在于Github上最终的[源代码](https://github.com/thinkSky1206/MVP-Dagger2-Retrofit)
 
 
基于上面的分析， Application 可能需要一个依赖，依赖于 ApiServiceModule(提供 Retrofit 实例)，
这里我们看看 ApiServiceModule 的代码实现
 

    @Module
    public class ApiServiceModule {
        private static final String ENDPOINT="";
    
    
        @Provides
        @Singleton
        OkHttpClient provideOkHttpClient() {
            OkHttpClient okHttpClient = new OkHttpClient();
            okHttpClient.setConnectTimeout(60 * 1000, TimeUnit.MILLISECONDS);
            okHttpClient.setReadTimeout(60 * 1000, TimeUnit.MILLISECONDS);
            return okHttpClient;
        }
    
        @Provides
        @Singleton
        RestAdapter provideRestAdapter(Application application, OkHttpClient okHttpClient) {
            RestAdapter.Builder builder = new RestAdapter.Builder();
            builder.setClient(new OkClient(okHttpClient))
                    .setEndpoint(ENDPOINT);
            return builder.build();
        }
    
        @Provides
        @Singleton
        ApiService provideApiService(RestAdapter restAdapter) {
            return restAdapter.create(ApiService.class);
        }
    }

任何 Module 类的开头都以 @Module 进行注解。

然后，最终 ApiServiceModule 需要提供给 AppApplication ，这里不能直接将 ApiServiceModule 给 AppApplication ，
现在需要一个组件对他进行整合 这个组件我们对他命名为 AppComponent下面是它的实现。

    @Singleton
    // 如果这里有多个 可以用逗号隔开，继续追加
    @Component(modules = {ApiServiceModule.class})
    
    public interface AppComponent {
    
        ApiService getService();
        
    }

这里你会看到他是一个接口，然后在类申明的开始的位置，用 @Component 指定了他具体的依赖的类。
    
这个接口只有一个方法，返回了之前设想的一个全局实例 ApiService。

既然是接口，那么一定有类去实现他，设想一下，如果有一个类实现了上面的接口，
我们只要在 AppApplication 中得到 这个实现的对象，那这个对象不就是 AppComponent，然后我们不就
通过 AppComponent 获取到实例对象了吗？恩~ 就应该是这样。

现在定义好 AppComponent 接口，然后经过编译，当你在编辑器 打出 Dagger 编辑器就会自动提示 DaggerAppComponent 这个类。

![auto](/assets/dagger_mvp_1.jpg "auto")

恩？这是怎么回事？ 

这其实是 Dagger2 帮你自动生成的。

现在在 AppApplication 中直接使用 DaggerAppComponent，用它来得到 AppComponent 对象，然后有了 AppComponent 
那么 ApiService 不就随之而来了吗？

AppApplication 中代码现在如下所示

    public class AppApplication  extends Application{
    
        public static AppApplication get(Context context){
           return (AppApplication)context.getApplicationContext();
        }
        
        private AppComponent appComponent;
    
        @Override
        public void onCreate() {
            super.onCreate();
            appComponent=DaggerAppComponent.builder()
                    .apiServiceModule(new ApiServiceModule())
                    .build();
       }
    
        public AppComponent getAppComponent() {
            return appComponent;
        }
    }
    
那么现在只要在任何地方想要获取 ApiService 的实例，只要得到了 AppApplication 的实例（AppApplication.get()，
就可以通过 AppAppLication 的 getAppComponent() 方法得到 AppComponent ，然后通过 AppComponent 就可以间接得到 ApiService
的实例了。

上面大概说了下在 Application 中应用 Dagger2 去实例化 AppComponent，其实在 Activity 使用也是同样的道理。现在暂时没时间
写在 Activity 中怎么使用 Dagger2 了，具体可以从代码中查看。

代码都已经在 Github ，欢迎[查阅](https://github.com/thinkSky1206/MVP-Dagger2-Retrofit)
 
 




        