---
layout: post
author: 咕咚
title:  "AsyncTask 官方文档翻译（部分）"
description: "学习 AsyncTask "
qrcode_mp:  true
tags: Thread 
categories: tech 
---

这一篇文章主要记录 AsyncTask 相关的知识点。

> 大部分内容来自官方文档，[AsyncTask  \|  Android Developers](https://developer.android.google.cn/reference/android/os/AsyncTask#summary)

## 什么是 AsyncTask

通过使用 AsyncTask，我们可以正确、简单的在 UI 线程中操作耗时任务，并可以处理任务的进度以及任务结果。整个过程，我们不需要关心任何线程、Handler 相关的操作，它对它们进行了封装。//

AsyncTask 被设计为一个围绕线程和 Handler的帮助类，而用来处理任务，但它并不构成一个通用的线程框架。理想情况下，AsyncTask 应该用于短操作（最多几秒），如果线程需要长时间执行，强烈强烈建议使用 java.util.concurrent 包提供的各种 API，如 Executor、ThreadPoolExecutor 和 FutureTask。

> 检查为什么要短操作

AsyncTask 被设计为在后台执行任务，而在 UI 线程处理任务进度和任务结果。异步任务由3个泛型类型（称为Params、Progress和Result）和4个步骤（称为onPreExecute、doInBackground、onProgressUpdate 和 onPostExecute）定义。

## 任务执行顺序

从一开始，异步任务是在单个后台线程上串行执行的。从 Android DONUT（1.6） 版本开始，被设计为线程池执行模型，多任务可以并发执行，从 Android HONEYCOMB（3.0）版本开始，任务在单个线程上执行，**以避免由并行执行导致的常见应用程序错误。**

如果真的想要并行执行，应该使用线程池的 executeOnExecutor 方法。

> 也就是说 AsyncTask 不建议执行并行任务，它目前只支持任务串行操作，这样做的目的是为了保证多任务并行操作会导致的潜在问题。
>
> 就目前来看，Android 的主流版本已经是 5.0 以后的系统了，所以几乎可以不用关心因版本而异的执行顺序，开发中用到的 AsyacTask 都是串行执行的。