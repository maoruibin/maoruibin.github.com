---
layout: post
author: 咕咚
title: "Android 开发中是否应该使用枚举？"
description: 在 Android 开发过程中，这个问题被很多次的提起，不少文章分析枚举的内存占用情况，后来在 Android 官方的内存优化文档中提出，不建议使用枚举，但是现在的官方文档却已将次建议删除，这背后都有哪些值得关心的东西呢？一起看看... 
qrcode_mp: true
tags: Java  优化 Android
categories: blog 
---


在 Android 官方文档推出[性能优化](https://developer.android.com/topic/performance/)的时候，从一开始有这样一段说明：

> Enums often require more than twice as much memory as static constants. You should strictly avoid using enums on Android.

意思是说在 Android 平台上**避免使用枚举 **，因为枚举类比一般的静态常量多占用两倍的空间。

由于枚举最终的实现原理还是类，在编译完成后，最终为每一种类型生成一个静态对象，而在内存申请方面，对象需要的内存空间远大于普通的静态常量，而且分析枚举对象的成员变量可知，每一个对象中默认都会有一个字符数组空间的申请，计算下来，枚举需要的空间远大于普通的静态变量。具体分析可见[这篇文章](https://www.liaohuqiu.net/cn/posts/android-enum-memory-usage/)。

所以，照此来看，在 Android 这样对内存寸土必争的平台上，如果只是使用枚举来标记类型，那使用静态常量确实更优，但是现在翻看官方文档发现，这个建议已经被删除了。（官方打脸 ???）

为什么官方会删除？难道是之前的建议有错误吗，或者描述的不够精确？

个人认为，枚举占用空间比普通类型的静态常量大，这是事实，没问题，但是据此就建议不在 Android 中使用时不妥的，具体看 JakeWharton 在 reddit 上的一个[评论](https://www.reddit.com/r/androiddev/comments/7so7ne/you_should_strictly_avoid_using_enums_on_android/?utm_source=share&utm_medium=web2x)

> The fact that enums are full classes often gets overlooked. They can implement interfaces. They can have methods in the enum class and/or in each constant. And in the cases where you aren't doing that, ProGuard turns them back into ints anyway.
>
> The advice was wrong for application developers then. It's remains wrong now.

最重要的一句是

> ProGuard turns them back into ints anyway.

他的意思是 Android 中，在开启 ProGuard 优化的情况下，枚举会被转为 int 类型，所以内存占用问题是可以忽略的。具体可参看 ProGuard 的优化列表页面 [Optimizations Page](http://proguard.sourceforge.net/manual/optimizations.html)，其中就有 enum 默认被优化的一项，如下所示：

> class/unboxing/enum
>
> Simplifies enum types to integer constants, whenever possible.

具体如何优化，没有时间继续研究了，但是 enum 被优化为 int 确实是事实了。

---

下面列举一些枚举的技术点，作为研究的记录和思考。

## 使用枚举

在没有枚举之前，定义不同类型，常常用静态变量进行定义，如下所示要定义颜色的类型：

```java
public static final int TYPE_RED = 100;
public static final int TYPE_BLACK = 101;
```

有了枚举之后，便可以像下面这样写

```java
enum Color{
    RED,
    BLACK
}
```

开始使用时两者区别并不大，如下所示，在其他类里有一个 draw 方法，需要传递颜色类型的参数进去，

```java
// 使用静态变量
void draw(int color){
   prepareDraw();
	if(color == TYPE_RED){
		 paint("#f00")
	}else if(color == TYPE_BLACK){
		paint("#000")
	}
  finishDraw();
}
//使用枚举
void draw(Color color){
  prepareDraw();
	if(color == RED){
		 paint("#f00");
	}else if(color == BLACK){
		paint("#000");
	}
  finishDraw();
}
```

初看，区别并不大，只是枚举看上去语义性更好，更容易阅读，这只是枚举的一点好处。

## 枚举的本质

实际上，枚举的背后是一个类，跟正常的对象一样，它支持构造方法、它可以实现接口、它可以继承抽象类，它就是普通的类，这里只是 Java 把这些都包装了起来，所有的枚举实例都继承自 Enum 这个抽象类，如下所示：

```java
public abstract class Enum<E extends Enum<E>> implements Comparable<E>, Serializable {
    private final String name;
	private final int ordinal;
}	
```

所以这里要明白一点，枚举拓展了类型，一般的普通常量就是一个常量，它没有方法，没有属性，是死的，但是枚举让类型活了，它让一个常量类型可以自己去控制一些行为，扩展了类型的边界，让它面向对象，具有了类的特性。比如现在就可以用枚举的特性去优化上面的代码。

我们可以使用枚举的构造方法在构造枚举时就指定颜色值，如下所示：

```java
enum Color{
    RED("#f00"),
    BLACK("#000")
    
    public String mValue;
    public Color(String value){
	    this.mValue = value
    }
}
```

于此同时，原来的 draw 方法就可以变得更加简洁：

```java
void draw(Color color){
	   prepareDraw();
		 paint(color.mValue);
     finishDraw();
}
```

另外，还可以更进一步，直接让枚举自己实现 paint 方法。

```java
enum Color{
    RED("#f00"),
    BLACK("#000")
    
    public String mValue;    
    public void draw(){
			paint(mValue)
    }
}
```

然后在调用处，直接调用枚举实例的方法即可，更加简洁。

这里已经可以看到枚举的便捷性了。它面向对象，以前很多使用静态常量的时候，好多 if  else 语句都可以更加友好的处理掉了，枚举还有其他好玩的地方，总之用它的时候，就把它当做一个正常的类，可以各种操作。

## 什么时候该用枚举

一般情况下，如果只是要用常量进行类型定义时，完全没必要用枚举，有点大材小用，比如要定义简单的类型：

```java
enum Type{
    Noraml,
    Big,
    Small
}
```

这种情况下用整形常量就够了，枚举只是让语义性变得更好。

而如果定义的常量类型有一些模板化操作的逻辑，就可以考虑用枚举，将模板方法实现在枚举中，从而简化自己的类型定义。

例如我之前开发过一个翻译软件-咕咚翻译，它支持不同的翻译引擎，每一个翻译引擎都自己的名称、请求路径以及对应的实体类，那么用枚举来定义翻译引擎的类型就最合适不过了，如下所示：

```java
public enum  ETranslateFrom {

  BAI_DU("百度","http://api.fanyi.baidu.com/", ApiBaidu.class),
  YOU_DAO("有道","http://fanyi.youdao.com/",ApiYouDao.class),
  JIN_SHAN("金山","http://dict-co.iciba.com/",ApiJinShan.class),
  GOOGLE("谷歌", "http://translate.google.cn/",ApiGoogle.class);


  public int index;
  public String name;
  public String url;
  public Class aqiClass;

  ETranslateFrom(String name,String url, Class aqiClass) {
    this.name = name;
    this.url = url;
    this.aqiClass = aqiClass;
  }
}
```

具体源码[地址](https://github.com/maoruibin/TranslateApp/blob/a87c3e07ab8c63db01a2f97dc679ab403296a5fa/app/src/main/java/name/gudong/translate/mvp/model/type/ETranslateFrom.java)

非常优雅，有木有~ 

另外在开发过程中，从思维上不要把枚举更静态常量挂钩，枚举有更广阔的使用场景，完全可以放开思路去用枚举。**任何有模板性质的类，都可以考虑用枚举**。

## 枚举的替代写法

如果整形静态常量看上去有点弱，那么 JDK 1.5 之后提供的自定义注解，这里可以用它去优化。通过自定义注解限定类型的可选值，如下所示，借助 IntDef 来定义类型自定义注解 Color.

```java
public class Main {
    @IntDef({RED, Black})
    @Retention(RetentionPolicy.SOURCE)
    public @interface Color{}

    public static final int RED = 0;
    public static final int GREEN = 1;
    public static final int YELLOW = 2;
}
```

那么后续在传参数时就可以用 Color 注解去限制参数的传入值。

```java
void paint(@Color int color){}
```

更多注解相关的介绍，看参看技术小黑屋的[这篇文章](https://droidyue.com/blog/2016/08/14/android-annnotation)。

## 枚举混淆注意事项

在开启混淆的情况下，如果不做任何 keep，ProGuard 会把枚举类的方法名进行混淆，而应用运行期间，枚举类有两个方法会被反射调用，所以在 Proguard 规则中需要对其进行保护，如下所示：

```
-keepclassmembers enum * {  
    public static **[] values();  
    public static ** valueOf(java.lang.String);  
}
```

## 总结

文章从官方文档的内存优化建议说起，枚举会被 ProGuard 优化为整形，所以它在内存方面的影响几乎可以忽略了。另外阐述了个人对枚举设计的理解，它是一个很好的设计，在特定的场景下，尤其是那种针对类型有模板化操作的的情况下，使用枚举可以让代码更优雅，另外也记录了枚举的替代写法以及混淆代码时枚举的注意事项。

## 关于作者

> 咕咚，Android 工程师，个人博客 [gudong.name](gudong.name)，公众号：咕喱咕咚

## 参考链接

* [Android 中的 Enum 到底占多少内存？该如何用？ \| Yet Another Summer Rain](https://www.liaohuqiu.net/cn/posts/android-enum-memory-usage/)
* [关于Java中枚举Enum的深入剖析 \- 技术小黑屋](https://droidyue.com/blog/2016/11/29/dive-into-enum/)
* [should-i-strictly-avoid-using-enums-on-android](https://stackoverflow.com/a/29972028/4318748)
* ["You should strictly avoid using enums on Android" : androiddev](https://www.reddit.com/r/androiddev/comments/7so7ne/you_should_strictly_avoid_using_enums_on_android/)

