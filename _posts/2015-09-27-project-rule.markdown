---
layout: post
author: 咕咚
title:  "我的Android项目开发规范（不断更新）"
description:  "AndroidStudio中使用build.gradle的最佳实践"
catalog:    true
tags: Collection
categories: tech 
---
代码永远写不完，但是写的时间久了，就应该形成自己的代码规范或者自己团队的规范，尽管一些规范已经形成于脑海，但是还是有必要记录下来。从现在开始，一点点积累开发规范。这里积累开发过程中所有的规范细节，尽可能详细。


### 类文件

### 项目目录结构

### 接口文件

### 命名规范

* id命名采用右侧格式 {view缩写}_{module_name}_{view的逻辑名称}
<table>
    <tr>
        <td>空间</td>
        <td>缩写</td>
    </tr>
    <tr>
        <td>LinearLayout</td>
        <td>ll</td>
    </tr>
    <tr>
        <td>RelativeLayout</td>
        <td>rl</td>
    </tr>
    <tr>
        <td>FrameLayout</td>
        <td>fl</td>
    </tr>
    <tr>
        <td>TextView</td>
        <td>tv</td>
    </tr>
    <tr>
        <td>EditText</td>
        <td>et</td>
    </tr>
    <tr>
        <td>Button</td>
        <td>btn</td>
    </tr>
    <tr>
        <td>ImageView</td>
        <td>iv</td>
    </tr>
    <tr>
        <td>ProgressBar</td>
        <td>pb</td>
    </tr>
    <tr>
        <td>Spinner</td>
        <td>spn</td>
    </tr>
    <tr>
        <td>ListView</td>
        <td>lv</td>
    </tr>
    <tr>
        <td>RecycleView</td>
        <td>rcv</td>
    </tr>
    <tr>
        <td>RadioButton</td>
        <td>rb</td>
    </tr>
    <tr>
        <td>CheckBox</td>
        <td>cb</td>
    </tr>
</table>

* 接口命名规范

    命名规则与类一样采用大驼峰命名法，多以able或ible结尾。例如：<br>
    interface Runable | interface Accessible
    自己定义的接口最好以I开头<br>
    接口中定义的方法以on开头，如onInit();

* 成员变量命名规范

    采用小驼峰命名法，以m开头。

* 临时变量命名
    使用标准的Java命名方法，不推荐使用Google的m命名法。例如：

    private String userName; 而不推荐使用 private String mUserName;

* 常量命名

    常量使用全大写字母加下划线的方式命名。例如：

    public static final String TAG = "tag";

* 控件实例命名

    类中控件名称必须与xml布局id保持一致(可以去掉{module_name})。例如:

    在布局文件中 Button 的id为: android:id="@+id/btn_pay"

    private Button mBtnPay;
* 方法命名规范

    动词或动名词，采用小驼峰命名法。例如：

    run(); | onCreate(); | syncProducts();

* 布局文件(Layout)命名规范

    全部小写，采用下划线命名法。其中{module_name}为业务模块或是功能模块等模块化的名称或简称。<br>
    对于小项目，可以不用使用module_name作为前缀。

    * activity layout： {module_name}_activity_{名称} 例如：

        user_activity_main.xml | user_activity_shopping.xml

    * fragment layout:{module_name}_fragment_{名称} 例如：

        user_fragment_main.xml | user_fragment_shopping.xml

    * Dialog layout: {module_name}_dialog_{名称} 例如：

        user_dialog_loading.xml

    * 列表项布局命名：{module_name}_list_item_{名称} 例如：

        user_listitem_customer.xml

    * 包含项布局命名：include_{名称} 例如：

        include_head.xml

    * adapter的子布局： {module_name}_item_{名称} 例如：

        user_item_order.xml

    * widget layout： {module_name}_widget_{名称} 例如：

        user_widget_shopping_detail.xml
