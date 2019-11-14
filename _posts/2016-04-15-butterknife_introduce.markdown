---
layout: post
author: 咕咚
title: "ButterKnife 使用介绍"
description: ""
catalog:    false
tags: Usage
categories: tech 
---
首先说点关于这篇文章的题外话。

公司项目重构，我建议老大使用 ButterKnife,因为自己使用了很久，而且自己跟周边的同事演示了一下 ButterKnife 的功能，都觉得很赞，所以就想自己要不彻底调研一次 ButterKnife，包括用法以及源码。

最终我给组长的结果是 这东西可用，也没有什么太大的性能问题，但是最终还是被老大给 kill 掉了，后来也没有理论过老大，好吧，那就继续 findViewById 吧。

但是作为自己当时的记录，这里还是把写在内部博客系统的文章发出来，没有什么技术含量，但也不想一直就搁置在哪里。

好了，进入正题。

# ButterKnife

项目源地址：[https://github.com/JakeWharton/butterknife](https://github.com/JakeWharton/butterknife) 具体介绍也可查看[项目主页](https://github.com/JakeWharton/butterknife)。

## 介绍

ButterKnife 是什么，下面是 Github 上的原文介绍

`Field and method binding for Android views which uses annotation processing to generate boilerplate code for you.`

翻译过来就是说

用注解处理器为程序在编译期生成一些样板代码，用于把一些属性字段和回调方法绑定到 Android 的 View。

描述可能不好理解，但是只要一看例子，相信一眼就能看懂他是干什么的。

## 1、实例


现在需要做一个登录页面，页面很简单，两个输入框，一个登录按钮，点击登录、获取输入框数据，然后执行登录逻辑。

布局代码如下：

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:padding="16dp"
        android:orientation="vertical">

        <EditText
            android:id="@+id/editText"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:hint="用户名" />


        <EditText
            android:id="@+id/editText2"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:ems="10"
            android:hint="密码"
            android:inputType="textPassword" />


        <Button
            android:id="@+id/button_confirm"
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:text="登录" />

    </LinearLayout>

然后在 LoginActivity 我们通常会这样写代码，如下所示。

    public class LoginActivity extends AppCompatActivity implements View.OnClickListener{

        EditText mEtUserName;
        EditText mEtPassword;

        String mErrorInfo;

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_main);

            mErrorInfo = getString(R.string.error_info);

            //初始化 View
            mEtUserName = (EditText) findViewById(R.id.editText);
            mEtPassword = (EditText) findViewById(R.id.editText2);
            Button loginButton = (Button) findViewById(R.id.button_confirm);

            //设置按钮监听
            loginButton.setOnClickListener(this);

        }

        @Override
        public void onClick(View v){
            switch(v.getId()){
               case R.id.button_confirm:
                 String username = mEtUserName.getText().toString();
                 String password = mEtPassword.getText().toString();
                 login(username,password);
                 break;
            }
        }
    }


上面的代码没有任何问题，但是如果遇到一个布局界面中有很多 View 的情况时，你可能需要写一大段的 findViewById()，另外，如果有很多按钮的点击事件需要处理，那么你也需要写一大堆的 setOnClickListener() ,如下所示。

    title = (TextView) view.findViewById(R.id.tv_title);
    bannerIcon = (RecycledNotImageView) view.findViewById(R.id.iv_banner);
    contentTitle = (TextView) view.findViewById(R.id.tv_content_title);
    contentDesc = (TextView) view.findViewById(R.id.tv_content_desc);
    perPraiseCount = (TextView) view.findViewById(R.id.tv_vote_agree_percent);
    unPerPraiseCount = (TextView) view.findViewById(R.id.tv_vote_not_agree_percent);
    praiseBtn = (RecycledNotImageView) view.findViewById(R.id.iv_vote_agree);
    unPraiseBtn = (RecycledNotImageView) view.findViewById(R.id.iv_vote_not_agree);
    wordLeft = (TextView) view.findViewById(R.id.tv_vote_agree);
    wordRight = (TextView) view.findViewById(R.id.tv_vote_not_agree);
    wordMid = (TextView) view.findViewById(R.id.tv_vote_num);
    animationLine = (VoteView) view.findViewById(R.id.vv_vote);
    mRlVoteResult = (RelativeLayout) view.findViewById(R.id.rl_vote_result);
    mLlVoteAgree = (LinearLayout) view.findViewById(R.id.ll_vote_agree);
    mLlVoteNotAgree = (LinearLayout) view.findViewById(R.id.ll_vote_not_agree);

    mSkinSelectorBack.setOnClickListener(this);
    mLocalRbtn.setOnClickListener(this);
    mOnlineRbtn.setOnClickListener(this);
    mDiscoverRbtn.setOnClickListener(this);
    mViewPager.setOnPageChangeListener(this);
    perPraiseCount.setOnClickListener(this);
    contentDesc.setOnClickListener(this);

其实，如果快捷键用得好，写这些代码倒也挺快的，用 Ctrl + D 的快捷键可以方便的快速复制 ,不过你在享受了 Ctrl + D 的高效后，蛋疼的事就接踵而至，你可能还需要在快速复制后 一个个的修改强转的类型，相信有过同样经验的你，一定知道我的意思。

但是时间久了，你有时可能回想，有没有办法可以简化这些操作啊，毕竟他们的重复性太强了。

好，ButterKnife 该登场了，看看使用 ButterKnife 后的 LoginActivity 是什么样子。

    class LoginActivity extends Activity {
      @Bind(R.id.user) EditText username;
      @Bind(R.id.pass) EditText password;

      @BindString(R.string.login_error)
      String loginErrorMessage;

      @OnClick(R.id.submit) void submit() {
        // TODO call server...
      }

      @Override public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.simple_activity);
        ButterKnife.bind(this);
        // TODO Use fields...
      }
    }

现在，可以翻回去看看原来的 LoginActivity 是怎么写的，对比后，你会知道 ButterKnife 都做了什么。

现在的 LoginActivity，已经完全不存在 findViewById 了，取而代之的是一个注解 @Bind


    username = (EditText) findViewById(R.id.editText);
    --->
    @Bind(R.id.user) EditText username;


也找不到 setOnClickListener ,以及对应的 onClick 回调， 取而代之的是一个简单的 @OnCLick 注解


     loginButton.setOnClickListener(this);
     @Override
     public void onClick(View v){
        switch(v.getId()){
           case R.id.button_confirm:
             String username = mEtUserName.getText().toString();
             String password = mEtPassword.getText().toString();
             login(username,password);
             break;
        }
     }

   --->

     @OnClick(R.id.submit) void submit() {
        // TODO call server...
      }


当然，上面只是列举了最常用的两个场景。

可以看到，使用 ButterKnife 后，代码量少了不少。而且使用注解的方式，也很形象。

      @Bind(R.id.user) EditText username;

就是把 R.id.user 这个 id 绑定到了 username 这个对象。理解起来也很好理解。

上面的实例只是列举了 ButterKnife 最常用的两种情形，下面详细列举一些具体的使用场景

## 2、ButterKnife用法/使用场景

### 1、绑定 Activity 中的 View

如上所示。

      class LoginActivity extends Activity {
        @Bind(R.id.user) EditText username;
        @Bind(R.id.pass) EditText password;

        @Override public void onCreate(Bundle savedInstanceState) {
          super.onCreate(savedInstanceState);
          setContentView(R.layout.simple_activity);
          ButterKnife.bind(this);
        }
      }

注意，这里需要在 Activity 的 onCreate 中手动调用 ButterKnife.bind(this); 这个方法，注解才能生效。另外，这句代码，一定要在 setContentView 之后调用，否则 Activity 中的 layout 都没有加载到内存中来 ，你叫人家那里去找 layout 中的 view，皮之不存，毛将焉附。只要记清楚这点，就没什么问题。

### 2、绑定点击事件

    @OnClick(R.id.submit)
    public void submit(View view) {
      // TODO submit data to server...
    }

这里的方法名没有任何限制，只要你指定了@OnClick后面的 id ,就表示下面的方法体会在这个 id 对应的 View 被点击时调用。所以这里的方法名你可以任意起，想怎么写怎么写，另外方法的参数是可选的，你可以不填。

    @OnClick(R.id.submit)
    public void submit() {
      // TODO submit data to server...
    }

当然，这里也可以指定具体的 View 类型

      @OnClick(R.id.submit)
      public void sayHi(Button button) {
        button.setText("Hello!");
      }

但是，既然要指定，就最好把类型写正确了，否则会报错。

这里还可以为多个 id 同时指定点击事件。如下所示

    @OnClick({ R.id.door1, R.id.door2, R.id.door3 })
    public void pickDoor(DoorView door) {
      if (door.hasPrizeBehind()) {
        Toast.makeText(this, "You win!", LENGTH_SHORT).show();
      } else {
        Toast.makeText(this, "Try again", LENGTH_SHORT).show();
      }
    }

这个用法还真没怎么用过，可以看到上面是为用一个类型的三个 View 指定了点击事件处理，然后根据不同 View 的属性去做了不同的判断。
当然这里应该可以使用 switch 判断，对 id 进行判断然后做具体的点击处理，比较灵活。

ButterKnife 也可以为自定义 View 绑定点击监听。直接在 View 内部实现，如下所示。

      public class FancyButton extends Button {
        @OnClick
        public void onClick() {
          // TODO do something!
        }
      }


说道这里，我们只看到了点击事件的绑定，那么 ButterKnife 支持其他事件绑定吗？比如onCheckChangeListener，onLongClickListener 以及 ListView 的 onItemClickListener，当然可以,具体支持哪些，可以从源码包结构对注解的定义可以看出。如下图所示。
![methods](/assets/butterknife_onclick_method_image.png "knife") 可以看到，一般的，我们能用到的事件，大都囊括其中了。

## 不错的链接

ButterKnife使用详谈

[http://www.jianshu.com/p/b6fe647e368b](http://www.jianshu.com/p/b6fe647e368b)
