---
layout: post
author: 咕咚
title:  "如何用好github中的watch、star、fork"
description: ""
categories: 技术
tags: Github Usage
cover:  "#3e4145"
---
在每个github项目的右上角，都有三个按钮,分别是watch、star、fork，但是有些刚开始使用github的同学，可能对这三个按钮的使用却不怎么了解，
包括一开始使用github的我也是如此，这篇博客，结合自己的理解和使用，说说这三个按钮的用法以及一些个人见解。


如下图所示这是我们经常看到的三个按钮。

![usage](/assets/github_usage_1.png "usage")

从左至右，依次是watch star fork,下面分别说下他们的具体作用。

### watch
watch翻译过来可以称之为观察，点击watch可以看到如下的列表。

![usage](/assets/github_usage_2.png "usage")

默认每一个用户都是处于Not watching的状态，当你选择Watching，表示你以后会关注这个项目的所有动态，以后只要这个项目发生变动，如被别人提交了pull request、被别人发起了issue等等情况，
你都会在自己的个人通知中心，收到一条通知消息，如果你设置了个人邮箱，那么你的邮箱也可能收到相应的邮件

如下，我watching了开源项目 android-cn/android-discuss ，那么以后任何人只要在这个项目下提交了issue或者在issue下面有任何留言，我的通知中心就会通知我。


![usage](/assets/github_usage_3.jpg "usage")


如果你不想接受这些通知，那么点击Not Watching 即可。


### star
star翻译过来应该是星星，但是这个翻译没任何具体意义，这里解释为`关注`或者`点赞`更合适，当你点击star,表示你喜欢这个项目或者通俗点，可以把他理解成朋友圈的点赞吧，表示对这个项目的支持。

不过相比朋友圈的点赞，github里面会有一个列表，专门收集了你所有start过的项目，
点击github个人头像，可以看到your star的条目，点击就可以查看你star过的所有项目了。如下图


![usage](/assets/github_usage_4.png "usage")


不过，在你的star列表很容易出现这样的问题。就是你可能star成百上千个项目怎么办。这时，如果github可以提供一个分类功能该多好，就像微博网页版的收藏，你在收藏的时候可以设置tag，
这样设置的好处是，以后再次查找项目时，可以根据归类查找，但是不知道github的产品经理是怎么想的，github本身没有这个功能，但是github从来也不缺有思想有执行力的程序员，这不，前段时间就有人做了一个Chrome插件，
这个插件可以对github中所有star的项目进行分类，如下所示，注意看图片右侧，多了一个Filter by tag 列表。


![usage](/assets/github_usage_5.webp "usage")



[下载地址](https://chrome.google.com/webstore/detail/github-stars-tagger/aaihhjepepgajmehjdmfkofegfddcabc).

尽管这个插件已经很好了，但是还是有缺点，你只能star完项目了，去star列表后，才能对项目打tag，这是很不方便的。

真心希望，未来github可以自己支持对star的tag处理。憧憬...


### fork
当选择fork，相当于你自己有了一份原项目的拷贝，当然这个拷贝只是针对当时的项目文件，如果后续原项目文件发生改变，你必须通过其他的方式去同步。

一般来说，我们不需要使用fork这个功能，至少我一般不会用，除非有一些项目，可能存在bug或者可以继续优化的地方，你想帮助原项目作者去完善这个项目，那么你可以fork一份项目
下来，然后自己对这个项目进行修改完善，当你觉得项目没问题了，你就可以尝试发起 push request给原项目作者了，然后就静静等待他的merge。

我看到很多人错误的在使用fork。很多人把fork当成了收藏一样的功能，包括一开始使用github的我，每次看到一个好的项目就先fork，因为这样，就可以我的repository列表下查看fork的项目了。
其实你完全可以使用star来达到这个目的。

### 使用建议

* 对于一些可能会经常发生变化的会不定期更新的好项目 多使用watch.

  比如android-cn团队的android-discuss项目，你就可以watching它，这里面都是一些关于Android技术的交流，如果有任何新问题，你都可以收到通知，你可以查看别人的回答，你可以回答别人提出的问题，
  这是一个很好的学习成长方式。其他值得watch的项目还有很多，比如github上很多的Awesome系列的项目，你watch这些项目了，只要项目新增一些好玩好用的东西，你就会收到通知。我在知乎上看到有人问这样的问题，
  说github上有哪些值得watch的项目，其实有很多，我自己也整理了一些，但是没放到github，有兴趣的同学可以联系，一起维护这样一个项目。
  
  值得注意的是，如果watch多了，你可能会被无休止的邮件通知烦死（邮件通知可设置），所以做好权衡，哈哈~
   
* 喜欢一个项目就star它吧~
* 修改开源项目就使用fork，这样你就可以在原项目的基础上，对项目进行修改提交，现在你是这个项目的主人啦~

### 小细节

  有些时候，你可能特别想知道，都有哪些人star了这个项目，但是你却找不到一个入口，后来自己不经意的发现
  只要`点击star的数字`，就可以查看有哪些人star了这个项目。是不是有点意思，现在你就可以去试试，watch、fork上面的数字都是可以点击的，道理一样。 
  
### 结语  
  
  这里只说了关于这三个按钮的使用，github肯定还有很多使用技巧，欢迎大家多多讨论，互相学习。另外我在android-cn的android-discuss下面和知乎上
  都分别提了类似的问题，大家感兴趣的可以关注下。
  
  Github [Github上都有哪些有意思、不为大家熟知的小功能？](https://github.com/android-cn/android-discuss/issues/283)
    
  知乎 [Github上都有哪些有用但不为大家熟知的小功能？](http://www.zhihu.com/question/36974348)
  
  

