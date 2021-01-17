---
layout: mypost
author: 咕咚
title: "Android 自定义 Lint 研究"
author: gudong
tags:  技术
categories: tech
---

作为开发人员，我们的大部分时间都在跟代码打交道，而代码的世界中充满各种规则（语法规则、设计原则等），为了更好的编码，我们必须按照那些规则去书写代码。

但实际工作中，由于个人经验的欠缺或一时疏忽，总还是会写出有问题或者性能欠佳、不合规范的代码。

这里，我们分别看几段 Java 代码。

```java
public class SerializableParam implements Serializable {
    private String nName;
		//成员变量没有实现 Serializable，未来可能是一个隐患
    public AdInfo mAdInfo;

    public class AdInfo {}
}
```

> 上面的代码会有那些潜在的问题？

```java
public class DemoNewThread {
    public void exec(){
        // 企业项目中 如果大家都通过 new Thread 的方式去使用线程，有可能导致线程管理失控
        // 而且线程的创建需要资源申请，成本比较高，随意的创建线程可能导致 OOM 等程序不稳定的情况
        new Thread(new Runnable() {
            @Override
            public void run() {
							//耗时操作
            }
        }).run();
    }
}

```

> 生产项目中这样使用线程会有什么问题吗？


```java
public class DemoStacktrace {
    public void text(){
        try {
            int i = 10/0;
        } catch (Exception e) {
            //打印堆栈时需要去收集当前上下文日志，而且这个过程是阻塞主线程的
            //所以生成环境最好不要打印堆栈日志
            e.printStackTrace();
        } catch (Throwable t) {
            t.printStackTrace();
        }
    }
}
```

上面三段代码，各有其问题，但是很多时候，第一眼可能未必看出来，因为问题并不会每次都发生，一些问题，只有在特殊场景才会发生，但是从语法、最佳实践角度上，它们又存在100%出问题的概率。

比如第一个 `SerializableParam` 类，这个类第一眼完全没问题，编译没问题，运行也没有问题，但由于成员变量 `AdInfo` 没有实现 `Serializable` 接口，未来在一些页面跳转时，如果需要传递 `SerializableParam` 实例到其他页面，这时就会出现 crash，因为成员变量 `AdInfo` 没有实现 `Serializable` 接口。

```
java.lang.RuntimeException: Parcelable encountered IOException writing serializable object (name = com.***.***.***.k.g)
	at android.os.Parcel.writeSerializable(Parcel.java:1850)
	at android.os.Parcel.writeValue(Parcel.java:1797)
	at android.os.Parcel.writeArrayMapInternal(Parcel.java:945)
	at android.os.BaseBundle.writeToParcelInner(BaseBundle.java:1584)
	at android.os.Bundle.writeToParcel(Bundle.java:1253)
	at android.os.Parcel.writeBundle(Parcel.java:1014)
```

## 思考

如何提前发现问题？

- 严格代码 review 👁👁👁👁
- 杜绝使用 `Serializable`？😜
- 通过工具自动检查代码

第三种更可行，因为 AndroidStudio 已经提供了这样的工具 - **lint**。

# 什么是 Lint

> Lint 是 Android Studio 提供的代码扫描工具，可帮助您发现并更正代码结构质量的问题，而无需您实际执行应用，也不必编写测试用例。系统会报告该工具检测到的每个问题并提供问题的描述消息和严重级别，以便您可以快速确定需要优先进行的关键改进。
> from [通过 lint 检查改进代码  \|  Android 开发者  \|  Android Developers](https://developer.android.com/studio/write/lint?hl=zh-cn)

总结一下 Lint 就是：

- Android Studio 自带的代码扫描工具
- 无需执行代码，编码期间实时提示
- 支持 Java、Kotlin源文件、class 文件、资源文件以及 Gradle 文件的检查
- 具有可扩展性，可根据项目具体情况**自定义 lint 规则**
- 支持自动代码修复

Android Studio 本身已经提供了上百条 lint 规则，比如在 Manifest 文件中注册 Activity 时，如果重复注册 Activity，lint 就会进行报错提示：如下所示：

![](https://tva1.sinaimg.cn/large/0081Kckwly1gl2jli8jilj30ke07h0u0.jpg)

或者当我们定义了一个类成员变量，并且设置初始值，但是其他地方没有对这个变量进行其他赋值的操作，这时 AS 也会通过 lint 提示我们，最好把它设置为 final 类型，以达到一些优化效果，具体如下所示：

![](https://tva1.sinaimg.cn/large/0081Kckwly1gl2j7rh8h9j312o0deq5e.jpg)

以上两个示例，第一个报红了，代码会编译失败，项目不能跑起来，第二个没有报错，只是提示一下，项目可以正常运行。

上面这两个规则是 Android 提供的通用规则，它们有一个显而易见的好处：**编写代码时就可以实时提示错误。**

## 思考

Android 提供的原生 lint 机制可以在编码期间，就能对错误编码进行提示，那针对开篇提到的几个问题，如果也能有这种实时提示的机制，那么开发人员在编写实现了 Serializable 接口的类里，新增了一个没有实现 Serializable 接口的成员变量时，直接也能实时提示出错误，是不是就能很好的解决开发人员这个问题，避免页面进行数据传递时，发生 Crash。

经过调研，最终发现了可以通过自定义 Lint 的方式，实现上面的假设，最终效果如下所示：

![](https://tva1.sinaimg.cn/large/0081Kckwly1gl2m4zco6kj30lo05eaau.jpg)

# 自定义 Lint 

Lint 支持自定义，通过自定义，我们可以根据自己的需要，扩展已有的 lint 规则，自定义 Lint 的好处显而易见：

- 根据自己项目特点，灵活定制规则

- 规则可积累，形成长效的保障

随着不断发现问题，我们可以把能用 lint 解决的问题，都用规则编写出来，然后不断更新 lint 规则，这样可以确保同样的问题不会发生在第二个人身上。

## 如何自定义 Lint

lint 提供了几个关键的 api，每一个 lint 规则对应一个 Detector 的实现，比如要编写上文中提到的 Serializable 规则，我们需要新建一个 Detector，命名为 SerializableSubObjDetector，然后继承 Detector，并实现接口 Detector.UastScanner，然后就是规则的实现。核心代码如下所示：

```java
public class SerializableSubObjDetector extends Detector implements Detector.UastScanner {
  //定义 issue 
  public static final Issue ISSUE = Issue.create(
    "ClassSerializable",
    "对象类成员需要实现 Serializable 接口",
    "对象类成员需要实现 Serializable 接口",
    Category.SECURITY, 5, Severity.ERROR,
    new Implementation(SerializableSubObjDetector.class, Scope.JAVA_FILE_SCOPE));

  //具体检查代码时的判断逻辑
  @Override
  public void visitClass(JavaContext context, UClass declaration) {
    if (declaration instanceof UAnonymousClass) {
      return;
    }
    for (UField field : declaration.getFields()) {
      if (field instanceof JavaUField) {
        //检查当前成员变量是不是实现了 Serializable
        if (!isFieldImplSerializable(field)) {
          //如果没有实现，通过 context 来 report issue
          String fileType = field.getPsi().getType().getCanonicalText();
          context.report(ISSUE, context.getNameLocation(field), "成员变量 ".concat(fileType).concat(" 必须实现 Serializable"));
          return;
        }
      }
    }
  }
}
```

不同的规则，实现的方式各不一样。实现好之后，需要在一个注册器中进行注册。

注册器也是一个类，我们的自定义 lint 工程需要写一个自己的注册器，它只需要继承 Issue 框架的 IssueRegistry 就好，如下所示：

```java
public class CustomIssueRegistry extends IssueRegistry {
    @Override
    public int getApi() {
        return ApiKt.CURRENT_API;
    }
    @NotNull
    @Override
    public List<Issue> getIssues() {
        return Arrays.asList(
                LogDetector.ISSUE
                , SerializableSubObjDetector.ISSUE
        );
    }
}
```

完成后，还需要在 gradle 文件中对自定义的注册器进行关联，以便生成对应的 jar 文件

```
jar {
    manifest {
        attributes("Lint-Registry": "com.gudong.lintjar.CustomIssueRegistry")
    }
}
```

可以看到，上面最主要的逻辑就是 Detector，自定义 lint 规则大都是通过开发一个 Detector 来完成规则检查。

## 详解 Detector

Detector 是所有检查逻辑执行的地方，要定义一个 Detector，主要的步骤就那么几个，下面以上面说到的 Serializable 为例：


- 定义对应的 Issue 
- 通过复写方法设置关心的探测点
- 编写 lint 问题探测逻辑
- 发现问题，然后报告 issue 

其中理解 Detector 并不复杂，就是一个特定问题的检查器，它里面最主要的逻辑就是根据自己的需求去编写检查逻辑，只要检查到了问题，使用 context 去报告问题，就OK。

另外就是确定检查的时机，比如 Serializable 这种情形，检查的时机就是类的成员变量，具体可以通过复写 visitClass 方法，然后在这里进行逻辑检查：

```java
@Override
public void visitClass(JavaContext context, UClass declaration) {
  if (declaration instanceof UAnonymousClass) {
    return;
  }
  for (UField field : declaration.getFields()) {
    if (field instanceof JavaUField) {
      if (!isFieldImplSerializable(field)) {
        String fileType = field.getPsi().getType().getCanonicalText();
        context.report(ISSUE, context.getNameLocation(field), "成员变量 ".concat(fileType).concat(" 必须实现 Serializable"));
        return;
      }
    }
  }
}
```

而 Log 规则的编写（禁止项目中直接使用 Log 工具打印日志），就需要在复写方法调用的检查方法，也就是 visitMethodCall，如下所示：

```java
@Override
public void visitMethodCall(@NotNull JavaContext context,
                            @NotNull UCallExpression node,
                            @NotNull PsiMethod method) {
  if (context.getEvaluator().isMemberInClass(method, "android.util.Log")) {
    context.report(ISSUE, node, context.getLocation(node), "避免调用android.util.Log");
    System.out.println("========lint log");
  }
}
```

Detector 是所有检测器的父类，它里面还有很多这种回调，具体就需要根据自己需求去复写。

> 通过 Google 提供的 lint check 学习

# lint case 列举

除了上面列举的那几种 case，这里还有一些常见的case 比较符合 lint 检查：

- 调用 parserInt 等转换方法时，应该强制提示开发者使用 try catch 对代码进行包裹
- 项目中禁止使用 new Thread去创建线程，只要检查到 new Thread 这种样式的代码，提示开发者统一使用线程池
- equals 判断时，如果有常量，常量提前，防止变量调用 equals 时可能导致的空指针
- 复写方法父类方法是必须增加 Override 标识
- 多线程情况下操作 List 时，如果有 remove 或者 add 操作，使用 iterator
- 等等

我们可以思考归纳下，主要能解决的问题有那些：

##  Crash 预防：
* String 转其他类型时，字符串不符合类型
* Intent 传值时使用未序列化的对象
* map 做 get 操作时自动装箱空指针
* 多线程环境下操作 ArrayList 

##  安全&性能：
避免直接使用原生Toast、Log、Thread类，统一使用项目封装工具类；

##  代码规范：
资源命名必须满足约定好的正则表达式；比如 story 中的资源名称一定要以 story 开头。



# Lint 检查时机

- 编码时实时检查
- 代码运行通过 gradle 插件检查
- commit 时通过 git hook 检查
- 代码提交到 git 仓库后，通过 CI 自动检查



# 一些问题

lint 虽好，但是实践过程中，还是有不少问题。

##  API 文档

目前最新的 Scanner 是 UASTScanner，相比旧的 JavaPsiScanner 最大的优点是支持了 Kotlin，但缺点是没有文档，中文资料几乎为 0，所以开发时，很多方法只能去猜，很考验耐心。

## lint  版本

不得不说，一开始要跑起来 lint 的 demo 还挺费劲的，主要是相关文档太少了，而且没有官方文档，另外 Lint 版本与 gradle 版本强关联，如果 gradle 升级，lint 版本也要升级。

![](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2d56262b3ce3408daf71301bfca23808~tplv-k3u1fbpfcp-zoom-1.image)

## 如何 debug

在编写自定义规则时，我们可能需要进行调试，但是使用 system.out.print 是无效的，我们需要其他的手段进行日志输出（比如通过 context 把日志通过 report 打印到屏幕），或者使用单元测试，具体可以搜索 LintDetectorTest。

## 多项目配置

不同的项目，可能需要不同的规则，这就需要对自定义的 lint 规则库提出了更高的要求，这里仓库 [RocketZLY/AndroidLint](https://github.com/RocketZLY/AndroidLint) 提供了一种态配置的形式，可以参考一下。

# 总结

我们在编写的代码中有各种各样的问题，一些问题是业务逻辑问题，一些代码问题，而 lint 能覆盖到的问题只是一部分，但是 lint 的优势在于持续积累，如果规则库维护的好，随着项目的不断发展，lint 规则库会越来越完善，所以要想发挥 lint 的威力，需要团队有一致的认识，并不断执行下去。

# 参考资料

尽管目前 lint 资料比较少，但是还是搜索到了一些不错的资料，这里提供出来。


- [实际生产中的 Android Lint 实践分享](https://mp.weixin.qq.com/s/Rcsh4LV3nPbqJJub0XmYGA)

- [RocketZLY/AndroidLint](https://github.com/RocketZLY/AndroidLint)

- [美团外卖 Android Lint 代码检查实践 \- 美团技术团队](https://tech.meituan.com/2018/04/13/waimai-android-lint.html)

- [sollian/CustomLintRules: 自定义lint规则](https://github.com/sollian/CustomLintRules)

- [使用 Lint 进行代码检查・PPTing's Blog](https://ppting.me/2019/10/25/2019_10_26_lint_check_code/)

- http://tools.android.com/tips/lint-custom-rules


