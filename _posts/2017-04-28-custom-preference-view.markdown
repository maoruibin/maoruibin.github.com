---
layout: post
author: 咕咚
title:  "自定义复杂 View 以及相关绘制优化实践"
description: ""
catalog:    true
shang    :  true
tags: Experience Skills Android View
categories: tech 
---

墨迹天气是一款免费的天气信息查询软件，由于要展示各种各样的数据信息，所以项目中有大量的涉及到图表相关的自定义 View，如展示 24 小时的温度曲线图、潮汐图等等。这里就简单分享一些自己在开发空气质量页面时，开发逐小时预报曲线的一些经验。

> 版权声明：本文为 **咕咚** 原创文章，可以随意转载，但必须在明确位置注明出处。
> 
> 作者博客地址: [http://gudong.site](http://gudong.site/)
>
> 本文博客地址: [http://gudong.site/2017/04/28/custom-preference-view.html](http://gudong.site/2017/04/28/custom-preference-view.html)


目前该 View 的实现已开源在 GitHub，[TrendChartView](https://github.com/maoruibin/TrendChartView)，如果觉得不错，就 star 支持下。

如下是最终的效果示意图。

![trendchart](http://7xr9gx.com1.z0.glb.clouddn.com/trendchart.gif)

整个 View 需要显示最近6天的逐小时空气质量信息，共绘制了144个小柱子，以及背景还有随着手指移动的指示器，但是最终实现完成的效果还是挺流畅的，在手机上做帧率测试时一直维持在 60 fps，滑动几乎没有卡顿的感觉。

下面简单分析下这个 View 有哪些需求点。

## 分析

* 1、该 View 用于按照逐小时来展示最近6天的空气质量指数（后文简称为空指）。
* 2、最左侧纵轴展示空指的大小，一直处于显示状态。
* 3、逐小时预报柱状图显示在纵轴左侧，可滑动显示出每一天的预报数据。
* 4、数据指示器显示滑动到时间对应的空值数值，且颜色要随着等级而变化。
* 5、数据指示器需要一直显示在屏幕可见区域。
* 6、滑动到哪天，哪天对应的日期要高亮，其余未滑动的日期置灰。

想了想重要的就这些，还有些细节就不一一列举了。

现在考虑实现，可不可以直接把整个区域画在一个 View 上？

当然可以，但是考虑到这里面有滑动操作，这样做会很麻烦，费力不讨好。由于左边的纵轴区域位置固定，所以现在考虑把整个区域拆成两部分，可以分为最左边的纵轴部分和位于其右侧的可滑动柱状图两部分。

这样最左侧纵轴部分可以使用一个 LinearLayout 就可以实现，但是实际做的时候，因为他的背景有一些曲线效果，随意最终还是使用了自定义 View 来绘制实现。

接下来考虑位于其右侧的柱状图部分，这部分比较复杂，这里仔细分析一下，他主要的特征有两个：

* 1、响应手势，可左右滑动
* 2、跟随手势，显示指示器

这里，如果一开始就形成思维定势，仅使用一个 View 来做滑动以及绘制，那么你就必须在自己的自定义 View 里处理 onTouch 事件，这样这个 View 就会因此复杂很多。之前看到过一个开源的曲线项目[SuitLines](https://github.com/whataa/SuitLines)，就是把触摸滑动逻辑做在 View 中，通过处理 onTouch 事件来做滑动效果，整个 View 代码逻辑会复杂很多。

这里，我们采用了取巧的方式，把柱状图以及滑动效果的实现通过 View 组合的形式实现。

滑动效果的实现通过 HorizontalScrollView 实现，而我们自定义的 View 处理所有元素的绘制。然后让 HorizontalScrollView 把自定义 View 包起来即可。

这样就完了吗？显然不是，看上面说到的第二点 - `跟随手势，显示指示器`,这里需要实现这个效果，那么就需要这两个 View 来互相通信才能完成。

HorizontalScrollView 可以通过设置监听拿到当前的水平滑动距离，所以他可以把这个距离传递给柱状图 View(这里把这个柱状图 View 命名为 TrendChartView)，然后 TrendChartView 拿到这里距离值，然后自己做计算，控制指示器位置。大概逻辑就是这样。

很显然为了更好的控制 HorizontalScrollView ，这里对他也要进行简单的自定义。下面就是整个布局的 layout 代码。如下所示

```xml
<!-- 水平的 LinearLayout 整个根布局-->
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

下面贴出核心 onDraw 方法的代码。

```java
@Override
protected void onDraw(Canvas canvas) {
  super.onDraw(canvas);
  //画等级虚线背景
  drawGradeAxis(canvas);
  //画柱状图
  drawCharts(canvas);
  //画指示器
  drawIndicatorLine(canvas, mOffset, mCurrentData);
  //画底部的时间
  drawBottomDateInfo(canvas);
}
```

## 卡顿问题

按照思路开发完成花费不了多少时间，但是一开始开发完成后，发现滑动会有明显的卡顿，因为每一次滑动都需要根据手势移动的距离去重新设置指示器的位置，所以每次计算完新的位置后需要不停的 invalidate, 与此同时就会不停的触发 onDraw 方法，所以如果 onDraw 里的操作如果耗时比较多，就会很容易出现卡顿。

所以，现在主要的优化点就应该集中在 onDraw 方法中，只要把 onDraw 方法的耗时降下来，卡顿问题也就迎刃而解。

## 解决问题

后来仔细查看后，发现在 onDraw 中有大量的计算逻辑，比如使用 for 循环计算每一个柱子的高度、计算背景虚线对应的 path等等。尤其是柱子高度，其实没必要每次都去计算，因为只要空气指数大小确定，那么对应的柱子高度就是确定的，包括颜色，所以这里没必要每次去计算，只要计算一次即可，了解了这些就去做优化。

### 提前计算

把所有能提前完成的计算都尽可能的提前完成。那什么时候去做这个计算比较合适呢？TrendChartView 有一个 `fillData`的方法，用于提供给外部设置填充空值数据集合并刷新界面，所以这个地方就是最佳的地方，我们可以在拿到数据后就去做一些绘制相关的数据计算，如柱子区域、日期对应的坐标点集合。对应到代码中，如下所示：

```java
public void fillData(List<ITrendData> dataList, List<String> dayListInfo, int dayCount) {
    mListSize = dataList.size();
    mControlPoints = new ArrayList<>(mListSize);
    mChartTrendWidthAbs = mListSize * getItemWidthWithSpace();
    mDataList = dataList;
    mDayCount = dayCount;
    mDayRecord = new SparseIntArray(mDayCount);
    mDayListInfo = dayListInfo;
    mCurrentTimePosition = getCurrentTimePosition(mDayListInfo);
    mAverageDayWidth = mChartTrendWidthAbs / mDayCount;
	//省略部分代码
  	
    //计算柱状图的点集合
    calculateCurveDot();
    //计算背景虚线的 path
    calculatedLinePath();
    //计算底部时间对应的坐标信息
    calculateBottomTextPoint();
    //发起重绘请求
    requestLayout();
}
```

这里拿 `calculateCurveDot `这个方法举例说明，该方法用于提前计算柱状图的点集合。所以这里实现定义好一个集合

```java
//图表绘制点集合
private List<ChartRect> mChartRectList = new ArrayList<>();
```

其中，`ChartRect`为封装的用于画柱状图的属性对象。

```java
/**
 * 封装的用于画柱状图的属性对象
 */
private static class ChartRect {
    /**
     * 柱状图矩区域
     */
    RectF rectChart;
    /**
     * 柱子颜色
     */
    @ColorInt int color;
}
```

现在就要提前把对应的点集合计算完成，如下所示：

```java
private void calculateCurveDot() {
        mChartRectList.clear();
        float currentPosX;
        float currentPosY;
        float lastX = 0;
        float lastY = 0;
        int roundRadius = dp2;
        int lastDay = 0;
        int position = 0;
        for (int i = 0; i < mListSize; i++) {
            ITrendData data = mDataList.get(i);
            int dataWrapValue = data.warpValue();
            ChartRect chartRect = new ChartRect();

            float left = (i + 1) * mChartSpace + i * mChartItemWidth;
            float bottom = mViewHeight - mBottomBlankSize + roundRadius;
            float top = bottom - (dataWrapValue / mMaxAqiValue) * (mChartContentHeight) - roundRadius;
            float right = left + mChartItemWidth;
            chartRect.rectChart = new RectF(left, top, right, bottom);
            chartRect.color = data.levelColor();
            mChartRectList.add(chartRect);
        }
}
```

这里主要领会精神即可。

总之数据提前计算，不要做无意义的重复计算，除非一些属性要变化，只要不变化的属性能提前计算尽量都提前完成。

## 使用位运算

在 onDraw 方法中总有一些计算无法避免，这时为了追求极致的运算效率，对除法可以使用位运算。如下所示：

```java
width/2 -> width >>1
```

## 使用 ClipRect

对于绘制过程中可能存在重复绘制的 View 区域，此时为了绘制效率，建议使用 Canvas 的 `clipRect`方法lai来精确控制 View 可绘制的边界，具体 clipRect 的详细介绍，可参看[链接](https://medium.com/@seanutf/cliprect-and-quickreject-c7db16e066cd)。

## Path 优化

该 View 中的背景有三根垂直排列的直线，这里用到了 path，一开始自己也是在 onDraw 中每次去计算这三根线的起始点坐标，后来经同事提示，可以事先一次性把 Path 的坐标都计算好，然后绘制时，一次性就可以把三根线绘制好。如下所示：

```java
//提前计算 path 
private void calculatedLinePath() {
    mPathGradLine.reset();
    for (int i = 0; i < mGradeCount; i++) {
        mPathGradLine.moveTo(0, bottomLine - averageGradleHeight * i);
        mPathGradLine.lineTo(getChartRealWidth(), bottomLine - averageGradleHeight * i);
    }
}

/**
 * 绘制三根背景虚线
 * @param canvas
 */
private void drawGradeAxis(Canvas canvas) {
    canvas.drawPath(mPathGradLine, mGradeAxisPaint);
}
```

## 总结

当然，具体做绘制优化时，可能不同的 View 需求，具体优化策略也可能千变万化，这里只是拿这个具体的 View 来做一点具体的介绍，不具有通用性，但是优化的思想应该有共性。

View 绘制的优化是无止境的，始终保持学习钻研、精益求精的态度方可做到最好。