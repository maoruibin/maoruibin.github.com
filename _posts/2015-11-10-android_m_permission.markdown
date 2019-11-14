---
layout: post
author: 咕咚
title: "在Android 6.0 设备上动态获取权限"
description: ""
categories: tech
cover-color: "zzz"
tags:  Skills Usage
---
众所周知，Android 6.0 相比之前的Android版本有一个很大的不同点，就是动态获取权限。今天自己在做拨号功能时，正巧遇到这个问题，
顺手记录下在Android 6.0 上如何动态获取权限。

下面从自己一开始的问题入手

### 实现拨号功能

说到拨号，一个 Intent 就搞定，代码如下，

       private void callDirectly(String mobile){
            Intent intent = new Intent();
            intent.setAction("android.intent.action.CALL");
            intent.setData(Uri.parse("tel:" + mobile));
            mContext.startActivity(intent);
        }

当然 你可别忘了在 Manifest 文件中去声明拨号的权限

       <uses-permission android:name="android.permission.CALL_PHONE" />

### 问题

如果在 Android 6.0 以前的设备上，上面的代码都是没有问题的，但是如果是在 Android 6.0 设备上，并且项目的 targetSdkVersion 你设置的是23，那么
当你执行上面的拨号代码时，程序将会奔溃掉。

此时你肯定想到了 如果 targetSdkVersion 值设置的小于23是不是就不会奔溃了，恩，确实如此，
此时即使使用Android6.0的设备，程序也不会奔溃，原因显而易见，Android 的权限机制是 Android M 后才加入的。从 Android M 开始
应用程序申请的权限是在运行时动态赋给用户的。

关于动态分配权限，一些同学可能不是很清楚。这里稍稍提一下 Android 6.0 的[权限动态分配](#permission)。
如果你只对最终的解决方案感兴趣，可以跳过下面这节，直接去看[解决方案](#answer)

### <a name="permission">权限动态分配</a> ### 

在 Android6.0 之前，下载好一个应用程序，点击安装我们看到的大都是像这样的界面。

![permission](/assets/android_m_install.jpg "permission")

上图分别是Nexus6和小米手机在安装软件时的界面。

在安装时你会发现，手机操作系统会提示，这个软件会索要了你手机的那些权限，并且给用一个列表进行展示，但是这些提示只是在安装是提示，只要你点击接受或者安装，
表示你允许这个应用在可以获取它申明的所有权限。一般很少有人在安装时，会因为看到某个应用因为申请了某一个敏感权限而放弃安装应用。因为这个权限虽然敏感，
但是对于当前的用户是不可感知的，因为他现在并没有立即去查看你的最近通话、短信记录...

说到这里，我们自然而然的会想到，其实最好的方式是，当这个应用在用户使用过程中，正准备使用某个权限时，比如说读取短信列表，系统能及时的弹出一个提示框，说这个应用要读取您的短信内容，
您是否允许。然后用户结合当前应用的执行动作，依据当前条件判断，是不是应该授予应用读取短信记录的权限。这绝对的最完美的。
因为在具体的使用过程中，用户可以结合当前应用的使用场景，去思考、判断是不是应该给这个应用相应的权限。不给能怎样，给了会怎样，
这样对用户而言，完全是主动的，相比安装时那种选择，这样的做法无疑是对用户莫大的尊重，同时这也保证了用户的个人隐私。

说到这里，不得不插一句，其实 MIUI 早就实现了这个系统特性，在这一点上 MIUI 确实走到了 Android团队的前面，恩，给 MIUI 点个赞。

然而直到 Android 6.0 这个版本开始，上面的假设终于得到了谷歌的实践，除了在应用安装时，操作系统会提示应用会获取那些权限，在运行过程中，当应用去真的获取一些敏感
权限时，系统还会弹出一个提示框，询问用户是不是授予应用相应的权限。如下图所示。

![permission](/assets/android_m_sms.jpeg "permission")

这就是 Android 6.0 的运行时权限检查机制。下面是Google官方对此的解释，只截取介绍部分

`Beginning in Android 6.0 (API level 23), users grant permissions to apps while the app is running,
not when they install the app. This approach streamlines the app install process, since the user does
not need to grant permissions when they install or update the app. It also gives the user more control over
 the app's functionality; for example, a user could choose to give a camera app access to the camera but not
 to the device location. The user can revoke the permissions at any time, by going to the app's Settings screen.`

### <a name="answer">解决方案</a> ### 

其实上面已经说了一种取巧的方案，将 targetSdkVersion 设为小于23的值，程序将不会奔溃，
但是在Android 6.0 上你的应用程序依旧拨不了电话，这是真的。所以要想兼容6.0版本，必须通过下面的方式进行代码层面的兼容。

对Android版本做判断，然后对Android 6.0 做特殊处理，代码如下

     final public static int REQUEST_CODE_ASK_CALL_PHONE = 123;

     public void onCall(String mobile){
            this.mMobile = mobile;
            if (Build.VERSION.SDK_INT >= 23) {
                int checkCallPhonePermission = ContextCompat.checkSelfPermission(mContext,Manifest.permission.CALL_PHONE);
                if(checkCallPhonePermission != PackageManager.PERMISSION_GRANTED){
                    ActivityCompat.requestPermissions(mContext,new String[]{Manifest.permission.CALL_PHONE},REQUEST_CODE_ASK_CALL_PHONE);
                    return;
                }else{
                    //上面已经写好的拨号方法
                    callDirectly(mobile);
                }
            } else {
                //上面已经写好的拨号方法
                callDirectly(mobile);
            }
        }

此时，如果一个Android6.0的用户触发拨号动作，执行上面的代码，那么他将会看到一个很好看的MaterialDialog，如下图所示。

![permission](/assets/android_m_permission.jpeg "permission")

那么用户点击拒绝或者允许，我们怎么才能拿到回调呢，如果能拿到回调，我们就可以根据用户的选择来执行不同的操作了。

这里应该会看到在 ActivityCompat 的 requestPermissions 方法中，最后一个参数是一个requestCode，看到它自然而然想到了经常用到的onActivityResult，
这里当执行 ActivityCompat 的 requestPermissions 方法后有一个回调机制，需要我们在当前 Activity 中实现 onRequestPermissionsResult 这个方法，具体如下

        @Override
        public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
            switch (requestCode) {
                case REQUEST_CODE_ASK_CALL_PHONE:
                    if (grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                        // Permission Granted
                        callDirectly(mobile);
                    } else {
                        // Permission Denied
                        Toast.makeText(MainActivity.this, "CALL_PHONE Denied", Toast.LENGTH_SHORT)
                                .show();
                    }
                    break;
                default:
                    super.onRequestPermissionsResult(requestCode, permissions, grantResults);
            }
        }

这里会对提供了一个对用户点击做判断的入口，开发者可以根据 grantResults[0] 的类型，来判断用户点击的是允许还是拒绝，接着就可以执行相应的逻辑了。

###  有用的链接

关于AndroidM上权限的动态获取，这里只给出了一个最简单的示例，如果你还没有尽兴，那么下面这篇国外的博文，一定会让你满足。

[Everything every Android Developer must know about new Android's Runtime Permission](http://inthecheesefactory.com/blog/things-you-need-to-know-about-android-m-permission-developer-edition/en)

这篇英文博文内容很长、内容也比较多，十足的干货。您慢用~

后记：偶然发现已经有哥们把上面的这篇文章做了翻译，真是极好的，附上[翻译链接](http://jijiaxin89.com/2015/08/30/Android-s-Runtime-Permission/)，给翻译者同学点赞，辛苦！

另外，最近看到一个Github上的开源项目 [PermissionHelper](https://github.com/k0shk0sh/PermissionHelper) ，专门用于处理 Android 6.0 的权限兼容问题。
