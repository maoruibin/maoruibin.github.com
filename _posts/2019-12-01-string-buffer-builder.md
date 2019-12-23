---
layout: post
author: 咕咚
title: "String、StringBuffer 和 StringBuilder 的区别"
description: "目前使用 String 直接进行加操作，已经被自动优化为 StringBuilder 形式了。"
categories: tech
tags: 细节
---


## String

字符串常量，一旦创建，不可改变。这里的不可改变指字符串对应堆内存，当我们执行字符串的加操作时，实际上是复制被加字符串的内容到新开辟的字符串空间中，原来的作废。

String 是线程安全的，String 类是 final 类，不可以被继承。

String 的长度是不变的，适用于少量的字符串操作。

## StringBuffer

字符串变量，长度可变，**线程安全**。适用于多线程下在字符缓冲区进行大量字符串操作

## StringBuilder

字符串变量，长度可变，**线程不安全**。适用于**单线程**下在字符缓冲区进行大量字符串操作

字符串操作在执行速度：StringBuilder > StringBuffer > String

## 源码分析

> 基于 Android SDK 26 版本分析


StringBuffer 与 StringBuilder 共同继承自 AbstractStringBuilder，二者基本的方法调用都是使用了父类的实现，子类只是简单包装了一下，区别在于，**StringBuffer 支持多线程，所以它的操作方法均是同步方法**。 这里使用 synchronized 关键字标记方法为同步方法，所以它的效率较低，因为调用同步方法时，首先要去获取同步锁。

```java
@Override
public synchronized StringBuffer append(String str) {
  toStringCache = null;
  super.append(str);
  return this;
}
```

AbstractStringBuilder 定义了一个字符数组用于进行所有的字符处理，

```java
/**
* The value is used for character storage.
*/
char[] value;
```

使用默认的构造方法时，会指定初始字符数组的大小为 16，如果构造时指定了初始的字符串，那么初始容量为字符串长度加 16。

```java
public StringBuffer(String str) {
	super(str.length() + 16);
	append(str);
}
```

### append 方法实现

append 支持空数据。执行该方法时，会首先检查 append 的值是否是 null，如果是，即参数值为 null，这时 AbstractStringBuilder 会把空值做特殊处理，最终在字符数组结尾追加 “null”。

```java
private AbstractStringBuilder appendNull() {
  int c = count;
  ensureCapacityInternal(c + 4);
  final char[] value = this.value;
  value[c++] = 'n';
  value[c++] = 'u';
  value[c++] = 'l';
  value[c++] = 'l';
  count = c;
  return this;
}
```

具体追加字符串时，先会根据要插入字符串的长度，对原来的字符容器进行扩容，然后巧妙的通过 String 的 getChars 方法进行数据拼接、追加。

```java
public AbstractStringBuilder append(String str) {
  if (str == null)
    return appendNull();
  int len = str.length();
  // 扩容
  ensureCapacityInternal(count + len);
  // 追加 str 到字符数组容器中，这里会把 str 追加到 value 数组中，count 原来字符的数量，在参数中是偏移的值，
  str.getChars(0, len, value, count);
  // 追加完成后，同步一下 count 的值
  count += len;
  return this;
}
```

getChars 的具体实现跟 System 的 arrayCopy 一样，都是 native 的实现。

### toString()

不论使用 StringBuffer 还是 StringBuilder，在构造、追加完成后，要使用字符串就必须调用 toString 方法，跟其他方法的调用不一样。它们的父类并没有提供统一的实现。

StringBuffer 自己做了优化，它定义了一个字符数组 toStringCache，在调用 toString 时，如果 toStringCache 已经有值，就简单包装返回，如下所示：

```java
@Override
public synchronized String toString() {
  if (toStringCache == null) {
    toStringCache = Arrays.copyOfRange(value, 0, count);
  }
  return new String(toStringCache, 0, count);
}
```

toStringCache 会在 StringBuilder 被修改时被置为 null。

```java
/**
 * A cache of the last value returned by toString. Cleared
 * whenever the StringBuffer is modified.
 */
private transient char[] toStringCache;
```

StringBuilder 的 toString 实现没有用到缓存机制，直接用 StringFactory 提供的工具方法把字符数组转化为字符串。

```java
@Override
public String toString() {
  if (count == 0) {
    return "";
  }
  // 也是一个 native 实现，实际上字符串的很多操作都是通过 native 操作完成
  return StringFactory.newStringFromChars(0, count, value);
}
```

## String 加操作

开发中如果字符串需要追加字符串，经常这样操作

```java
String content = "hello";
System.out.println(content+" world");
```

~~这里给该字符串添加上 world 时，也就是 String 在执行加操作时，首先会先开辟空间存储 world 这个字符串，然后再开辟空间将两个字符串拼接，也就是说，一个简单的拼接工作，String需要开辟三块空间来完成。~~

> 注意：以上是不准确的解释。


实际上上面说对了一半，在 Java 1.8 之前，确实是上面所说的那样，但是 1.8 之后优化了 String 的 加操作，在编译运行时会根据不同情况使用 StringBuilder 或者 StringBuffer  进行内部优化替换。这一点在 String 的源码注释中有说明：

![](https://cdn.nlark.com/yuque/0/2019/jpeg/159409/1572992596799-b72abd81-921f-47ff-840b-51e957da5572.jpeg#align=left&display=inline&height=109&originHeight=109&originWidth=587&size=0&status=done&width=587)

所以这样说来，平时为了使用方便，完全可以用 + 号进行字符串拼接了，没必要用 StringBuilder。这也是技术发展的趋势所在，好用、简单永远是主流。

## 总结

这篇文章从三者的区别说起，是一个经常面试时被问到的问题，后面主要分析了 StringBuilder 以及 StringBuffer 部分源码，算是学习研究。

说道最终的性能，经过优化的 String 其实跟 StringBuilder 一致，性能都不错，所以开发过程中没必要纠结用 String 还是 StringBuilder，但是前提是你要知道 String 被优化这个事。

## 关于作者

咕咚，Android 工程师，个人博客 [gudong.site](gudong.site)，公众号：咕喱咕咚
