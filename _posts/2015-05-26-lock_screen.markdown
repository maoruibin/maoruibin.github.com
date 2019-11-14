---
layout: post
author: 咕咚
title: Android设备上实现锁屏
catalog:    true
tags: Skills
categories: tech 
---
在Android设备上实现锁屏功能。

## 最终结果

点击主界面的锁屏按钮，实现立即锁屏

### 准备阶段

新建一个空的Android项目，并在主界面上拖放一个按钮。并在Button的布局文件中声明onClick事件。如下

    <Button android:text="锁屏"
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:onClick="lockScreen"/>    

在MainActivity.java文件中实现lockScreen方法。

### 实现步骤

1、创建一个空的广播接受者AdminManageReceiver.java

    import android.app.admin.DeviceAdminReceiver;
    public class AdminManageReceiver extends DeviceAdminReceiver {

    }

2、配置Manifest文件

        <receiver
            android:name=".AdminManageReceiver"
            android:label="@string/app_name"
            android:permission="android.permission.BIND_DEVICE_ADMIN" >
            <meta-data
                android:name="android.app.device_admin"
                android:resource="@xml/device_admin" />
            <intent-filter>
                <action android:name="android.app.action.DEVICE_ADMIN_ENABLED" />
            </intent-filter>
        </receiver>


3、新建文件device_admin.xml
AdminManageReceiver需要一个资源文件的支持，我们在res目录下面创建名为xml的文件夹，接着创建device_admin.xml文件，内容如下

    <device-admin xmlns:android="http://schemas.android.com/apk/res/android">
        <uses-policies>
            <force-lock />
        </uses-policies>
    </device-admin>

4、主逻辑的实现
    直接上MainActivity.java 代码如下

    public class MainActivity extends ActionBarActivity {
        ComponentName mAdminName;
        DevicePolicyManager mDPM;
        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            setContentView(R.layout.activity_main);
            mAdminName = new ComponentName(this, AdminManageReceiver.class);
            mDPM = (DevicePolicyManager) getSystemService(Context.DEVICE_POLICY_SERVICE);
            //如果设备管理器尚未激活，这里会启动一个激活设备管理器的Intent,具体的表现就是第一次打开程序时，手机会弹出激活设备管理器的提示，激活即可。
            if (!mDPM.isAdminActive(mAdminName)) {
                showAdminManagement(mAdminName);
            }
        }
        //执行锁屏
        public void lockScreen(View view){
            if (mDPM.isAdminActive(mAdminName)) {
                mDPM.lockNow();
            }
        }

        //激活设备管理器
        private void showAdminManagement(ComponentName mAdminName) {
            Intent intent = new Intent(DevicePolicyManager.ACTION_ADD_DEVICE_ADMIN);
            intent.putExtra(DevicePolicyManager.EXTRA_DEVICE_ADMIN, mAdminName);
            intent.putExtra(DevicePolicyManager.EXTRA_ADD_EXPLANATION, "activity device");
            startActivityForResult(intent,1);
        }
    }


Note:如果正常运行这个程序，并且按照要求激活了设备，那么在你要准备卸载程序时，需要去设备管理器先移除这个程序，才可以正常执行卸载。
