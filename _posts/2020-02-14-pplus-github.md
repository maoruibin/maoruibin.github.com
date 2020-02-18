---
layout: post
author: 咕咚
title: "如何为 PicPlus（手机端图床上传工具）配置 Github 作为远程图床"
author: gudong
tags:  图床
categories: blog
---

如果对 PicPlus 这个图床工具还不了解，可通过这篇文件了解，[PicPlus：Android 手机端的图床利器 \| 咕咚](https://gudong.site/2019/12/03/about-xPic.html)。

### 准备工作

在配置之前，首先需要一个 GitHub 账号，你可以打开 [GitHub 官网](https://github.com/)先去完成账号注册。

有账号后，需要创建一个 github 仓库用来存储图片，如果你已经有仓库了，也可以直接复用，不过如果打算长期用 GitHub 做图床，还是建议建一个单独的图片仓库来存储图片，这样更容易管理。

### 创建仓库

点击 GitHub 页面右上角的加号按钮，可以选择创建仓库，如下图所示：

![](https://cdn.jsdelivr.net/gh/maoruibin/maoruibin.github.com/assets/picgo/2019/20200211205755.png)

点击 `New Reposity` 后，接下来需要填写仓库的基本信息，这里只需要填写仓库的名称即可（记得用英文，比如 MyPic、Picture 之类的），其他的信息默认就好，不用填也不用选，然后直接点击最底下绿色的创建按钮即可。

![](https://cdn.jsdelivr.net/gh/maoruibin/maoruibin.github.com/assets/picgo/2019/20200211210722.png)

> Note：不要去设置仓库的访问属性，默认公开，不用动，否则上传不了图片。

### 获取 token 

接下来需要为在自己 GitHub 账号下创建一个 token，这个 token 将用来让 app 帮你上传图床，它是软件可以上传图片到 GitHub 的通行证。

具体可以点击 [https://github.com/settings/tokens] (https://github.com/settings/tokens) 去创建 token，打开页面后点击 `Generate new token` 按钮。

![](https://cdn.jsdelivr.net/gh/maoruibin/maoruibin.github.com/assets/picgo/2019/20200211211229.png)

点击按钮后会进入创建 token 的页面，这个页面只需要随便输入一个 token 名称即可，比如 pic 等，记得用英文，然后勾选下面的 repo 框就可以了，其余的不用选，然后点击最下方的绿色按钮就可以生成 token 了。

![](https://cdn.jsdelivr.net/gh/maoruibin/maoruibin.github.com/assets/picgo/2019/20200211211548.png)

生成 token 后，这个 token 很重要，现在立即复制它（刷新就没有了，只能重新生成。），发送到自己手机上，这个信息配置 GitHub 图床时需要。

![](https://cdn.jsdelivr.net/gh/maoruibin/maoruibin.github.com/assets/picgo/2019/20200211212151.png)

### 在咕咚 Markdown 助手中配置 GitHub

软件中的配置页面在设置 -> 图床选择 页面，然后点击 GitHub 一项即可配置，如下所示：

![](https://gitee.com/maoruibin/assert/raw/master/pic/test/11bae89-6f3bacda-97-17058c3c958.jpg)


下面需要填入四项信息，假定现在已经完成了上面的注册，并获得了如下信息

* token：  xxxxxxxxxxxxxxx
* Github 用户名：gudong
* 仓库名称：pic

#### PicGo 用户特别提醒
按照 PicGo 的设置方式，仓库名的输入格式为：用户名/仓库名，而 PicPlus 中 **GitHub 用户名** 跟**仓库**是两个不同的属性，需要分别输入，特别注意。


如下所示，首行需要输入 token 字符串，接着输入 github 用户名，然后输入仓库名称，按照示例分别填入 `gudong` 跟 `pic` 就 OK，如下图所示：

![](https://cdn.jsdelivr.net/gh/maoruibin/assets/pic/2020/Screenshot_20200214-190212.jpg)


#### 关于存储路径

默认可以不填，这样图片会存储在仓库根目录。

也有不少人想更有条理的管理图片文件，比如按年存储，那可以在仓库中创建对应的子文件夹，比如2020、2021  这样的目录，

> 如果对如何在 GitHub 仓库中创建文件夹不熟悉，可以参考这篇文章，[GitHub上如何创建/删除文件夹 \- 云\+社区 \- 腾讯云](https://cloud.tencent.com/developer/article/1455721)。

创建完毕后，在最后一个输入框填入上面创建好的文件夹名，比如 2020，如果还有子文件夹，比如 work、home，则需要在目录之间加入 `\` 标识，比如填入 2020\work 


以上就是配置 PicPlus GitHub 图床的所有步骤，希望我说明白了。

如果在配置中还有什么问题，可以在酷安私信我，也可以发邮件(1252768410艾特qq.com)给我，说明具体情况，最好有截图，最后再次感谢你的使用。