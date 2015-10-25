---
layout: post
author: 咕咚
title: "博客更新日志"
description: "利用Github搭建博客后,我写的第一篇博客"
categories: 个人
cover:  ""
tags:	Jekyll
---
这篇博文用于记录，自己在修改博客时具体的修改记录，如颜色设置、联系方式配置等信息，以便日后查看。

### 10/25

当设置博客北京的conver属性后，如果没有设置图片，则会显示一个纯色的背景，这个纯色的背景的设置具体在/sass/layout.scss下面

      .scrim {
        padding: 3em 1em;
        &.has-cover {
          background-color: $action-color;
          padding: 6em 1em !important;
          @include media($tablet) {
            padding: 9em 1em !important;
          }
        }
      }
  	
$action-color在/sass/base/variables.scss下面

    // Font Colors
    $base-background-color: #fff;
    $base-font-color: $dark-gray;
    $action-color: $blue;
    $highlight-color: tint($action-color, 33%);
    
真心佩服作者这种清晰明了的设置方案。

经验证 上面的方式有问题，background-color 必须为半透明颜色，还是改回来，换个颜色就行！
