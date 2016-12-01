---
layout: post
author: 咕咚
title:  "Java 编译研究记录"
description: ""
catalog:    true
tags: Java
---

```java
public class Test{
  private int num = 10;

  public void mainTest(){
    System.out.println("num is "+num);
  }
}
```

```
maodeMacBook-Pro:java mao$ javap -c Test
Compiled from "Test.java"
public class Test {
  public Test();
    Code:
       0: aload_0
       1: invokespecial #1                  // Method java/lang/Object."<init>":()V
       4: aload_0
       5: bipush        10
       7: putfield      #2                  // Field num:I
      10: return

  public void mainTest();
    Code:
       0: getstatic     #3                  // Field java/lang/System.out:Ljava/io/PrintStream;
       3: new           #4                  // class java/lang/StringBuilder
       6: dup
       7: invokespecial #5                  // Method java/lang/StringBuilder."<init>":()V
      10: ldc           #6                  // String num is
      12: invokevirtual #7                  // Method java/lang/StringBuilder.append:(Ljava/lang/String;)Ljava/lang/StringBuilder;
      15: aload_0
      16: getfield      #2                  // Field num:I
      19: invokevirtual #8                  // Method java/lang/StringBuilder.append:(I)Ljava/lang/StringBuilder;
      22: invokevirtual #9                  // Method java/lang/StringBuilder.toString:()Ljava/lang/String;
      25: invokevirtual #10                 // Method java/io/PrintStream.println:(Ljava/lang/String;)V
      28: return
}
```

```
public class Test{
  private int num = 10;
  private static final int num11 = 11;

  public void mainTest(){
    System.out.println("num is "+num);
    System.out.println("num11 is "+num11);
  }
}
```

```
Compiled from "Test.java"
public class Test {
  public Test();
    Code:
       0: aload_0
       1: invokespecial #1                  // Method java/lang/Object."<init>":()V
       4: aload_0
       5: bipush        10
       7: putfield      #2                  // Field num:I
      10: return

```

```java
public class Test{
  private int num10 = 10;
  private static final int num11 = 11;
  private static int num12 = 12;

  public void mainTest(){
    System.out.println("num10 is "+num10);
    System.out.println("num11 is "+num11);
    System.out.println("num12 is "+num12);
  }
}
```

```
maodeMacBook-Pro:java mao$ javap -c Test
Compiled from "Test.java"
public class Test {
  public Test();
    Code:
       0: aload_0
       1: invokespecial #1                  // Method java/lang/Object."<init>":()V
       4: aload_0
       5: bipush        10
       7: putfield      #2                  // Field num10:I
      10: return
```

static 静态变量不会出现在 Java 字节码。