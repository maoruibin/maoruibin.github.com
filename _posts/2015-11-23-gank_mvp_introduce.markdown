---
layout: post
author: 咕咚
title: " MVP 模式在 GankDaily 中的应用"
description: ""
cover-color:  "#8f4b2e"
catalog:    true
categories: tech
tags: Product App 架构  MVP
---
最近完成了一个干货客户端 [GankDaily](https://github.com/maoruibin/GankDaily) ，
一个基于[干货集中营](http://gank.io)的手机客户端，整个客户端借鉴 drakeet 的[妹纸](https://github.com/drakeet/Meizhi)应用。但是在原项目的基础上，
自己使用 MVP 模式对项目进行重构，让代码结构进一步解耦，使业务逻辑和视图表现层相分离，从而让代码逻辑变得更简单，
以下就整理了自己在重构项目过程中对 MVP 这种模式的理解以及项目中如何实施 MVP 的模式。

### 关于MVP

MVP 是 Model-Presenter-View的缩写，翻译过来就是模型-控制器-视图，是一种流行的开发架构模式。他主张让 Presenter 控制所有的业务逻辑，
让 View 层做具体的界面更新，Model 专门负责数据获取等操作。

通常我们写惯了 Android 项目，一般一个 Activity 中可能对应很多数据交互，比如这个干货客户端首页，只要一进入首页，它需要获取当天的干货数据。
滑动到底部需要加载更多数据，除此之外还可能有一些其他的业务逻辑比如检查版本信息等。一般的，这些操作全部放在 Activity 中没有任何问题的，
这样做一点不妨碍你完成所有的功能。而且市面上确实有不少项目真是这么做的，最近跟一些朋友聊天，也说过他负责的项目就是这么干的，一个 Activity 6000
多行代码，简直是灾难~

不过自己一开始写代码时，确实也是这样写的（囧~），记得曾经写过一个详情展示页，代码写了2000多行，当时觉得还挺自豪(呵呵~)，一个类2000多行呢，现在想想也是觉得
Too Young Too Simple .

按照 MVP 的定义，我们应该把所有的业务逻辑操作都写在 Presenter 层，而 View 层(View 层一般由 Activity、Fragment充当)他们主要做一些更新界面、
向 Presenter 层发送请求的操作。Model 层则主要负责具体的数据获取操作。他们的具体关系可以看下面这张图。

![mvp](/assets/gank_mvp_1.jpg "mvp")

由图可以清楚的看到，Presenter 处在一个中心位置，View 层向 Presenter 发送请求，Presenter 自己接受请求，但是自己不具体执行请求，而是将
具体的事情交给 Model 去处理， 利用 Model 层请求完毕后，Presenter 再把具体的结果通过某种方式响应在 View 层。

#### 一个例子

上面说的有点抽象，其实这个过程可以理解的更加形象一点。打个比喻，把 P 理解为自己的脑袋，V 理解为右手 M 理解为 左手,然后你就站在那里，
假设左右手是不能直接沟通，左右手分别通过左胳膊和右胳膊与脑袋联系。

现在 V(右手)需要100块钱进行消费，但是钱却存储在 M(左手)里，这时 V(右手)通过右胳膊告诉P(脑袋)，"脑袋，我需要100块钱，快给我。"，脑袋
得到这个命令后，因为自己不管钱，所以只得去请求 M (左手),P（脑袋）通过左胳膊告诉 M(左手),说自己需要100块钱，
M(左手)知道 P 需要钱，所以就慷慨的给钱,谁叫他是老大呢，此时 P 顺利拿到钱后，自己对钱稍微做一些验证操作，发现钱没问题，然后就把钱给了 V（右手），
此时为了安全起见，P (脑袋)需要调用一下 V(右手) 提供的一个握拳方法，以便及时的攥住钱，防止遗失，假设这个方法就叫 hold吧，P 调用 V(右手)的hold方法
后，右手在拿到钱的同时，就立即攥紧了钱，这样钱就不容易被别人拿走了。

到这里，整个一次完整的数据交互(左手取钱)、界面更新(右手攥钱)过程就结束了，M 自始至终也没有跟 V 发生任何直接关系，它甚至不知道 V 的存在。P 则在
最中央的位置负责协调数据、操作View。他从左手拿钱，然后交给右手。当然还可以更多复杂的操作，但是整个 MVP 的大体结构就是这样。

如果这个比喻觉得不清楚，那么你可以直接去看鸿洋之前写的一篇博客，用一个登录示例讲解 MVP ，讲的很清楚。

[浅谈 MVP in Android](http://blog.csdn.net/lmj623565791/article/details/46596109)

#### 几个疑问

 到这里可能会有几个疑问，

 * 在 View(Activity、Fragment)层中怎么去调用 Presenter 中的方法？

 这个简单，在View初始化时，new 一个 Presenter 实例不就对了吗，确实可行，我目前也是这样做的。

 * Presenter 怎么去控制 View 中的界面逻辑？具体点就是，上面的头部最后怎么调用右手的 hold() 方法？

 这里需要通过让 View 层通过实现特定 View 接口，每一个 View 类，也就是每一个 Activity 对应实现一个抽象的接口，也就是说在写每个 Activity 时，首先把具体的
 View 操作动作提取为一个接口，让 View 实现，让后想办法把这个接口的实例传递到 Presenter 实例中即可，这里可能稍微有点模糊，但是通过
 下面具体的代码，你可能就更清楚了。

## MVP 实践

可以先看看主界面。如下图，

![mvp](/assets/gank_mvp_introduce.png "mvp")

主界面 MainActivity 显示的是当天的干货信息，下拉可刷新，滑动到底部可以加载更多，进入主界面还需要去检查版本信息，
如果发现是新版本，好需要弹出一个 Dialog 显示更新日志。大概的业务也就这些，然后我们把所有的业务逻辑都写在 MainPresenter 中，
代码如下，部分代码省略，如果想看全部代码，点击[源码](https://github.com/maoruibin/GankDaily/blob/master/app/src/main/java/com/gudong/gankio/presenter/MainPresenter.java#L32-32)


        public void getData(final Date date) {
            mCurrentDate = date;
            mGuDong.getGankData(year, month, day)
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribe(new Subscriber<List<Gank>>() {
                        @Override
                        public void onCompleted() {
                            // after get data complete, need put off time one day
                            mCurrentDate = new Date(date.getTime()-DAY_OF_MILLISECOND);
                        }
    
                        @Override
                        public void onError(Throwable e) {
                        }
    
                        @Override
                        public void onNext(List<Gank> list) {
                            // some day the data will be return empty like sunday, so we need get after day data
                            if (list.isEmpty()) {
                                getData(new Date(date.getTime()-DAY_OF_MILLISECOND));
                            } else {
                                mCountOfGetMoreDataEmpty = 0;
                                mView.fillData(list);
                            }
                            mView.getDataFinish();
                        }
                    });
        }
    
        public void checkAutoUpdateByUmeng() {
            if(mContext.getIntent().getSerializableExtra("BUNDLE_GANK") == null){
                UmengUpdateAgent.setUpdateCheckConfig(BuildConfig.DEBUG);
                //check update even in 2g/3g/4g condition
                UmengUpdateAgent.setUpdateOnlyWifi(false);
                UmengUpdateAgent.update(mContext);
            }
        }
    
        //check version info ,if the version info has changed,we need pop a dialog to show change log info
        public void checkVersionInfo() {
            String currentVersion = AndroidUtils.getAppVersion(mContext);
            String localVersionName = AndroidUtils.getLocalVersion(mContext);
            if (!localVersionName.equals(currentVersion)) {
                mView.showChangeLogInfo("changelog.html");
                AndroidUtils.setCurrentVersion(mContext, currentVersion);
            }
        }


        /**
         * @return
         */
        public boolean shouldRefillData(){
            return !hasLoadMoreData;
        }

从上面可以看到，获取数据的方法 getData(Date date)接受一个 date 参数，调用者 MainActivity 只需要在某个地方调用这个方法，并传递当前的
日期，就可以获取到当前所有的干货数据。到这，View 请求 Presenter 完成。下面具体执行数据请求就是另外的模块了。

这里从具体代码看，可以发现，数据请求是通过 Rxjava + Retrofit 实现，如下所示

      public void getData(final Date date) {
            mCurrentDate = date;
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);
            int year = calendar.get(Calendar.YEAR);
            int month = calendar.get(Calendar.MONTH)+1;
            int day = calendar.get(Calendar.DAY_OF_MONTH);
            //获取到 年 月 日 三个参数 ，准备传递给具体的方法。
            mGuDong.getGankData(year, month, day)
                    .observeOn(AndroidSchedulers.mainThread())
                    .map(new Func1<GankData, GankData.Result>() {
                        @Override
                        public GankData.Result call(GankData gankData) {
                            return gankData.results;
                        }
                    })
                    .map(new Func1<GankData.Result, List<Gank>>() {
                        @Override
                        public List<Gank> call(GankData.Result result) {
                            return addAllResults(result);
                        }
                    })
                    .subscribe(new Subscriber<List<Gank>>() {
                        @Override
                        public void onCompleted() {
                            // 获取数据完毕，将日期推迟到下一天 为获取更多数据做准备
                            mCurrentDate = new Date(date.getTime()-DAY_OF_MILLISECOND);
                        }
    
                        @Override
                        public void onError(Throwable e) {
                        }
    
                        @Override
                        public void onNext(List<Gank> list) {
                            // 如果有一天数据为空，则继续获取下一天的数据
                            if (list.isEmpty()) {
                                getData(new Date(date.getTime()-DAY_OF_MILLISECOND));
                            } else {
                                //更新主界面数据
                                mCountOfGetMoreDataEmpty = 0;
                                mView.fillData(list);
                            }
                            mView.getDataFinish();
                        }
                    });
        }

在 onNext 方法中，我们获取到了最终的数据，此时 Presenter 需要通知 View 更新界面，所以这里有了如下的调用

    @Override
    public void onNext(List<Gank> list) {
        // 如果有一天数据为空，则继续获取下一天的数据
        if (list.isEmpty()) {
            getData(new Date(date.getTime()-DAY_OF_MILLISECOND));
        } else {
            //更新主界面数据
            mCountOfGetMoreDataEmpty = 0;
            mView.fillData(list);
        }
        mView.getDataFinish();
    }

这里通过 mView 这个实例 的fillData 方法去更新主界面。那么 mView 是一个什么变量呢，最终你会发现，他是一个 IMainView 接口的实例，可以看看
这个接口是怎么定义的。

    public interface IMainView<T extends Soul>  extends ISwipeRefreshView {
        /**
         * load data successfully
         * @param data
         */
        void fillData(List<T> data);
    
        /**
         * append data to history list(load more)
         * @param data
         */
        void appendMoreDataToView(List<T> data);
    
        /**
         * no more data for show and this condition is hard to appear,it need you scroll main view long time
         * I think it has no body do it like this ,even though，I deal this condition also, In case someone does it.
         */
        void hasNoMoreData();
    
        /**
         * show change log info in a dialog
         * @param assetFileName the name of local html file like "changelog.html"
         */
        void showChangeLogInfo(String assetFileName);
    }

发现这个接口中确实存在一个 fillData 方法，所以上面使用 mView 调用 fillData 是可行的。

那如果 MainPresenter 都可以调用 IMainView 的 fillData()方法来更新 MainActivity, 哪MainActivity 就和 IMainView 有必然的关系，
一个是类一个是接口，还能会有什么关系呢，这里 MainActivity 实现了 IMainView 这个接口。

    public class MainActivity extends BaseSwipeRefreshActivity<MainPresenter> implements IMainView<Gank>,MainListAdapter.IClickMainItem {

既然 MainActivity 实现了 IMainView 接口，那他必然实现对应的方法 fillData() ,如下所示

    @Override
    public void fillData(List<Gank> data) {
        mAdapter.updateWithClear(data);
    }

可以看到，实现很简单，就是更新一下 Adapter 就 OK，Activity 中再也看不到任务获取数据的代码。

到这里，让我们看看 MainPresenter 是在 MainActivity 的什么地方实例化的。这里因为每个 Activity 都是继承自 BaseActivity ，而且每个
Activity 必须有一个 Presenter ,所以我在 BaseActivity 中已经事先定义了一个 BasePresenter 的实例 mPresenter，同时给 BaseActivity 设置一个
抽象方法 initPresenter()。这个方法将会在BaseActivity onCreate 时执行到。代码如下所示

    public abstract class BaseActivity<P extends BasePresenter> extends AppCompatActivity {
        @Bind(R.id.toolbar)
        protected Toolbar mToolbar;
        /**
         * the presenter of this Activity
         */
        protected P mPresenter;
    
        /**
         * TODO use Dagger2 instance Presenter
         */
        protected abstract void initPresenter();
    
        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(getLayout());
            ButterKnife.bind(this);
            initPresenter();
            checkPresenterIsNull();
            initToolBar();
        }
    
        private void checkPresenterIsNull(){
           if(mPresenter == null){
               throw new IllegalStateException("please init mPresenter in initPresenter() method ");
           }
         }
    }


设置抽象方法的目的就是强制每个继承自 BaseActivity 的Activity类 都必须实现这个方法，并实例化 BasePresenter；

如果不实例化 mPresenter，可以看到在 onCreate 中对 mPresenter 是否已经设置值做了 checkPresenterIsNull() 处理,只要发现 mPresenter 为 null
这里就会报错。

MainActivity 继承自 BaseActivity ，所以它实现了 initPresenter() 方法。

MainActivity中 initPresenter

        @Override
        protected void initPresenter() {
            mPresenter = new MainPresenter(this, this);
        }

这里可以到 MainPresenter 的构造函数传递了两个参数。可以查看 MainPresenter 的构造方法

     public MainPresenter(Activity context, IMainView view) {
            super(context, view);
     }

它直接调用自己父类 BasePresenter 的构造方法，这里可以看看 BasePresenter 类，很简单。

    public class BasePresenter<GV extends IBaseView> {
    
        protected GV mView;
    
        protected Activity mContext;
    
        public static final GuDong mGuDong = MainFactory.getGuDongInstance();
    
        public BasePresenter(Activity context, GV view) {
            mContext = context;
            mView = view;
        }
    }

可以看到这里的两个参数分别是 Activity 和 IBaseView 的实例，IBaseView 是所有抽象 View 接口的父接口(目前是一个空接口)，
IMainView继承自IBaseView。

这里就可以看到 其实每个 Presenter 中都有一个 IBaseView 的实例，只要在 Activity 实例化了 Presenter 实例，那么对应的IBaseView
实例其实也已经传递到了 Presenter 中，这样只要是界面更新的操作，我们就可以方便的调用 IBaseView 中的接口了。
再看一下 MainPresenter 中 的 onNext 方法。

    @Override
    public void onNext(List<Gank> list) {
        // 如果有一天数据为空，则继续获取下一天的数据
        if (list.isEmpty()) {
            getData(new Date(date.getTime()-DAY_OF_MILLISECOND));
        } else {
            //更新主界面数据
            mCountOfGetMoreDataEmpty = 0;
            mView.fillData(list);
        }
        mView.getDataFinish();
    }

此时 mView 调用 fillData()方法，应该已经清楚了吧。

## 总结

至此，MVP 大概就说完了，可以看看项目接口，也许会看到更清楚一点。

![mvp](/assets/gank_mvp_3.jpeg "mvp")

此外，还用到了一些泛型的知识点，用来约束Base类的类型，大家有看着不明白的地方，可以留言。
