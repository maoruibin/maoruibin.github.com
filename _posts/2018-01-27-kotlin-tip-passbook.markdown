---
layout: post
author: 咕咚
title: "应用开发过程中的一些 Kotlin 语法点记录"
description: 应用开发过程中的一些 Kotlin 语法点记录
catalog: true
cover-color: "#e5893a"
shang: true
qrcode_mp: true
tags: Kotlin 
categories: tech 
---

最近在开发一个小应用密码本，开发的目的是自己确实有存储密码的需要，同时还有更重要的目的便是学习使用 `Kotlin`。

最近已经把基本的功能都开发完成了，包括指纹验证登录、手势登录以及最重要的密码条目存储，本地数据库使用 `Room`。

下面是使用 Kotlin 过程中的一些积累点滴，如果有什么错误的地方，欢迎指正。另外，如果你对这个密码本感兴趣，不论是对开发感兴趣，还是对这个产品感兴趣，均可以通过最下方的联系方式联系到我。

### 通过 Kotlin 为 View 设置回调事件

在 `Java` 中通过如下方式设置

```java
btnView.setOnClickListener(new View.OnClickListener() {
    @Override
    public void onClick(View v) {
        //todo
    }
});
```

在 `Kotlin` 中可以直接通过 `lambda` 表达式，如下所示

```kotlin
btnView.setOnClickListener({
    //todo
})
```

也可以省略括号直接使用如下简写方式

```kotlin
btnView.setOnClickListener {
	// todo
}
```

如果在回调中需要使用 `view` 参数，可以通过如下方式

```kotlin
btnView.setOnClickListener { view ->
  	view.visibility = View.VISIBLE
}
```



### Kotlin 接口中有多个接口方法需要实现

如下有一个接口

```java
public interface OnTaskSwitchListener {
  
    void onTaskSwitchToForeground(Activity topActivity);

    void onTaskSwitchToBackground(Activity topActivity);
}
```

对应有一个 set 方法

```java
public void setOnTaskSwitchListener(OnTaskSwitchListener listener) {
    mOnTaskSwitchListener = listener;
}
```

在 kotlin 中如何使用 set 方法，如下所示

```kotlin
taskSwitch?.setOnTaskSwitchListener(object : BaseTaskSwitch.OnTaskSwitchListener{
    override fun onTaskSwitchToBackground(activity: Activity) {
        Log.d("88888","到后台")
    }

    override fun onTaskSwitchToForeground(activity: Activity) {
        Log.e("88888","到前台")
    }
})
```

refer to http://blog.csdn.net/afanyusong/article/details/77866953

### Kotlin 使用 Intent 跳转

```kotlin
val editorIntent = Intent(this, EditorActivity::class.java)
editorIntent.putExtra("pass", entity)
startActivity(editorIntent)
```

如果是在内部类中，不能直接拿到 `this`,使用下面的方式

```kotlin
val editorIntent = Intent(this@MainActivity, EditorActivity::class.java)
editorIntent.putExtra("pass", entity)
this@MainActivity!!.startActivity(editorIntent)
```

### Kotlin 中使用 AlertDialog

使用 Java 生成一个 AlertDialog

```java
new AlertDialog.Builder(this)
        .setTitle("提示")
        .setMessage("你好，世界")
        .setPositiveButton("确定", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                
            }
        })
        .show();
```

Kotlin 中如下所示

```kotlin
val msg = "你好世界"
AlertDialog.Builder(holder.itemView.context)
        .setMessage(msg)
        .setTitle(item.name)
        .setPositiveButton("复制", DialogInterface.OnClickListener { dialogInterface, i ->
            copyText(holder.itemView.context, item.value)
            Toast.makeText(holder.itemView.context, "复制成功", Toast.LENGTH_SHORT).show()
        })
        .setNeutralButton("取消", null)
        .create()
        .show()
```

另外，在给`PositiveButton`设置点击回调时，使用了 lambda 表达式，这里的 `dialogInterface` 和`i`两个参数均没有使用，在 AndroidStudio 3.0 中会提示可以用 _ 代替，修改后如下所示：

```kotlin
val msg = "你好世界"
AlertDialog.Builder(holder.itemView.context)
        .setMessage(msg)
        .setTitle(item.name)
        .setPositiveButton("复制", DialogInterface.OnClickListener { _, _ ->
            copyText(holder.itemView.context, item.value)
            Toast.makeText(holder.itemView.context, "复制成功", Toast.LENGTH_SHORT).show()
        })
        .setNeutralButton("取消", null)
        .create()
        .show()
```

当然，如果要使用，就不要这么简写了。

### Kotlin 中使用 AlertListDialog

如下所示的 dialog 经常看到

![](https://ws1.sinaimg.cn/large/006tKfTcly1fnv4k8ipnej30go0tngm1.jpg)

实现如下所示：

```kotlin
val list = Array(1, { "打开应用","卸载应用","查看详情","去市场查看" })
android.support.v7.app.AlertDialog.Builder(this).setItems(list, DialogInterface.OnClickListener { _, i ->
    when (i) {
        0 -> {
          Log.d(TAG,"open");
        }
        1 -> {
          Log.d(TAG,"uninstall");
        }
        2 -> {
          Log.d(TAG,"detail");
        }
        3 -> {
          Log.d(TAG,"watch");
        }      
    }
}).create().show()
```

### Kotlin 中强转类型

`Java` 中的类型强转如下所示

```java
Entity entity = (Entity)getIntent().getSerializableExtra("entity");
```

在 `Kotlin` 中可以用更优雅的形式

```kotlin
manager = this.getSystemService(Context.FINGERPRINT_SERVICE) as FingerprintManager
key = keyStore.getKey(KEY_STORE_ALIAS, null) as SecretKey
```



### Kotlin 设置静态变量提供给其他类使用

Java 中这样
```java
public static final int buttonGravity = 120;
```

```kotlin
class Test{
    companion object {
        val buttonGravity = 120
    }
}
```
使用
```kotlin
var value = Test.buttonGravity
```



## 关于作者

> - 邮箱 - <gudong.site@gmail.com>
> - 微博 - [大侠咕咚](https://weibo.com/maoruibin)
> - 知乎 - [咕咚](https://www.zhihu.com/people/maoruibin/activities)
> - Github - [咕咚](https://github.com/maoruibin)



