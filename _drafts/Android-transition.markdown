---
layout: post
author: 咕咚
title: "在Android5.0以上设备实现过渡动画"
description: ""
categories: Technology
tags: Android Animation
---
从Android5.0开始，系统提供一个很好看的Activity间的转场动画，具体就是共享两个界面中一些共有的View，让前后两个界面的跳转变得很流畅
好看。

###具体效果

关于动画，还是看效果更直接一点。下面就是Android5.0设备上的转场动画示意图，这在 Google 自家的 App 里已经司空见惯。比如 Google Play
中，从应用列表界面跳转到应用详情页，就可以看到很细腻的动画。

![tronsition_effect](/assets/tronsition_effect.gif "tronsition_effect")

###实现方法

现在有两个 Activity 分别为 MainActivity 和 DetailActivity ，如下所示。

MainActivity中是一些动物的列表展示，每个 Item包含一个动物图片和动物名称。点击 Item 需要跳转到对应动物的详情介绍页。

详情介绍页，会显示动物的大图，名称以及这个动物的详细介绍。因为两个界面有一些共有的View元素，所以比较适合用转场动画来
优化交互逻辑，现在点击 MainActivity 的 Item，需要产生一个转场动画来到达详情页。下面就是具体实现方式。

####1、在DetailActivity中设置常量

    // View name of the header image. Used for activity scene transitions
    public static final String VIEW_NAME_HEADER_IMAGE = "detail:header:image";

    // View name of the header title. Used for activity scene transitions
    public static final String VIEW_NAME_HEADER_TITLE = "detail:header:title";
    
####2、点击Item时，构造一个Intent 
    
    // Construct an Intent as normal
    Intent intent = new Intent(this, DetailActivity.class);
    intent.putExtra(DetailActivity.EXTRA_PARAM_ID, item.getId());

    // BEGIN_INCLUDE(start_activity)
    /**
     * 通过ActivityOptionsCompat的工厂方法创建一个ActivityOptions实例
     */
    ActivityOptionsCompat activityOptions = ActivityOptionsCompat.makeSceneTransitionAnimation(
            this,
            // Now we provide a list of Pair items which contain the view we can transitioning
            // from, and the name of the view it is transitioning to, in the launched activity
            new Pair<View, String>(view.findViewById(R.id.imageview_item),
                    DetailActivity.VIEW_NAME_HEADER_IMAGE),
            new Pair<View, String>(view.findViewById(R.id.textview_name),
                    DetailActivity.VIEW_NAME_HEADER_TITLE));

    // Now we can start the Activity, providing the activity options as a bundle
    ActivityCompat.startActivity(this, intent, activityOptions.toBundle());
    // END_INCLUDE(start_activity)
    
####3、在DetailActivity的onCreate方法中接受并处理
    
        mHeaderImageView = (ImageView) findViewById(R.id.imageview_header);
        mHeaderTitle = (TextView) findViewById(R.id.textview_title);

        // BEGIN_INCLUDE(detail_set_view_name)
        /**
         * Set the name of the view's which will be transition to, using the static values above.
         * This could be done in the layout XML, but exposing it via static variables allows easy
         * querying from other Activities
         */
        ViewCompat.setTransitionName(mHeaderImageView, VIEW_NAME_HEADER_IMAGE);
        ViewCompat.setTransitionName(mHeaderTitle, VIEW_NAME_HEADER_TITLE);
        // END_INCLUDE(detail_set_view_name)

###总结

    
    