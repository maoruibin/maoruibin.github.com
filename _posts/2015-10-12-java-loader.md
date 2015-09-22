---
layout: post
title: "Java类加载机制"
description: "AndroidStudio中使用build.gradle的最佳实践"
categories:
  - gradle
tags: [Java]
---
{% include JB/setup %}
#  Java类加载机制

###类的初始化以及在内存中的运行机制
首先通过一个示例来说明。定义一个Test类

    public class Test{

        //测试类Person
        class Person{
             public static int MAX_AGE = 100;
             public String name;
             public int age;
        }

        //主方法
        public static void main(String[]args){
             Person p1 = new Person();
             p1.name = “大虾”;

              System.out.println(“p1 name is “+p1.name);

             Person p2 = new Person();
             p2.name = “咕咚”;

             System.out.println(“p2 name is “+p2.name);

             System.out.println(“p1 max age “+Person.MAX_AGE);
        }
    }

运行上面的程序，没有问题，这里我们来分析一下，整个运行过程，以及对应对象的内存分配过程。
运行的第一步是先要编译。经过虚拟机编译，Test.java文件被编译为与平台无关的Test.class文件。然后运行。


虚拟机在运行任何一个.class文件时都需要经过加载、验证、准备、解析、初始化、使用以及卸载。但是并不是Test类在每次使用时，
都要经过这几个步骤，只有第一次使用时，才会经过加载、验证、准备、初始化这几个步骤。以后再次使用时，都是直接使用，无需执行初始化。

关于类加载的时机，虚拟机规定了只有四种情况下才会执行加载，这里说最常见的类加载时机—new
如上面：
Person p1 = new Person();
这里在虚拟机看到对Person进行了new的操作，会首先查看Person类是不是以前被加载过，如果没有，才会执行类加载。

就像我们经常开发的Android程序，最终我们的项目中会很成千上万个类。每次运行app，大概都会按照我们自己制定的跳转方式，从一个Activity跳转到另一个，当第一次跳转到我们的MainActivity，他会把MainActivity.class字节码加载到虚拟机，然后初始化，以后再次实例化这个类的时候，是不会重新加载的。
上面特意强调了类加载，这里我们说说，类加载都干吗了。

在类加载阶段，会在虚拟机的堆空间去实例化一个类对象。具体点，如上面的
