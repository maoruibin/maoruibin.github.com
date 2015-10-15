---
layout: post
title: "深入理解Java中的static关键字"
description: "AndroidStudio中使用build.gradle的最佳实践"
categories:
  - gradle
tags: [Java,Static]
---
{% include JB/setup %}
#  深入理解Java中的static关键字

###  准备
不论是在自己的开发工作中还是在阅读别人的代码时，我们总会时不时的看到static这个关键字。
但是不知道有多少人把他的理解都停留在了最基础的表面。static修饰的成员变量是类成员变量，
static修饰的方法是类方法，类成员变量和类方法只能被类访问，而不能被类实例访问。

当然，上面说的没错，这些都是static最基础的理解，但是你对static的理解只限于此，
那么这样的理解就有点浅薄了，下面是自己看书后，对static更深入的理解，
如果有不对的地方，还请指正，欢迎拍砖。

###   介绍
static是Java提供的一个关键字，可用于修饰类（一般都用在修饰内部类。）、变量以及方法。因此也衍生出了一些和static相关的概念，
如静态成员变量、静态内部类，静态方法等。那么说到这里，就要想了，被static修饰的变量、方法到底和正常的变量、方法有什么区别。
如之前所说，这里再重复一遍

* 静态变量和方法可以直接被类对象访问，而普通变量和方法只能被类实例访问

现在问题来了，为什么静态变量可以被类对象访问，而普通变量却不可以。要解答这个问题，首先需要说明类的初始化以及在内存中的运行机制。

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


