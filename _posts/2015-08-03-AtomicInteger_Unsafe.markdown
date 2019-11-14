---
layout: post
author: 咕咚
title:  "Unsafe 类介绍"
catalog:    true
tags: Java 线程
categories: tech 
---
这个类是用于执行低级别、不安全操作的方法集合。尽管这个类和所有的方法都是公开的（public），但是这个类的使用仍然受限，你无法在自己的java程序中直接使用该类，因为只有授信的代码才能获得该类的实例。
从上面的描述，可以了解到该类是用来执行较低级别的操作的，比如获取某个属性在内存中的位置，(在AtomicInteger中就用到了)不过一般人很少会有这样的需求。

今天在看AsynTask源码时，发现AsynTask中，他利用自己的ThreadFactory生成Thread时，用了AtomicInteger来生成对应的线程ID，如下：

```java
private static final ThreadFactory sThreadFactory = new ThreadFactory() {
    private final AtomicInteger mCount = new AtomicInteger(1);
    public Thread newThread(Runnable r) {
        return new Thread(r, "AsyncTask #" + mCount.getAndIncrement());
    }
};
```

然后看AtomicInteger的方法getAndIncrement（）

```java
/**
 * Atomically increments by one the current value.
 *
 * @return the previous value
 */
public final int getAndIncrement() {
    for (;;) {
        int current = get();
        int next = current + 1;
        if (compareAndSet(current, next))
            return current;
    }
}
  /**
 * Atomically sets the value to the given updated value
 * if the current value {@code ==} the expected value.
 *
 * @param expect the expected value
 * @param update the new value
 * @return true if successful. False return indicates that
 * the actual value was not equal to the expected value.
 */
public final boolean compareAndSet(int expect, int update) {
    return unsafe.compareAndSwapInt(this, valueOffset, expect, update);
}
```

关于AtomicInteger类的介绍可以看这篇[文章](http://localhost:4000/java/2015/08/03/AtomicInteger_Introduce/)。


这里我们看到最重要的一个类叫Unsafe

[Unsafe的源码](http://www.docjar.com/html/api/sun/misc/Unsafe.java.html)


```java
// setup to use Unsafe.compareAndSwapInt for updates
private static final Unsafe unsafe = Unsafe.getUnsafe();
```

上面这行代码是获取Unsafe实例的。一般情况下，我们是拿不到该类的实例的，当然jdk库里面是可以随意使用的。

```java
static {
  try {
    valueOffset = unsafe.objectFieldOffset
        (AtomicInteger.class.getDeclaredField("value"));
  } catch (Exception ex) { throw new Error(ex); }
}
```


上面这几行代码，是用来获取AtomicInteger实例中的value属性在内存中的位置。这里使用了Unsafe的objectFieldOffset方法。这个方法是一个本地方法， 该方法用来获取一个给定的静态属性的位置。


    public native long objectFieldOffset(Field f);
这里有个疑问，为什么需要获取属性在内存中的位置？通过查看AtomicInteger源码发现，在这样几个地方使用到了这个valueOffset值：




```java
public final void lazySet(int newValue) {
   unsafe.putOrderedInt(this, valueOffset, newValue);
}

public final void lazySet(int newValue) {
    unsafe.putOrderedInt(this, valueOffset, newValue);
}

public final boolean weakCompareAndSet(int expect, int update) {
    return unsafe.compareAndSwapInt(this, valueOffset, expect, update);
}
```

查找资料后，发现lazySet方法大多用在并发的数据结构中，用于低级别的优化。compareAndSet这个方法多见于并发控制中，简称CAS(Compare And Swap)，意思是如果valueOffset位置包含的值与expect值相同，则更新valueOffset位置的值为update，并返回true，否则不更新，返回false。

这里可以举个例子来说明compareAndSet的作用，如支持并发的计数器，在进行计数的时候，首先读取当前的值，假设值为a，对当前值 + 1得到b，但是+1操作完以后，并不能直接修改原值为b，因为在进行+1操作的过程中，可能会有其它线程已经对原值进行了修改，所以在更新之前需要判断原值是不是等于a，如果不等于a，说明有其它线程修改了，需要重新读取原值进行操作，如果等于a，说明在+1的操作过程中，没有其它线程来修改值，我们就可以放心的更新原值了。

Unsafe只有jdk库里的类才可以随意使用。对于我们一般是没法拿到实例的，但是要真要想拿到，也不是没有办法，比如用反射，至于他能做什么，看自己怎么用了

    Field f = Unsafe.class.getDeclaredField("theUnsafe"); // Internal reference  
    f.setAccessible(true);  
    Unsafe unsafe = (Unsafe) f.get(null);
