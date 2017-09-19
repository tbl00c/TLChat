# TLTabBarController

全能tabBarController，实现大多常用功能，如红点、仅图片、突出的tabBarItem、双击事件等。

基于系统原生控件封装，完美支持“系统设置-辅助功能-按钮形状”模式，切换零成本。

## 功能

### 1、气泡支持红点（如微信）

<img src='Screenshots/TLTabBar_Badge.gif' width = "375" height = "667" alt="badge" align=center />



```
// 设置气泡颜色
[vc.tabBarItem setBadgeColor:[UIColor redColor]];

// 显示气泡，空字符串显示为小圆点
[vc.tabBarItem setBadgeValue:@"new"];
[vc.tabBarItem setBadgeValue:@""];

// 隐藏气泡
[vc.tabBarItem setBadgeValue:nil];
```

### 2、tabBarItem仅图片

<img src='Screenshots/TLTabBar_ImageOnly.gif' width = "375" height = "667" alt="bar image" align=center />


```
不设置vc.tabBarItem.title时，仅显示图片，且自动居中
```

### 3、凸出的tabBarItem（如转转发布按钮，支持任意个）

<img src='Screenshots/TLTabBar_Publish.gif' width = "375" height = "667" alt="publish" align=center />

```
UITabBarItem *addItem = [[UITabBarItem alloc] initWithTitle:@"发布" image:[UIImage imageNamed:@"publish"] selectedImage:[UIImage imageNamed:@"publish"]];

// 使用此方法添加plusItem，可添加人一个，actionBlock为点击事件
[tabBarController addPlusItemWithSystemTabBarItem:addItem actionBlock:^{
    [SVProgressHUD showInfoWithStatus:@"发布"];
}];

```

### 4、自定义切换事件（如转转切换到消息tab时，调登录）

<img src='Screenshots/TLTabBar_Change.gif' width = "375" height = "667" alt="change" align=center />


```
TLDemoTableViewController *vc4 = [[TLDemoTableViewController alloc] init];
UINavigationController *navC4 = [[UINavigationController alloc] initWithRootViewController:vc4];

// actionBlock为点击事件，它返回的BOOL值决定是否可以跳转
[tabBarController addChildViewController:navC4 actionBlock:^BOOL{
    BOOL canJump = ... // 能否跳转的判断逻辑
    return canJump;
}];
```

### 5、双击、单击事件（如微博，双击tab刷新）

<img src='Screenshots/TLTabBar_DoubleClick.gif' width = "375" height = "667" alt="doubleClick" align=center />

```
在vc中实现TLTabBarControllerProtocol协议中的tabBarItemDidDoubleClick方法，即可接收到双击事件；单击类似。

```

### 6、tabBar顶端线颜色设置、隐藏

<img src='Screenshots/TLTabBar_Shadow.gif' width = "375" height = "667" alt="shadow" align=center />

```
// 颜色设置
[vc.tabBarController.tabBar setShadowColor:[UIColor magentaColor]];

// 隐藏
[vc.tabBarController.tabBar setHiddenShadow:YES];
```

### 7、横屏支持

<img src='Screenshots/TLTabBar_XY.gif' width = "667" height = "667" alt="TLTabBar_XY" align=center />

## 如何使用

* 1、将TLTabBarController文件夹导入项目，或使用Pod

```
pod 
```

* 2、修改如下一行代码即可

```
// UITabBarController *tabBarController = [[UITabBarController alloc] init];
TLTabBarController *tabBarController = [[TLTabBarController alloc] init];
```
