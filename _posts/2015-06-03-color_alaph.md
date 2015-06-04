---
layout: post
title: "Android通过颜色设置背景透明度"
description: "Android通过颜色设置背景透明度"
categories:
  - Android
tags: [Util]
---
{% include JB/setup %}

##描述
在开发过程中，经常需要把一个View的背景设置为半透明，在以前开发的过程中，大多情况下，都是简单粗暴的叫美工做一个半透明的背景图片，但是相应的，IOS组的Coder的却不需要跟设计师索要半透明背景图，因为IOS自己就已经提供了很好的半透明属性设置API，顿时觉得Android好low,知道今天在github瞎逛时，意外的发现了一个可以动态设置颜色半透明的方法。这个方法可以给指定的颜色指定具体值的alpha值，如下，只要传一个Color的字符串形式，如#f5f5f5,然后传递一个0到1的double值 即可得到对应的半透明颜色，亲测有效。

    /**
    * Adds alpha to a hex color
    *
    * @param originalColor color, without alpha
    * @param alpha         from 0.0 to 1.0
    * @return the original color with alpha
    */
    public static String addAlpha(String originalColor, double alpha) {
        long alphaFixed = Math.round(alpha * 255);
        String alphaHex = Long.toHexString(alphaFixed);
        if (alphaHex.length() == 1) {
            alphaHex = "0" + alphaHex;
        }
        originalColor = originalColor.replace("#", "#" + alphaHex);
        return originalColor;
    }


奉上原项目地址 https://github.com/cesarferreira/colorize
