---
layout: post
author: 咕咚
title: "追寻 Unix/Linux 的源头，那些改变世界的人们..."
shang: true
description: 昨天看文章时发现自己对 linux 操作系统不够了解，还记得 17 年时听过老师的一些课，对 linux 的历史有一点了解，不过当时并没有记录笔记，现在已经忘的差不多了。这次从网上找资料，又重新看了一遍，同时做了一些笔记。
qrcode_mp: false
tags: 操作系统  
image: https://tva1.sinaimg.cn/large/006y8mN6ly1g6xx9axo6ij313w0u04qp.jpg

headerImage: true
categories: blog 
---
昨天看文章时发现自己对 linux 操作系统不够了解，还记得 17 年时听过老师的一些课，对 linux 的历史有一点了解，不过当时并没有记录笔记，现在已经忘的差不多了。这次从网上找资料，又重新看了一遍，同时做了一些笔记。

这次看的是[鸟哥的文章](http://cn.linux.vbird.org/linux_basic/0110whatislinux.php#whatislinux_unix#)，他把 unix linux 的起源历史讲的相当细致，读起来非常有意思，而且本来他们的历史也是一个非常复杂曲折的过程，认真读一读也是收货颇多。

Unix 算是操作系统的鼻祖，尽管现在移动平台中的 Android、iOS  操作系统，电脑中的 MAC OS 以及 windows 操作系统都很流行，但是他们其实都是后来才出现的，况且苹果的 mac os 实际也是 Unix 的一个分支而来。	

## Unix 起源

Unix 诞生在上世纪 60 年代，但它的诞生并不是有意为之，而是从贝尔实验室、麻省理工学院、通用电器合作的一个失败的项目（Multics）演变而来。当时他们做的项目由于资金问题以及延期等原因失败了，后来项目中的另一个人在做自己的个人项目时，想到了之前的旧项目，觉得可以拿过来改一改，有可用的地方，所以自己大幅度更改了旧项目，让其简化，并起名 Unics ，不过一开始他用的是汇编语言，所以它的可移植性并不好。

后来实验室的同事发现这个东西太好用了，但是移植性差，后来便把它用更高级的 C 语言重写了一遍，同时把名字改为 Unix，这才是 Unix 的开始，这一年是 1973 年。

这时 Unix 正式登上历史舞台，不过当时版权、软件许可证等等条件都不完善，Unix 在变得流行的同时，也出现了很多问题，Unix 一开始比较 open，源代码大家可以相对轻松的看到，后来贝尔实验室的母公司 AT&T 发布了一条禁令，禁止大学用 Unix 源码进行教学。这条禁令让一个大学教授 Tanenbaum 很费神，因为他的工作就是教学生 Unix。

但是方法总比问题多，他自己曲线救国，想到了自己造一个类似 Unix 的操作系统，毕竟他对 Unix 已经十分熟悉，为了防止版权问题，他在写操作系统时完全不看 Unix 源码，后来自己耗时两年，在 1984 年开始写，到 1986 年写完了这个类 Unix 的操作系统，并起名 Minix，意思就是迷你 Unix 系统。另外这个系统完全兼容 Unix，也就是说在 Unix 上运行的软件，也可以在 Minix 上运行。

不过 Tanenbaum 开发 Minix 初衷是为了方便自己教学，所以完成 Minix 后，他并不去推广，而且它并不免费，你想看必须通过购买光磁带才行，不过当时很便宜，与此同时磁带中还附带了源码，非常良心啊，但是这样传播还是很慢，这是 1986 年。

慢慢的大家发现这个 Minix 也很好用啊，有很多人在论坛里给 Tanenbaum 提建议，觉得 Minix 还可以变得更好，但是教授太忙，自己也无心去继续完善。

终于历史即将迎来转机...

## 不得不提的自由软件

Richard Stallman 是一个自由软件的追求者，同时是一个即刻，他信仰自由软件，相比商业软件，自由软件可以更加快速的传播，可以团结更多优秀工程师的力量，但是 Unix 在是一个商业软件，所以他希望创建一个真真自由而开放源代码的专有 Unix 系统替代品。但是创建一个操作系统谈何容易，他开始以 GUN 的名义开发 Unix 平台上的工具程序和软件，Unix 源码不开源，但是我开发的这些软件套件开源。当时也有一个内核项目在进行，但却是是一件很难的是。没有内核，

自由软件和开源就很难进行，但是他的工作还是非常有意义的，他开发了 GUN 套件以及一些 Unix 平台上的编译程序，主要有：

- Emacs
- GNU C (GCC)
- GNU C Library (glibc)
- Bash shell

后来很多软件开发者都在这些基础上用这些工具进行程序开发，进一步壮大自由软件团体，不过相比最初的构想，**建立一个自由的 Unix 操作系统**，这些还远远不够，因为没有内核，所以那些软件依旧只能运行在有专利的 Unix 平台上，一直到 Linux 的出现...

## Linux 要来了

1988 年 芬兰人 [Linus Torvalds](http://en.wikipedia.org/wiki/Linus_Torvalds) 进入了自己外祖父的大学-赫尔辛基大学，就读计算机科学，因为专业关系，他在大学时接触到了 Unix，但是当时机器资源紧张，学校的机器不够他玩，他就像自己搞一个 Unix，但是这东西那是那么容易就搞，一个操作系统相当的复杂。

不过很快，他就知道了 Minix 的消息，所以他跟很多人一样也购买了 Minix 磁带，然后把 Minix 安装在了自己贷款购买的 Intel 386 电脑上，终于可以愉快的玩耍了，而且磁带中是有源码的，所以他就可以更改优化它，毕竟是大牛，很快他就让 Minix 支持了多任务。

后来他在 BBS 上也留言，说 Minix 可以变得更好更强大，但是 Tanenbaum 依旧不愿意去做这件事，后来 [Linus Torvalds](http://en.wikipedia.org/wiki/Linus_Torvalds)  就想，何不自己搞一个内核玩，而且现在还有 Minix 可借鉴，站在巨人的肩膀上，一切做起来就简单多了，所以他就开始了核心程序的开发。

好在那时的很多软件条件都已经具备，很重要的就是GNU 的自由软件， 他用GNU 的自由软件(上一节提到的)将核心程序代码与386紧紧的结合在一起，最终写出他所需要的核心程序。然后发布在了校内 BBS 上。

![](https://tva1.sinaimg.cn/large/006y8mN6ly1g7u4cf8gc3j30gy04njrc.jpg)

同时提供了下载，有趣的是由于 FTP 上下载目录的名称为： Linux，所以大家都开始叫它 Linux。

后来为了兼容 Unix，[Linus Torvalds](http://en.wikipedia.org/wiki/Linus_Torvalds) 决定修改 Linux，以便让所有 Unix 上能运行的软件都可以在 Linux 上运行，而且那时已经有成熟的 [POSIX](http://en.wikipedia.org/wiki/POSIX) 规范，所以他按照这个规范，实现了这个规范，慢慢的 Linux 变得越来越好，越来越好...

## 要点

* 通过 C 语言重构 Unix、Unix 具有了很好的可移植性，让其可以移植到许多硬件体系结构中。
* Ken Thompson 的 [Unix 哲学](https://link.zhihu.com/?target=https%3A//en.wikipedia.org/wiki/Unix_philosophy) 成为模块化软件设计和计算的强大模型。Unix 哲学推荐使用小型的、专用的程序组合起来完成复杂的整体任务。
* Linux 的很大吸引力在于操作系统在许多硬件体系结构（包括现代 PC）上的可用性以及类似使用 Unix 系统管理员和用户熟悉的工具的能力
* 在 Unix 发行版中缺少一个影响软件和硬件供应商的通用内核。
* 对于 Linux，供应商可以为特定的硬件设备创建设备驱动程序，并期望在合理的范围内它可以在大多数发行版上运行。
* Linux 已经显示出其超越 Unix 的显著优势在于其在大量硬件平台和设备上的可用性。

## 链接

* [鸟哥的 Linux 私房菜 \-\- Linux是什么？从Linux的历史谈起](http://cn.linux.vbird.org/linux_basic/0110whatislinux.php#whatislinux_unix)
* [Linux vs\. Unix：有什么不同？ \- 知乎](https://zhuanlan.zhihu.com/p/37750742)

## 关于作者

咕咚，Android 工程师，个人博客 [gudong.site](gudong.site)，公众号：咕喱咕咚

![公众号:咕喱咕咚](https://ws3.sinaimg.cn/large/006tNbRwgy1fykl72khq0j305g05g0sq.jpg)