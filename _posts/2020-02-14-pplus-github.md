---
layout: post
author: 咕咚
title: "如何为 PicPlus 配置 Github 作为远程图床"
author: gudong
tags:  图床
categories: blog
---

PicPlus 是一个**图床上传 APP**，可帮你**上传手机图片到图床**，并生成 markdown 链接，支持七牛云、阿里云等主流图床，同时还支持配置 GitHub、码云为个人图床。


这篇文章主要介绍如何在 PicPlus 中配置 GitHub 为个人图床，更多关于 PicPlus 的介绍，可阅读这篇文章 - [PicPlus：Android 手机端的图床利器](https://www.yuque.com/gudong-osksb/twgz5k/bfdihv)。


### 准备工作


在配置之前，首先需要一个 GitHub 账号，你可以打开 [GitHub 官网](https://github.com/)先去完成账号注册。


注册账号后，需要创建一个 github 仓库用来存储图片，如果你已经有仓库了，也可以直接复用，不过如果打算长期用 GitHub 做图床，还是建议建一个单独的图片仓库来存储图片，这样更容易管理。


### 创建仓库


点击 GitHub 页面右上角的加号按钮，可以选择创建仓库，如下图所示：


![](https://cdn.nlark.com/yuque/0/2020/png/159409/1584324593239-18f7c41e-82bf-4b94-8049-e4b97271f193.png#align=left&display=inline&height=514&margin=%5Bobject%20Object%5D&originHeight=514&originWidth=1292&size=0&status=done&style=none&width=1292)


点击 `New Reposity` 后，接下来需要填写仓库的基本信息，这里需要填写**仓库的名称**（记得用英文，比如 MyPic、Picture 之类的），**建议勾选 initialize，**它会在初始化仓库时生成一个 readme 文件。其他的信息默认就好，然后直接点击最底下绿色的创建按钮即可。


![](https://cdn.nlark.com/yuque/0/2020/png/159409/1586226031552-d262211a-d39c-4632-9b89-9c35ae0646c3.png#align=left&display=inline&height=661&margin=%5Bobject%20Object%5D&originHeight=661&originWidth=853&size=0&status=done&style=none&width=853)


> Note：不要去设置仓库的访问属性，默认公开，不用动，否则上传不了图片。



### 获取 token


接下来需要为在自己 GitHub 账号下创建一个 token，这个 token 将用来让 app 帮你上传图床，它是软件可以上传图片到 GitHub 的通行证。


具体可以点击 [[https://github.com/settings/tokens](https://github.com/settings/tokens)] ([https://github.com/settings/tokens](https://github.com/settings/tokens)) 去创建 token，打开页面后点击 `Generate new token` 按钮。


![](https://cdn.nlark.com/yuque/0/2020/png/159409/1584324592953-a4af9ba7-1e6a-45e7-9038-faa041b1f492.png#align=left&display=inline&height=260&margin=%5Bobject%20Object%5D&originHeight=260&originWidth=1526&size=0&status=done&style=none&width=1526)


点击按钮后会进入创建 token 的页面，这个页面只需要随便输入一个 token 名称即可，比如 pic 等，记得用英文，然后勾选下面的 repo 框就可以了，其余的不用选，然后点击最下方的绿色按钮就可以生成 token 了。


![](https://cdn.nlark.com/yuque/0/2020/png/159409/1584324593024-ff72bf72-d40b-44be-9f76-b984ef285c1a.png#align=left&display=inline&height=1106&margin=%5Bobject%20Object%5D&originHeight=1106&originWidth=1546&size=0&status=done&style=none&width=1546)


生成 token 后，这个 token 很重要，现在立即复制它（刷新就没有了，只能重新生成。），发送到自己手机上，这个信息配置 GitHub 图床时需要。


![](https://cdn.nlark.com/yuque/0/2020/png/159409/1584324593153-cde2d676-2014-455d-9148-15b1c1ead078.png#align=left&display=inline&height=272&margin=%5Bobject%20Object%5D&originHeight=272&originWidth=1512&size=0&status=done&style=none&width=1512)


### 在 PicPlus 中配置 GitHub 图床


通过软件中的侧滑菜单，找到图床列表，选择添加图床> Github 图床，如下所示：


![](https://cdn.nlark.com/yuque/0/2020/jpeg/159409/1602146930151-16856f22-f859-410e-aaa1-76c01657e9a7.jpeg#align=left&display=inline&height=1080&margin=%5Bobject%20Object%5D&originHeight=1080&originWidth=1080&size=0&status=done&style=none&width=1080)


如下所示：


![](https://cdn.nlark.com/yuque/0/2020/jpeg/159409/1602146997564-9bdf5948-1e8e-4166-81b2-7da3f1659338.jpeg#align=left&display=inline&height=1170&margin=%5Bobject%20Object%5D&originHeight=2340&originWidth=1080&size=0&status=done&style=none&width=540)


下面需要填入四项信息，假定现在已经完成了上面的注册，并获得了如下信息


- token：  xxxxxxxxxxxxxxx
- Github 用户名：gudong
- 仓库名称：pic
- 默认分支：main


如下所示，首行需要输入 token 字符串，接着输入 github 用户名，然后输入仓库名称，按照示例分别填入 `gudong` 跟 `pic` 就 OK，如下图所示：


![](https://cdn.nlark.com/yuque/0/2020/jpeg/159409/1602147105210-fc7f89b5-d1e0-4865-ab80-25aabd774cf4.jpeg#align=left&display=inline&height=1170&margin=%5Bobject%20Object%5D&originHeight=2340&originWidth=1080&size=0&status=done&style=none&width=540)


#### 关于存储路径


默认按照年月日的目录结构进行存储，比如今天是 2020年10月8号，那么上传后，图片将会存储在 2020/10/08/目录下。


你也可以自己指定目录进行固定位置的存储，需要关闭按年月日存储的开关，然后输入自己的目录名即可。


以上就是配置 PicPlus GitHub 图床的所有步骤，希望我说明白了。


如果在配置中还有什么问题，可以在酷安私信我，也可以发邮件(1252768410艾特qq.com)给我，说明具体情况，最好有截图，最后再次感谢你的使用。
