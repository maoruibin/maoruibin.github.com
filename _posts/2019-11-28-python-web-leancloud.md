---
layout: post
author: 咕咚
title: "网络编程  / Flask / LeanCloud"
description: 该文主要分享 Python 网络编程的一些介绍，自己开始学 Python 是从廖雪峰老师的在线教程开始，非常感谢老师的教程。文章后面分享到了 LeanCloud，这是一个对前端开发者特别友好的服务，非常值得一试。
tags: leancloud  share
categories: tech 
---

> 该文章为内部技术分享笔记记录，前半部分参考 [web 开发-廖雪峰](https://www.liaoxuefeng.com/wiki/1016959663602400/1017804650182592)，感谢老师的在线课程。

该文主要分享 Python 网络编程的一些介绍，自己开始学 Python 是从廖雪峰老师的在线教程开始，非常感谢老师的教程。文章后面分享到了 LeanCloud，这是一个对前端开发者特别友好的服务，非常值得一试，自己有一个在线服务就是部署在 LeanCloud 上面，柳叶清单，这是一个网页 Todo 应用，整个 todo 服务使用 LeanCloud 做后端数据引擎，使用云引擎开发网络 API，非常方便，感谢 LeanCloud。

## 网络编程/通信

实际生活中我们用的大部分程序都是网络程序，很少一部分是完全的单机离线程序。

计算机网络把所有的计算机连接在一起，在这个网络中的计算机可以互相通信，**网络编程就是解决两台计算机之间的通信问题。**

比如现在打开网页访问微博网页，实际上就是我们的浏览器跟微博的某台服务器通过互联网连接了起来，然后微博服务器把网页内容作为数据返回，通过网络传输到我们自己的电脑。

实际上每台计算机上的程序很多，不同程序访问的网络服务器不一样，所以更确切的说，**网络通信是两台计算机上两个进程之间的通信。**

网络编程对所有开发语言都一样，Python 也是如此，用 Python 进行网络编程时，Python 程序就在这个进程内，然后跟服务器进程的通信端口进行通信。

## 通信协议

一开始的计算机网络，各个厂商都有自己的一套协议，互不兼容，接着为了让大家都可以连接在一起，IBM、Apple 等大厂一起制定了一套全球通用协议，现在互联网上有上百种协议，最重要的是 TCP/IP  协议

IP 协议负责把数据从一台计算机通过网络发送到另一台计算机，数据会被分割为一小块一小块然后通过路由器发送出去，IP 包的特点是按块发送，途径多个路由，但是不能保证到达，更不能保证顺序到达。

TCP 协议建立在 IP 协议之上，它负责在两台计算机之间建立可靠连接，保证数据包顺序到达，具体 TCP 协议会通过三次握手建立连接，然后对每个 IP 包编号，确保对方顺序收到。

TCP 建立的是可靠连接，而且通信上方都可以以流的形式发送数据，相比 TCP，UDP 则是面向无连接的协议，使用 UDP 时，需要建立连接，只要知道对方的 ip 端口号，就可以直接发送包，到时能不能到达不确定

优点，速度快，对于不要求可靠性的请求，使用 UDP。

一个 TCP 报文包括

* 源 IP 地址 
* 目标 IP 地址
* 源端口
* 目标端口

## Python Web 开发

### 什么是 Web 开发

一般的，浏览器请求一个服务器地址，服务器把网页的 HTML 代码发给浏览器，浏览器显示处理，而浏览器/客户端跟服务器之间的传输协议是 Http 协议，它是 TCP 协议之上的协议。

* HTML 是一种定义网页的文本，使用它就可以开发网页了
* Http 协议是网络上传输 html 的协议，实际上他可传输很多网络文件，Http 协议用于浏览器跟服务器的通信。

Http 协议简单了说，就是请求跟响应，这个如果经常用 Charles 抓包应该很了解，这里使用 Chrome 的开发者工具，在线再次验证一下 Http 请求的过程:

![](https://tva1.sinaimg.cn/large/006y8mN6ly1g9e09zf3oej31bc0iotai.jpg)

Http1.1 跟 1.0 的区别是 1.1 允许多个 Http 请求复用一个 TCP 连接，用来加快传输速度。

### Http 请求过程

Web 开发的基础协议是 Http 协议，

* 浏览器发送一个 HTTP 请求；
* 服务器收到请求，生成一个 HTML 文档；
* 服务器把HTML文档作为 HTTP 响应的 Body 发送给浏览器；
* 浏览器收到HTTP响应，从HTTP Body 取出 HTML 文档并显示。

### Python web 开发

Python 定义了一套 WSGI 接口，只要实现这个 application 接口就可以处理网络请求，

```python
def application(environ, start_response):
    """
   	接口实现
    :param environ:  一个包含所有HTTP请求信息的dict对象；
    :param start_response:  一个发送HTTP响应的函数。
    :return: 
    """
    start_response('200 OK', [('Content-Type', 'text/html')])
    return [b'<h1>Hello, web!</h1>']
```

然后只需要一个 WSGI 服务器就可以运行这个 application，这也是一个标准，只要实现了 WSGI 服务器标准就可以执行 WSGI 接口，Python 内置了一个服务器实现 - wsgiref，具体使用如下所示：

```python
# 从wsgiref模块导入:
from wsgiref.simple_server import make_server
# 导入我们自己编写的application函数:
from hello import application

# 创建一个服务器，IP地址为空，端口是8000，处理函数是application:
httpd = make_server('', 8000, application)
print('Serving HTTP on port 8000...')
# 开始监听HTTP请求:
httpd.serve_forever()
```

执行运行，访问 8000 端口根目录既可看到 Hello web！字样，这就是一个最简单的 Python Web 程序。

## Flask Web 框架

上面的程序有很大的限制

* 当请求变多，application 方法将无法维护，application 中会出现很多的 if else 判断，无法维护
* html 代码不能复杂，真正使用时，这样讲无法处理复杂网页

所以就有了 Flask 开发框架，它通过路由、模板引擎成功解决了上面的问题，实际上类似的框架还有不少。

> pip install flask

具体看代码就可以知道 Flask 如何解决问题：

```python
from flask import Flask, request, render_template

app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def home():
    return render_template('home.html')

@app.route('/login', methods=['GET'])
def login_form():
    return render_template('form.html')

@app.route('/login', methods=['POST'])
def login():
    username = request.form['username']
    password = request.form['password']
    if username == 'admin' and password == 'password':
        return render_template('login-ok.html', username=username)
    return render_template('form.html', message='Bad username or password', username=username)

if __name__ == '__main__':
    app.run()

```

以上通过 `@app.route` 成功解决路由问题，使用 `render_template`成功解决 html 组织问题，`render_template` 接受两个参数，第一个参数是 HTML 文件名，这个文件必须存在根目录 `templete` 下，第二个参数是模板数据，可选，如果需要动态展示数据，可以传入，如下所示：

```python
return render_template('todos.html', todos=todos)
```

以上指定了模板和数据，我们查看模板文件

```html
<!DOCTYPE HTML>
<html>
  <head>
    <title>todos</title>
    <link rel="stylesheet" href="/static/style.css" type="text/css">
  </head>
  <body>
    <div id="container">
      <h1>{{ title }}</h1>
      <form action="/todos" method="POST">
        <input type="text" name="content" />
        <input type="submit" value="新增" />
      </form>
      <ul>
        {% for todo in todos %}
        <li>{{ todo.get('content') }}</li>
        {% endfor %}
      </ul>
    </div>
  </body>
</html>

```

这就是一个简单的 Flask 程序。

但是可以看到，使用了 Flask 我们的数据还是没法存储，这样的 Python Web 程序算不上真正的 Web 程序，一个 Web 程序需要有后端数据支持才行。

## LeanCloud 后端云

这是国内一个后端云服务商，让我们可以之关系业务逻辑实现，后端数据存储、程序部署等操作，它都统一处理，不需要我们关心，这大大减少了我们的开发维护工作。

它提供了一个云引擎，支持各种主流语言，我们可以选择自己的语言进行后端逻辑处理，它负责存储以及服务部署、运行，对开发者非常友好，具体可查看[官方文档](https://leancloud.cn/docs/leanengine_quickstart.html)。

使用它，我们可以快速开发一个个人的 Web 程序。

## 链接

* [web 开发-廖雪峰](https://www.liaoxuefeng.com/wiki/1016959663602400/1017804650182592)
* [Flask 框架](https://dormousehole.readthedocs.io/en/latest/)
* [后端云 LeanCloud](www.leancloud.cn)