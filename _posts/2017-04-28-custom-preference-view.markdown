---
layout: post
author: 咕咚
title:  "自定义复杂 View 以及极限绘制优化实践"
description: ""
catalog:    true
tags: Experience Skills Android View
---

墨迹天气是一款免费的天气信息查询软件，由于要展示各种各样的数据信息，所以项目中有大量的涉及到图表相关的自定义 View，如展示 24 小时的温度曲线图、潮汐图等等。这里就简单分享一些自己在开发空气质量页面时，开发逐小时预报曲线的一些经验。

目前该 View 的实现已开源在 GitHub，[TrendChartView](https://github.com/maoruibin/TrendChartView)，如果觉得不错，就 star 支持下。

如下是最终的效果示意图。
![trendchart](http://7xr9gx.com1.z0.glb.clouddn.com/trendchart.gif)

## 分析
分析前，先要确定清楚需求。

* 1、该 View 用于按照逐小时来展示未来5天的空气质量指数（后文简称为空指）。
* 2、最左侧纵轴展示空指的大小，一直处于显示状态。
* 3、逐小时预报柱状图显示在纵轴左侧，可滑动显示出每一天的预报数据。
* 4、数据指示器显示滑动到时间对应的空值数值，且颜色要随着等级而变化。
* 5、数据指示器需要一直显示在屏幕可见区域。
* 6、滑动到那天，那天对应的日期要高亮，其余未滑动的日期置灰。

想了想重要的就这些，还有些细节就不一一列举了。

现在考虑实现，可不可以直接把整个区域画在一个 View 上？

当然可以，但是考虑到这里面有滑动操作，这样做会很麻烦，费力不讨好。现在考虑把整个区域拆成两部分，可以分为最左边的纵轴部分和位于其右侧的可滑动柱状图两部分。

这样最左侧纵轴部分可以使用一个 LinearLayout 就可以实现，但是实际做的时候，因为他的背景有一些曲线效果，随意最终还是使用了自定义 View 来绘制实现。接下来考虑位于其右侧的柱状图部分，这部分比较复杂，这里仔细分析一下。

他主要的特征有两个

* 1、响应手势，可左右滑动
* 2、跟随手势，显示指示器

这里，如果一开始就你就认定只使用一个 View 来做滑动以及绘制，那么你就必须在自己的自定义 View 里处理 onTouch 事件，这样这个 View 就会因此复杂很多。之前看到过一个开源的曲线项目[SuitLines](https://github.com/whataa/SuitLines)，就是把滑动逻辑做在 View 中，通过处理 onTouch 事件来做滑动效果。

这里，我们采用了取巧的方式，把柱状图以及滑动效果的实现通过 View 组合的形式实现。

滑动效果的实现通过 Android 自带的 HorizontalScrollView 实现，而我们自定义的 View 处理所有元素的绘制。然后让 HorizontalScrollView 把自定义 View 包起来即可。

这样就完了吗？显然不是，看上面说到的第二点 - `跟随手势，显示指示器`,这里需要实现这个效果，那么就需要这两个 View 来互相通信才能完成。

HorizontalScrollView 可以检测到当前的水平滑动距离，所以他可以把这个距离传递给柱状图 View(这里把这个柱状图 View 命名为 TrendChartView)，然后 TrendChartView 拿到这里距离值，然后自己做计算，控制指示器位置。大概逻辑就是这样。

很显然为了更好的控制 HorizontalScrollView ，这里对他也要进行简单的自定义。下面就是整个布局的 layout 代码。如下所示

```xml
<!-- 水平的 LinearLayout -->
<LinearLayout
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:layout_gravity="center">

    <!-- 纵轴 View  -->
    <name.gudong.trendchart.TrendYAxisView
        android:id="@+id/trend_y_axis"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"/>

    <!-- 自定义的  HorizontalScrollView -->
    <name.gudong.trendchart.HorizontalScrollChartParentView
        android:id="@+id/sv_container"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:scrollbars="none">

        <!-- 核心的柱状图 View -->
        <name.gudong.trendchart.TrendChartView
            android:id="@+id/trend_chart_view"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"/>

    </name.gudong.trendchart.HorizontalScrollChartParentView>

</LinearLayout>
```

## 实现
具体可见代码 [TrendChartView.java](https://github.com/maoruibin/TrendChartView/blob/master/trendchart/src/main/java/name/gudong/trendchart/TrendChartView.java)

## 绘制优化
TODO

### 提前绘制计算
TODO

### Path 优化
TODO

## 总结
TODO


