---
layout: post
title: 在流式布局中使用PopupMenu，以及遇到的问题
categories:
  - Android
tags: [PopupMenu]
---
在做App+项目的过程中，因为每个Item上面都有一个PopupMenu，但是当时在xml文件中设置icon后，却发现icon不生效，下面是这个问题的解决方案。

自从MaterialDesigner出现后，像下图所示的设置流式布局随处可见。
  
  

![常见的流式布局]({{ site.url }}/assets/themes/dbyll/img/QQ20150718-1@2x.png "sss")
  

其中每个Item上都有一个OverFlow(更多)的icon，点击会弹出一个菜单，实现方式很简单，首先在meun文件中，新建一个menu文件，如下所示

src/main/res/menu/item_pop_menu.xml

    <?xml version="1.0" encoding="utf-8"?>
    <menu xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:app="http://schemas.android.com/apk/res-auto">
        <item
            android:title="@string/menu_pop_item_file"
            android:icon="@drawable/ic_launcher"
            android:id="@+id/pop_file"/>
        <item
            android:title="@string/menu_pop_item_share"
            android:icon="@drawable/ic_launcher"
            android:id="@+id/pop_share"/>
    </menu>                                                                    

  

然后在对应List的Adapter中处理那个OverFlow(更多)按钮的点击事件，如下所示
  

    /**
     * 在ancho旁边显示菜单
     * @param ancho 触发PopupMenu的View 
     */ 
    private void showPopMenu(View ancho) {  
        PopupMenu popupMenu = new PopupMenu(mContext,ancho);
        popupMenu.getMenuInflater().inflate(R.menu.item_pop_menu,popupMenu.getMenu());
        //menu item的点击事件监听
        popupMenu.setOnMenuItemClickListener(new PopupMenu.OnMenuItemClickListener() {
                @Override
                public boolean onMenuItemClick(MenuItem item) {
                    //switch判断 
                }
            });
        }
        //显示弹出式菜单
        popupMenu.show();
  

程序运行后，点击OverFlow确实会弹出菜单，但是却发现，没有显示出设置好的icon,如下图
  

![bug]({{ site.url }}/assets/themes/dbyll/img/QQ20150718-2@2x.png "bug")
  

其中不显示的原因在于，popupMenu本身是不能设置显示icon的，控制icon的显示是MenuPopupHelper这个类要做的事，但是又不能直接通过popupMenu得到MenuPopupHelper的实例，所以我们只能使用反射，如下所示，最终问题完美解决
  

    /**
     * 在ancho旁边显示菜单
     * @param ancho 触发PopupMenu的View 
     */ 
    private void showPopMenu(View ancho) {  
        PopupMenu popupMenu = new PopupMenu(mContext,ancho);
        popupMenu.getMenuInflater().inflate(R.menu.item_pop_menu,popupMenu.getMenu());
        //menu item的点击事件监听
        popupMenu.setOnMenuItemClickListener(new PopupMenu.OnMenuItemClickListener() {
                @Override
                public boolean onMenuItemClick(MenuItem item) {
                    //switch判断 
                }
            });
        }
        
        //通过反射获取MenuPopupHelper实例，然后设置setForceShowIcon为true
        try {
            Field mFieldPopup=popupMenu.getClass().getDeclaredField("mPopup");
            mFieldPopup.setAccessible(true);
            MenuPopupHelper mPopup = (MenuPopupHelper) mFieldPopup.get(popupMenu);
            mPopup.setForceShowIcon(true);
        } catch (Exception e) {
            
        }
        
        //显示弹出式菜单
        popupMenu.show();
  

![bug]({{ site.url }}/assets/themes/dbyll/img/QQ20150718-3@2x.png "bug suc")
  
  





            
有用的帮助信息
[stackOverFlow page](http://stackoverflow.com/questions/6805756/is-it-possible-to-display-icons-in-a-popupmenu/31490355#31490355)









