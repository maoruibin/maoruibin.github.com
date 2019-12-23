---
layout: post
author: 咕咚
title: "Android 开发中是否应该使用枚举？"
description: 在 Android 开发过程中，这个问题被很多次的提起，不少文章分析枚举的内存占用情况，后来在 Android 官方的内存优化文档中提出，不建议使用枚举，但是现在的官方文档却已将次建议删除，这背后都有哪些值得关心的东西呢？一起看看... 
qrcode_mp: true
tags: Optimize Android Enum
categories: tech 
---

> 本文由咕咚发布在[个人博客](gudong.site/blog)，转载请注明出处。
>
> 本文永久地址：[https://gudong.site/2019/11/04/use-enum-or-not.html](https://gudong.site/2019/11/04/use-enum-or-not.html)

---

在 Android 官方文档推出[性能优化](https://developer.android.com/topic/performance/)的时候，从一开始有这样一段说明：

> Enums often require more than twice as much memory as static constants. You should strictly avoid using enums on Android.

意思是说在 Android 平台上 **avoid** 使用枚举，因为枚举类比一般的静态常量多占用两倍的空间（如果你还不了解枚举，参看文章 [枚举介绍以及枚举的本质](../../../2019/11/08/enum-introduce.html)。）

由于枚举最终的实现原理还是类，在编译完成后，最终为每一种类型生成一个静态对象，而在内存申请方面，对象需要的内存空间远大于普通的静态常量，而且分析枚举对象的成员变量可知，每一个对象中默认都会有一个字符数组空间的申请，计算下来，枚举需要的空间远大于普通的静态变量。具体分析可见[这篇文章](https://www.liaohuqiu.net/cn/posts/android-enum-memory-usage/)。

所以，照此来看，在 Android 这样对内存寸土必争的平台上，如果只是使用枚举来标记类型，那使用静态常量确实更优，但是现在翻看官方文档发现，这个建议已经被删除了。

为什么官方会删除？难道是之前的建议有错误吗，或者描述的不够精确？

个人认为，枚举占用空间比普通类型的静态常量大，这是事实，没问题，但是据此就建议不在 Android 中使用时不妥的，具体看 JakeWharton 在 reddit 上的一个[评论](https://www.reddit.com/r/androiddev/comments/7so7ne/you_should_strictly_avoid_using_enums_on_android/?utm_source=share&utm_medium=web2x)。

> The fact that enums are full classes often gets overlooked. They can implement interfaces. They can have methods in the enum class and/or in each constant. And in the cases where you aren't doing that, ProGuard turns them back into ints anyway.
>
> The advice was wrong for application developers then. It's remains wrong now.

最重要的一句是

> ProGuard turns them back into ints anyway.

**在开启 ProGuard 优化的情况下，枚举会被转为 int 类型**，所以内存占用问题是可以忽略的。具体可参看 ProGuard 的优化列表页面 [Optimizations Page](http://proguard.sourceforge.net/manual/optimizations.html)，其中就列举了 enum 被优化的项，如下所示：

> class/unboxing/enum
>
> Simplifies enum types to integer constants, whenever possible.

既然 ProGuard 会把枚举优化为整形，那是不是在 Android 中，就可以继续无所顾忌的使用枚举了呢？😊

**并不是！！！**

ProGuard 对枚举的优化有一定的限制条件，如果枚举类存在如下的情况，将不会有优化为整形，如下所示：

1. 枚举实现了自定义接口。并且被调用。
2. 代码中使用了不同签名来存储枚举。
3. 使用 instanceof 指令判断。
4. 在枚举加锁操作。
5. 对枚举强转。
6. 在代码中调用静态方法 valueOf 方法。
7. 定义可以外部访问的方法。

> 参考自：[ProGuard 初探 · dim's blog](https://dim.red/2019/01/28/proguard_exploration/)，另外，上面的这七种情况，我并没有找到官方的说明，如果有哪位读者知道，请在评论区里留下链接，谢谢啦~ 

也就是说，要保证枚举能被正常优化为整形，就要确保枚举足够简单，如下所示，这些情况下的枚举都是可以被优化的

```java
enum Color{
  Red,Black,Green
}
```

或者这样的

```java
enum Date {
  Sunday("星期日"), 
  Monday("星期一"), 
  Tuesday("星期二"), 
  Wednesday("星期三"), 
  Thursday("星期四"), 
  Friday("星期五"), 
  Saturday("星期六");

  public String value;

  private Date(String value) {
    this.value = value;
  }
}
```

但是再次查看那七条规则，会发现这几个规则几乎把枚举面向对象的特性都限制了，在这样的限制下，枚举好用的地方都将消失，失去了枚举的灵活性。

到这里就有点矛盾了，枚举很好用，ProGuard 也会对它进行优化，但是优化条件限制了我们更好的使用枚举，那我们应该怎么面对这种情况，我的几点建议：

* 对于简单的使用场景，比如 Color、Week 这种，枚举有更好的语义性，可以优先使用枚举。
* 一些时候使用枚举可能无法避免上面七种情况的，权衡易用性和性能以及使用场景，可以考虑继续使用枚举，因为枚举在有些时候确实让代码更简洁，更容易维护，牺牲点内存也无妨。

---

至于 Android 为什么会把那条优化建议删掉，我认为官方也是考虑到了枚举会被优化为整形这一点，所以才去掉的。

然后实际工作中具体怎么使用，官方就不在说  **”avoid“** 了，而是让开发者自行决定是不是使用枚举。

以上就是关于 [Android 开发中是否应该使用枚举？] 这个问题我的一些思考。



## 参考链接

* [Android 中的 Enum 到底占多少内存？该如何用？ \| Yet Another Summer Rain](https://www.liaohuqiu.net/cn/posts/android-enum-memory-usage/)
* [关于Java中枚举Enum的深入剖析 \- 技术小黑屋](https://droidyue.com/blog/2016/11/29/dive-into-enum/)
* [should-i-strictly-avoid-using-enums-on-android](https://stackoverflow.com/a/29972028/4318748)
* ["You should strictly avoid using enums on Android" : androiddev](https://www.reddit.com/r/androiddev/comments/7so7ne/you_should_strictly_avoid_using_enums_on_android/)
* [ProGuard 初探 · dim's blog](https://dim.red/2019/01/28/proguard_exploration/)

