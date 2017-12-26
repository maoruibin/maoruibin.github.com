---
layout: post
author: 咕咚
title: "日志"
catalog: true
titleColor: "#404040"
header-img: assets/header/header_image_road.jpg
tags: 随想
---
这篇博文用于记录，自己在修改博客时具体的修改记录，如颜色设置、联系方式配置等信息，以便日后查看。


## 2017/12/24
- 增加打赏页面(CSS 有点问题) 通过 shang 这个标志进行控制
- 增加了一篇文章

grunt watch -> https://github.com/Huxpro/huxpro.github.io/issues/57

## 2017/12/19

有段时间没在这里写东西了。这段时间都干啥了呢

- 公司内部的篮球赛结束了，很尴尬的连季军都没有拿到，但是在三个月期间的10多场比赛中认识了不少微博的朋友，很值得。
- 开始思考一些问题


## 2017/10/26

早晨再一次经体验了早高峰，看到沙河的长队我还是选择了摩拜去高教园坐车，事后证明这是一个正确的选择。

1小时候 到北京南站，然后乘坐高铁开始了我的第一次南下之旅，很激动。

下午到达黄山北，先来到了老街。我一直比较喜欢古街，旁边还有一条水很清澈的河流 新安河， 夕阳西下，风景不错，后续再补图。

晚上吃了徽菜，老板娘比较有意思，很霸气，一点不在乎我们的态度。

嗯嗯 休息，明天怕黄山。


## 2017/10/25

明天就要去黄山。第一次南下，小激动

另外，今天在内部发布了开发的 AndroidStudio 插件，反响不错。

中午去公园投篮，感觉不错，三分也是可以有的。

公园旁边就是西山一号院，北京豪宅就是这个样子。

![IMG_20171025_131447.jpg](https://ooo.0o0.ooo/2017/10/25/59f09a86d8588.jpg)


## 2017/10/17
公园里的秋天是一个美丽的季节
![shot](https://wx4.sinaimg.cn/mw690/6fb50cedly1fkl62nd10sj20zn0qogsn.jpg)

另外，明天 NBA 要开赛了，不错不错。


## 2017/10/13

中午去小公园偶遇网易的几个哥们在打球，然后加入他们打了一中午球，打的很过瘾。
其中有一个篮下强起砸框进球，感觉就像是扣篮，特别棒，终于知道扣篮是会上瘾的，尤其是前面还有一个人站在那里。

晚上参加了公司内部比赛，输了，但是很开心，打的很轻松，跑完了整场。


## 2017/10/12（内部 AndroidStudio 插件开发基本完成）

放假前就开始开发一个 AndroidStudio 插件，[Wei-studio-tools](https://plugins.jetbrains.com/plugin/10055-wei-studio-tools)

这是专为微博 Android 项目开发的用户修改 gradle 配置以及上传 apk 到内部仓库。后期打算把 ADB 那个工具开放出来，其他 Android 项目也就可以用了。

主要是之前受够了在浏览器中上传时的麻烦，不过开始想的简单，功能很快就做完了，但是自己是个追求细节完美的人，所以在很多交互细节上又花了很多功夫，还在回家的路上用 sketch 设计了界面，总体现在还是比较满意的，除了有一个比较难缠的 bug, 目前已经在 feed 项目组使用，准备在完善下，把几个严重的 bug 修复了在跟架构组推荐下。

![shot](https://i.loli.net/2017/10/10/59dc63c596f76.png)

另外很感谢 SM 的图床 很好用啊 

推荐 [SM](https://sm.ms/)

### 开关

* hideLast
* hideHot
* hideTizi
* hideFriend
* hideTag

### if 或 于

```xml
  {% if user.name == 'tobi' or user.name == 'bob' %}
    Hello tobi or bob
  {% endif %}

  {% if user.name == 'bob' and user.age > 45 %}
    Hello old bob
  {% endif %}
```

## 2017/10/02(回家)
在家里呆了5天，老家天气很好，8号回京
![IMG_20171004_080439.jpg](https://i.loli.net/2017/10/04/59d42c4d97a8e.jpg)


## 2017/09/26

> 永远不要害怕问题

![mmexport1506420079841.jpg](https://wx1.sinaimg.cn/mw690/6fb50cedly1fjx4j3k3quj21kw0oltcl.jpg)

顶部消息提示 impl 


## 2017/09/22

![mmexport1506420234675.jpg](https://i.loli.net/2017/09/26/59ca26120345f.jpg)

很久没有赢球了。happy ~


## 2017/09/19（使用来比利评论系统）

还是更换了一个评论系统，

[来必力](https://livere.com/)

优点
- 可以评论设置提醒


## 2017/09/18(时间好快)

不知不觉已经找完工作在新公司工作了快三个月了。自从到了新公司现在很少打理博客了，甚至连一篇文章都没有。其实又准备过一篇关于 Drawable 的，这段时间对 Drawable 有了更多的了解，写写还是可以写出一些有意思的东西的，不过好几次动笔都没写完，先搁着吧。

前段时间玩了玩 Chrome 插件，拿咕咚翻译做了个实验，顺便练练 Html CSS，今晚发布了 1.1，于以往做的 APP 不同，这次自己用 sketch 设计了界面，尽管界面很简单，不过还是体验到了 sketch 的专业，使用 sketch 可以方便的做一些平面图，挺好的，包括简单的图标，不说了，我的咕咚翻译 [插件地址](https://chrome.google.com/webstore/detail/enpemcpghfpenphpefmocgpdiipgkkjd/publish-accepted?utm_source=chrome-ntp-icon&authuser=1)

不早了，睡觉去了。

## 2017/09/15

晚上跟同事打球，左脚又扭了一次，吓死我了，脆弱的脚踝，以后是不是应该去外线打球呢。。。

## 2017/09/08(补图)
公司附近是百望山，中午时我会自己去溜一圈，很喜欢户外的感觉，哪怕是一会儿

![59bf3de331efd.jpg](https://ooo.0o0.ooo/2017/09/18/59bf3de331efd.jpg)

## 2017/08/24(新浪微博)

![59bf3de331efd.jpg](https://i.loli.net/2017/09/18/59bf40816b616.jpg)

here is new start


## 2017/06/13(尴尬的一个时间段)
上周五打球崴脚了，当时正在篮下进行拼抢，不幸在落地时落在了别人的脚面上，我听到了『咔』的一声，我很清楚这是从右脚踝传来的，然后就到底了。

从高中开始打球到现在，尽管我一直擅长打篮下，篮板也很不错，但是从来没有在篮下崴过脚，终究还是来了。

短暂休息的过程中，我用微信搜了搜一般的处理方法，然后叫同事去帮我买了一袋冰块进行冰敷，效果不错。

周末在家休息了两天，第一天不能很方便的走路，在跟媳妇商量后我最终买了拐，后来到第二天就发现这是个错误，因为第二天行走已经没有什么大碍。

然后今天已经基本好了，今天下午还有公司的篮球赛，不过我一定不会去了。

崴脚的经历告诉我以后打球风格可能要改变啦，而且确实应该在打球时记得保护自己。 

## 2017/05/31(放假回来)

从家里回来上班，在家里的几天每天过的都很快，农村很漂亮，我喜欢那些绿色，可以在田野里大口的呼吸，感觉好极了。

回家的途中火车真的很拥挤！

[我的在线简历（2017-墨迹天气）](http://gudong.name/2017/05/08/resume.html)

## 2017/05/21(添加访问次数)
最近一直在忙面试，今天看到一微博私信要互加友链，发现对方有一篇文章分享[如何给 jekyll 主题的博客加访问统计](http://linglinyp.com/2017/05/17/busuanzi.html)，随即就加了，毕竟惦记这个功能很久了。


//网站倒计时运行代码

```javascript
<script>
   window.setInterval('counter()',1000);
   function counter(){
     var date=new Date();
     var startDate=new Date(2016,11,07,0,0,0);
     var time=(date-startDate)/1000;
     var day=Math.floor(time/(24*60*60));
     var hour=Math.floor(time%(24*60*60)/(60*60));
     var minute=Math.floor(time%(24*60*60)%(60*60)/60);
     var second=Math.floor(time%(24*60*60)%(60*60)%60);
     var str="我的博客已默默运行了" + day + "天" + hour +"时" + minute + "分" + second + "秒";
     document.getElementById('count').innerHTML=str;
   }
</script>
```

## 2017/05/08(优化首页博客描述文案显示逻辑)

### 隐藏文章显示在首页

> 设置文章的 hide 属性为 false

jekyll if else语法以及 字符串空判断

```xml
      {% if post.description and post.description != empty %}
          {{ post.description }}
      {% else %}
          {{ post.content | strip_html | truncate:200 }}
      {% endif %}
```
## 2017/04/28(完善个人作品展示)

增加了全国空气质量展示

手动设置主页背景高度，通过修改 ./css/hux-blog-min.css

```css
intro-header .page-heading{text-align:center;height: 450px;}
```

## 2017/04/27(公众号二维码增加开关)

>qrcode_mp 新增的一个 page 属性 用于控制页面底部是不是显示公众号二维码

<img src="http://7xr9gx.com1.z0.glb.clouddn.com/IMG_20170427_111732.jpg" style="width: 50%"/>  



## 2017/04/25(博客增加了公众号)

突然心血来潮，看到[小黑屋](http://droidyue.com/)的公众号后，自己终于把申请了好久的公众号再次打扮了一下，并且在博客中放置了二维码。

<img src="http://7xr9gx.com1.z0.glb.clouddn.com/qrcode_for_gh_58ac6be237a4_430.jpg" style="width: 50%"/>  

昨晚添加了自定义菜单，并且编辑了四篇文章。尽管还有很多问题，但是公众号总算是跑起来了。

接下来要认真学习，写一写技术文章。

如果你看到这里了，不妨关注下公众号？ \*_\*

## 2017/04/24

最近这段时间做了不少好玩的东西。

先做了一个 App [易剪](http://gudong.name/product/2017/03/15/about_easypaper.html),本打算开源，后来赖的没做。然后倒是开源了 [OneDrawable](https://github.com/maoruibin/OneDrawable) 这一按钮按下效果处理方案，当然这个方案对一般 MD 设计没太大用处，基本做给 iOS 设计的 UI 效果。

最近在看 Java 虚拟机。感觉比以前理解的深入多了。


## 有用的查询网址

* [企业注册信息查询](http://www.tianyancha.com/)

## 2017/02/15
今天更新了 Android 6.0 自定义文本操作的一篇[文章](http://www.jianshu.com/p/40e84359d683)，并且投稿给了鸿洋，第一次投稿，看看效果！

## 2017/02/04

适配了 Chrome tab

thanks [https://teaink.com/archives/270.html](https://teaink.com/archives/270.html)

## 2017/02/03
不知不觉已经 17 了，我的 2017 会不一样一点。

今天终于把 G 键的映射通过一个映射软件修改了。

### 运行草稿

```
jekyll server --drafts

To preview your site with drafts, simply run jekyll serve or jekyll build with the --drafts switch. 
```

## 2016/11/28
今天还是把去年特别喜欢的一个背景图上传作为了我的博客背景。

一年的时间，经历了太多，人生就是不断认识自己的过程，自己会对以前的一些决定进行思考，大多数时候，自己不会去太深刻的思考那些已经发生的事，但是这一年发生的一系列事，不由得让你去重新审视自己。

幼稚、人心、生活。。。。。

##  2016/11/07

今天新增了一篇介绍 [ReView](https://github.com/maoruibin/ReView) 的文章，昨天就想写，但是净忙着写 [ViewControler](https://github.com/maoruibin/ViewControler/) 的文章了，就没有顾上，今天即使再晚也要补上。

另外，今天因为自己的原因（一行 log 引发的惨案），公司项目日志数据上传异常，日志数据成倍增长，着实吓我一跳，自己确实需要对上千万的用户负责啊，你的一个小错误，到用户那里累计起来的影响太大了。好在并没有造成什么大面积事故，以后要小心。

##  2016/10/25
昨天是 1024 程序员节,依旧记得去年是一个人过的,那天是周日,我一人宅在家里宅了一天,还写了一篇长长的日志,记得特别清楚,那天为自己换了一个 jekyll 主题,很喜欢的主题。不过现在已经被我换了,哈哈。黄玄的这个主题确实没法拒绝,太多特性是自己期待了很久的东西。

很快,今年的 1024 这么快已经到了,到今天已经过去一天了,但是昨天的事却历历在目,今年的 1024,我不在是程序员,而是作为一个人民群众去所在地派出所办理户口、身份证相关手续。

整整一天,我从早晨 6.30 起床,到晚上8点多坐车回永昌,终于将整个其实只需要半小时就能办完的手续办完了。我目睹了地方机构办事效率的地下,以及鸡毛当令箭使得形式主义作风。

终归办完了,思考良多,一方面这种办事机构有问题,另一方面地方群众的素质也是一个问题,不想展开说了!

### 字符串包含判断

还是记录下 一个 Liquid 语法问题,检查一个字符串是不是包含一个字符串

```js
//定义一个全局 site 常量
theme_color: "#607D8B"

//判断 双括号
{page.cover} contains 'zzz'
```

### 自定义背景

至此,我的博客背景支持了自定义纯色背这个特性,默认使用一张箭头背景图片,如果不喜欢,可以为 post 设变量 `cover` 这个属性用于设置文章头部背景颜色

```js
//使用自定义颜色
cover: "#f78789"
//表示使用博客主题颜色
cover: "zzz"
//使用指定图片作为背景图
header-img: assets/header/header_image_road.jpg
```

### 自定义 Title color

因为一些背景是亮色背景,但是默认所有 title 都是白色,所以在一些文章中,如果选用了浅色的背景,标题就会不清晰,所以今天加了一个新特性,可以用来设置 title 颜色,如下所示,
直接在 post 使用 titleColor 属性即可。

```js
titleColor: "#404040"
```



##  2016/10/22

今天回家了,火车没事干,想起自己的博客草稿箱还有好几篇文章已经放了好久,感觉可以趁这个空修理下,然后就把 [5.0 的元素共享](/2016/10/22/Android-transition.html)那篇博文更新了。

今晚给 post 新增了一个属性 `conver` 用于控制头部背景颜色,如果不设置默认使用一张转为博客设计的背景图片,也很好看。

```js
background-image: url('{% if page.cover %}{% else %}{{ site.baseurl }}/{% if page.header-img %}{{ page.header-img }}{% else %}{{ site.header-img-post }}{% endif %}{% endif %}');
background-color: {{ page.cover }};
```

修改 CSS 使用

```css

grunt watch

```



## 2016/07/02
不知不觉，已经放弃上一个博客主题好久了，现在福生还在使用我的主题[sunfusheng](http://sunfusheng.com/)

今天，终于有时间可以搞下博客了，这段时间都太忙了。


## 2016/03/27
项目主颜色设置在 less 目录下的 variables.less

## 2016/03/26
今天已经修改自己博客的主题为另一个主题了

## 2016/02/29
隐藏了post 页面的 tag、category 点击相应，因为 jekyll archive 不支持 Github Page   
使用了新的代码高亮样式 减小了 padding 值

## 2016/02/26
指定引用图片的宽度大小，可通过如下方式

    <img src="/assets/over_draw_color_2.png" style="width: 50%;margin: auto;"><br>

##2016/01/20

修改代码块的主题样式在 _include/head.html 文件中修改

可以再 [bootcdn](http://www.bootcdn.cn/highlight.js/)下载    

        <!-- thanks to http://www.bootcdn.cn/lightbox2/      -->
        <!-- thanks to http://www.bootcdn.cn/highlight.js/   -->
        <!-- thanks to https://highlightjs.org/static/demo/  -->
        <link  rel="stylesheet" href="//cdn.bootcss.com/highlight.js/8.5/styles/androidstudio.min.css">
        <link rel="stylesheet" href="//cdn.bootcss.com/lightbox2/2.8.2/css/lightbox.css">

修改代码块的padding font  在 _sass/_layout.scss

        pre code.hljs {
        	font-size: modular-scale(0);
        	padding: 1.5em;
        }


##2016/01/12

修改底部四个按钮大小 在 footer.html

    .fa-lg{
            font-size: 1.5em;
        }

设置顶部 Title(咕咚)的高度

      .logo {
        float: left;
        height: 4em;
        border:0px solid #000;
        padding-top: 0.6em;
        @include media ($tablet) {
        	padding-left: $em-base;
        }

设置底部的按分类查看为隐藏

      <p style="display:none;">
        <a href="{{ site.baseurl }}posts">View All Posts by Category</a>
      </p>

## 2015/12/5
为博文增加了一个开关，如下所示

    ---
    layout: post
    author: 咕咚
    title: "在Android5.0以上设备实现过度动画"
    description: ""
    categories: Technology
    publish: false
    tags: Android Animation
    ---

只要设置 publish 为 false ，那么这篇博文将不会出现在主页列表，不设置默认表示文章处于发布状态

## 2015/10/27

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

## 2015/10/25

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
