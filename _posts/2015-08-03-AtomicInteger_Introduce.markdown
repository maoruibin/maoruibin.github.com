---
layout: post
author: 咕咚
title: "AtomicInteger 一个和高并发有关的工具类"
catalog:    true
tags:  Java 线程
categories: tech 
---
AtomicInteger，一个提供原子操作的Integer的类。在Java语言中，++i和i++操作并不是线程安全的，在使用的时候，不可避免的会用到synchronized关键字。而AtomicInteger则通过一种线程安全的加减操作接口。


使用AtomicInteger是非常的安全的
那么为什么不使用记数器自加呢，例如count++这样的，因为这种计数是线程不安全的，高并发访问时统计会有误，而AtomicInteger为什么能够达到多而不乱，处理高并发应付自如呢？
这是由硬件提供原子操作指令实现的。在非激烈竞争的情况下，开销更小，速度更快。Java.util.concurrent中实现的原子操作类包括：
AtomicBoolean、AtomicInteger、AtomicLong、AtomicReference。
