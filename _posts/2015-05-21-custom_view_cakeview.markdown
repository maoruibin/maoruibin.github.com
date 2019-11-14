---
layout: post
author: 咕咚
title: 自定义view之饼状图的实现
catalog:    true
tags: View
categories: tech 
---
一个圆形饼状View的实现过程。

**CakeView**是一个通过自定义做的饼状图，如下图所示，会根据比例显示不同的占比。

<img src="/assets/cakeview_v2.png"  alt="CakeView原理图" title="CakeView原理图"  style="width: 50%;margin: auto;">

这个view会根据传入的两个数字参数 生成不同的占比大小。

### 实现原理### 

画出一个背景为红色的大圆圈，然后再画一个圆心跟红色圆圈一致的扇形。最后在中央画一个白色小圆，然后大概的样式就出来了，最后在中央写上文字内容即可。如下演示
![CakeView原理图](/assets/cakeview_principle_v2.png "CakeView原理图")

上面已经很清楚的看到了具体的实现过程。核心操作均在onDraw方法，如下

	@Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        RectF rPrimary = new RectF(0,0,mWidth,mWidth);
        RectF rSecond = new RectF(mBorderWidth,mBorderWidth,mWidth-mBorderWidth,mWidth-mBorderWidth);
        //绘制主色圆圈
        canvas.drawOval(rPrimary, mPrimaryPaint);
        //绘制副色圆圈 这里绘制一个指定角度的扇形
        canvas.drawArc(rPrimary, mStartAngle, mSweepAngle, true, mSecondaryPaint);
        //绘制中心圆圈 白色中心
        canvas.drawOval(rSecond, mCenterPaint);

        //绘制标题文本
        if(!TextUtils.isEmpty(mTitle)){
            Path titlePath = new Path();
            titlePath.moveTo(mHalf * (1f / 4f), mHalf * (7f / 8f));
            titlePath.lineTo(mHalf * (7f / 4f), mHalf * (7f / 8f));
            mTitlePaint.setTextSize(sp2px(getContext(), 14f));
            mTitlePaint.setTextAlign(Paint.Align.CENTER);
            canvas.drawTextOnPath(mTitle, titlePath, 0, 0, mTitlePaint);
        }

        //绘制内容文本
        if(!TextUtils.isEmpty(mContent)){
            Path contentPath = new Path();
            contentPath.moveTo(mHalf*(1f/4f), mHalf*(7f/6f));
            contentPath.lineTo(mHalf * (7f / 4f), mHalf * (7f / 6f));
            mContentPaint.setTextSize(sp2px(getContext(), 24f));
            mContentPaint.setTypeface(Typeface.defaultFromStyle(Typeface.BOLD));
            mContentPaint.setTextAlign(Paint.Align.CENTER);
            canvas.drawTextOnPath(mContent, contentPath, 0, 0, mContentPaint);
        }
    }


关于画扇形，这里推荐一篇国外的博客，写的很好，对carvas的drawArc方法解释的很详细。

[Understanding Sweep angle in drawArc method of android](http://www.cumulations.com/blogs/5/Understanding-Sweep-angle-in-drawArc-method-of-android "Title")

此外。整个实现过程中，还发现canvas有一个特别好的方法**drawTextOnPath()**
利用这个方法可以方便的文字的显示位置。

update:上述的画饼状图的方式会存在过度绘制的问题，尽管问题看上去不大，其实如果只是画一个圆圈，没必要这么麻烦，可以直接
画一个指定宽度的圆线就对了，自己的实现其实有点麻烦了。

更新于 2016/01/16 00:30
