---
layout: post
author: 咕咚
title: "Android通过颜色设置背景透明度"
description: "Android通过颜色设置背景透明度"
catalog:    true
tags: Skills
categories: tech 
---
在开发过程中，经常需要把一个View的背景设置为某个颜色的半透明状态。通常我们可以通过设置颜色值的前两位而达到效果，一般情况下也能满足基本需求，比如白色色值为#ffffff,那么他的半透明颜色值可以写成#88ffffff，这样设置背景后也可以出现半透明效果。其实颜色值的前两位就是控制颜色的半透明状态的。


但是有时设计师可能会跟你提这样的要求，他需要你设置一个0.56等等很参数化的半透明颜色，这时就很难用经验值去设置了，今天看到一个很不错的Util方法，可以动态根据半透明值，生成对应的颜色值。

如下，这个方法可以给指定的颜色指定具体值的alpha值，只要传一个Color的字符串形式，如#f5f5f5,然后传递一个0到1的double值 即可得到对应的半透明颜色，亲测有效。

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


[代码原地址](https://github.com/cesarferreira/colorize)

[半透明对应的 value · Issue \#34 · maoruibin/maoruibin\.github\.com](https://github.com/maoruibin/maoruibin.github.com/issues/34)
