---
layout: post
author: 咕咚
title: "当妹子遇到 MVP + Dagger2"
description: ""
cover: "zzz"
categories: Technology
tags: Android Dagger2 MVP  
---

介绍性的一段内容

## 当妹子遇到MVP
在说妹子和 Dagger2 的结合前，先大概说下 妹子和 MVP 的结合。

关于 MVP ，我之前的开源项目 GankDaily 就是一个完全按照 MVP 模式而开发的一个应用，具体 MVP 怎么应用，配合 GankDaily 我也写过一篇文章
[MVP 模式在 GankDaily 中的应用](/),其中详细介绍了 MVP 的实践过程，这里我再配合妹子数据简单说下 MVP，如果对 MVP熟悉的同学，可以直接略过下面一段。

MVP 分别对应 数据模型层、视图层、控制层。

### Dagger2

我们理想的 MainActivity 应该是这样的 
    
    public class MainActivity extends BaseActivity implements IMainView {
        @Inject
        MainActivityPresenter presenter;
    
        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_main);
            ButterKnife.inject(this);
            
            presenter.attachView(this);
            presenter.onCreate();
            
        }
    }
   
如上所示，我们定义 Presenter，并用 @Inject 进行注解。设想一种理想的情况，现在通过某种神秘的力量，只要使用 @Inject 注解，presenter 就会自动实例化。

然后我们就可以在 MainActivity 的内容任意的使用 presenter，如上所示，我们在 onCreate 分别调用了 MainActivityPresenter 的 attachView 和
 onCreate 方法。
 
 这是一种很理想的情况，我们的代码中没有出现 new ,只是通过简单的注解 @Inject 标注了一下 presenter，然后他就在运行时神奇的实例化了。 
 
 现在让我们回到现实，一个对象不可能凭空实例化，他归根结底肯定有一个地方去实例化了他，这个地方就是 Dagger2 中的 module。
  
  Dagger2 的 module 专门用于提供一些依赖对象的生成规则，比如上面的 MainActivityPresenter，他的实例化就是在这里控制，对应 MainActivityModule,查看代码
    
    @Module
    public class MainActivityModule {
        @Provides
        @ActivityScope
        MainActivityPresenter provideMainActivityPresenter(ApiService apiService) {
            return new MainActivityPresenter( apiService);
        }
    }
    
那两者如何联系起来，且看下回分解~~
