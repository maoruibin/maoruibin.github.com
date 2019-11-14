---
layout: post
author: 咕咚
title: "Bitmap相关的知识点整理"
description: ""
catalog:    true
cover-color: "zzz"
tags: Collection
categories: tech 
---
图片是Android应用常见的资源，在Android中，图片数据用Bitmap这个类封装。这篇文章整理跟他相关的一些知识点。

### 1、Bitmap.Config

这是Bitmap的一个内部类(枚举)，是Bitmap关于色彩显示的配置，不同的配置对应不同的加载效果，下面是相应的文档介绍

`Possible bitmap configurations. A bitmap configuration describes
how pixels are stored. This affects the quality (color depth) as
well as the ability to display transparent/translucent colors.`

它包含四个枚举值，分别如下

    Bitmap.Config {
      ALPHA_8
      ARGB_4444
      ARGB_8888
      RGB_565
    }

具体这四个值分别代表了色彩的不同存储方式。这四个值指定了每一个像素的所占数据的大小，每个像素点都是1byte整数倍的数据。

* ALPHA_8代表每个像素点只占一个字节的大小，这个字节仅仅存储跟透明度相关的数据。
* ARGB_4444 代表16位ARGB位图
* ARGB_8888 代表32位ARGB位图，Android默认加载图片使用此种配置，所以每个像素占4字节。
* RGB_565 代表8位RGB位图

当然像素点占用的字节越多，他所存储的信息也就越多，图像也就越逼真，同时占用的内存也就越大。

### 2、大图缩放处理

设想一下自己手机拍了一张图片 大小为3120 * 4204，默认使用ARGB_8888的色彩存储方式，当把它加载到内存时，他的
大小会是3120 * 4204 * 4 = 52465920字节 除以1024 * 1024 等于 50兆，通常的手机给每一个应用分配的内存大小，小点的也就16、32 兆左右，
大点的64、96M左右的样子。
这样的情况下，如果加载两张图片后，内存就不够了，此时虚拟机自动执行垃圾回收，因为图片很可能正在使用中，属于强引用，
此时是很难把图片占用的这部分内存回收掉，
所以如果按照原尺寸加载图片，很容易出现OOM。

加上我们实际需要显示的尺寸比真实图片尺寸小很多，所以，通常我们都会在图片显示时，对图片进行压缩处理，方法大都一样

### 1、计算图片实际宽高

        BitmapFactory.Options options = new BitmapFactory.Options();
        //只加载图片边界信息到内存
        options.inJustDecodeBounds = true;
        BitmapFactory.decodeResource(getResources(), R.id.myimage, options);
        //获取图片的真实宽高
        int imageHeight = options.outHeight;
        int imageWidth = options.outWidth;

### 2、根据给定尺寸，计算缩放比

        public static int calculateInSampleSize(
                    BitmapFactory.Options options, int reqWidth, int reqHeight) {
            // Raw height and width of image
            final int height = options.outHeight;
            final int width = options.outWidth;
            int inSampleSize = 1;

            if (height > reqHeight || width > reqWidth) {

                final int halfHeight = height / 2;
                final int halfWidth = width / 2;

                // Calculate the largest inSampleSize value that is a power of 2 and keeps both
                // height and width larger than the requested height and width.
                while ((halfHeight / inSampleSize) > reqHeight
                        && (halfWidth / inSampleSize) > reqWidth) {
                    inSampleSize *= 2;
                }
            }

            return inSampleSize;
        }

### 3、根据计算出的缩放比，对图片执行缩放处理

        public static Bitmap decodeSampledBitmapFromResource(Resources res, int resId,
                int reqWidth, int reqHeight) {

            // First decode with inJustDecodeBounds=true to check dimensions
            final BitmapFactory.Options options = new BitmapFactory.Options();
            options.inJustDecodeBounds = true;
            BitmapFactory.decodeResource(res, resId, options);

            // Calculate inSampleSize
            options.inSampleSize = calculateInSampleSize(options, reqWidth, reqHeight);

            // Decode bitmap with inSampleSize set
            options.inJustDecodeBounds = false;
            return BitmapFactory.decodeResource(res, resId, options);
        }

上述方法只针对一般意义上的大图，对于像长微博这种超大图片加载，仅仅依靠上述的方法是不能达到目的的，此时需要借助其他的
方法工具进行特殊处理,如局部加载等机制，这里不展开讨论，具体可参考下面的两个链接。

[Android 高清加载巨图方案 拒绝压缩图片](http://blog.csdn.net/lmj623565791/article/details/49300989)

[WorldMap](https://github.com/johnnylambada/WorldMap)


## 参考资料

[Bitmap那些事之内存占用计算和加载注意事项](http://www.androidchina.net/2194.html)

[高效加载大图](http://hukai.me/android-training-course-in-chinese/graphics/displaying-bitmaps/load-bitmap.html)
