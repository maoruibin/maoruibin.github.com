---
layout: post
author: 咕咚
title: "枚举介绍以及枚举的本质"
description: 枚举是 JDK  1.5 推出的 API，以前经常用静态常量用作类型区分，枚举则是对类型的一种强化，且有更好的语义性，恰当的使用它可以写出非常优雅的代码。
qrcode_mp: true
tags: Java Enum
categories: tech 
---

枚举是 JDK  1.5 推出的 API，以前经常用静态常量用作类型区分，枚举则是对类型的一种强化，且有更好的语义性，恰当的使用它可以写出非常优雅的代码。

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

## Android 中是否应该使用枚举

这曾是一个谈论很多的话题，对此我写了一篇文章分享自己的观点，具体查看 [Android 开发中是否应该使用枚举？ \| 咕咚](../../../2019/11/04/use-enum-or-not.html)

## 总结

本文阐述了个人对枚举设计的理解，它是一个很好的设计，在特定的场景下，尤其是那种针对类型有模板化操作的的情况下，使用枚举可以让代码更优雅，另外也记录了枚举的替代写法以及混淆代码时枚举的注意事项。



## 参考链接

* [Android 中的 Enum 到底占多少内存？该如何用？ \| Yet Another Summer Rain](https://www.liaohuqiu.net/cn/posts/android-enum-memory-usage/)