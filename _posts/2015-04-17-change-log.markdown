---
layout: post
author: 咕咚
title: "博客更新日志"
description: "利用Github搭建博客后,我写的第一篇博客"
categories: 个人
cover: "zzz"
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

### 10/27

修改了默认的博客头部背景颜色设置。

在写博客时，在博客一开始指定cover时，现在可以有四种可选项了，

      cover: "assets/1024_programer.png"
      cover: "#f8f8f8"
      cover: "zzz"
      不设置

四种设置分别对应下面的四种表现    

* 在博文中设置cover属性为assert下面的图片，必须是assets下面
此时文章头部背景将会是一张大图

        style="background-image: url(/////);"
  
* 在博文中设置cover属性为以#开头的颜色值
此时文章头部背景将会是纯色
  
        style="background-color:#xxxxxx;"
        
* 在博文中设置cover属性为"zzz"
此时文章头部背景将会是主题指色，这个颜色在config中指定
  
        theme_color: "#607D8B"

* 在博文中不设置cover属性
此时文章头部将不会显示任何大背景色，只有一个分割线        
    
  		 
  
