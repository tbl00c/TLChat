# ZZFLEX

<img src="./Screenshot/zz_logo.png" />

一个完善的iOS UI敏捷开发框架，基于UIKit，包含常用控件的链式API拓展、一个数据驱动的列表框架、一个事件处理队列。

![Travis](https://img.shields.io/travis/tbl00c/ZZFLEX.svg) ![CocoaPods](https://img.shields.io/cocoapods/v/ZZFLEX.svg) ![license MIT](https://img.shields.io/github/license/tbl00c/ZZFLEX.svg) ![platofrm](https://img.shields.io/badge/platform-ios-lightgrey.svg)


<img src="./Screenshot/1.gif" width = "375" height = "667" alt="screenshot1" />  <img src="./Screenshot/2.gif" width = "375" height = "667" alt="screenshot1" />

## 如何使用

##### 1、直接导入方式

将项目下载到本地后，把ZZFlexibleLayoutFramework拖入到你的项目中，即可正常使用。

##### 2、CocoaPods方式

```
pod 'ZZFLEX', :git => 'https://github.com/tbl00c/ZZFLEX.git'
```

## 功能模块

目前ZZFLEX主要包含以下5个功能模块：

### UIView+ZZFLEX

UIView+ZZFLEX为UIkit中的常用控件增加了链式API的拓展，引入它后，我们可以直接为view ```addButton```、 ```addLabel```、 ```addImageView```等。然后通过链式API，可更加连贯快捷的进行控件的属性设置、Masonry布局和事件处理。


以给视图添加button为例说明：

<img src="./Screenshot/demo2.png" alt="screenshot1" align=center />

可以看出，链式API十分的简洁高效，在大大缩减代码行数的同时、提高了代码的可读性。它使得同一控件的代码逻辑得以集中，我们称之为“控件的模块化”。

UIView+ZZFLEX是使用***Objective-C的泛型***实现的，可以无视继承关系、随意顺序设置控件属性。

如需对控件的属性进行编辑，可以这样写：

```
button.zz_make.frame(CGRectMake(0, 0, 100, 40)).title(@"hi").titleColor(@"how are u");
```

如需单独创建一个控件，不添加到视图上：

```
UIButton *button = UIButton.zz_create(1001).title(@"hello").titleHL(@"world").view;
```

你可以能会发现，在添加视图的时候，ZZFLEX会强制为视图添加一个tag，这样做的初衷是方便定位，此外如果你需要做一些用户行为统计及类似的功能，你或许会更感谢这种做法。

目前，UIView+ZZFLEX已添加链式API的控件有：

```UIView```, ``` UIImageView```, ```UILabel```, ```UIControl```, ```UITextField```, ```UIButton```, ```UISwitch```, ```UIScrollView```, ```UITextView```, ```UITableView```, ```UICollectionView```


### ZZFlexibleLayoutViewController

ZZFlexibleLayoutViewController是一个基于collectionView实现的***数据驱动的列表页框架***，可大幅降低复杂列表界面实现和维护的难度。

#### 容器层

使用它，我们几乎无需关心和实现collectionView的各种代理方法。它的设计使得列表页的构建就如同拼图一般，只需要一件件的add需要的模块，我们想要的界面就绘制出来了。因此，使用它实现的页面极具**拓展性**和**维护性**：

<img src="./Screenshot/demo3.png" alt="screenshot1" align=center />

在ZZFlexibleLayoutViewController中，我们不在使用sectionIndex/indexPath确定section/cell的位置，转而使用更唯一的sectionTag/viewTag代替。因为前者本质上是一个很不确定的数据、它会随着界面的变化而发生改变，很多与tableView/collectionView相关的崩溃也都与此有关。

#### 元素层

和之前不同的是，所有添加到ZZFlexibleLayoutViewController中的cell、header、footer需要额外实现一个协议—ZZFlexibleLayoutViewProtocol:

<img src="./Screenshot/viewProtocol.png" alt="screenshot1" align=center />

cell/view实现这个协议的目的和好处有两个：

1、框架层得以统一处理collectionView与cell/header/footer的交互；

2、方便进行整体的性能优化，如缓存view/header/footter计算大小的方法的数据。

***

目前主要支持的功能:
 
| | 添加 | 插入 | 获取 | 批量添加 | 批量插入 | 批量获取 | 编辑 | 删除 | 清空子数据 | 更新高度 |
|:-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| section | ✔️ | ✔️ | ✔️ | | | | ✔️ | ✔️ | ✔️ | ✔️ |
| cell | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ |  | ✔️ |  | ✔️ |
| header/footer | ✔️ | | ✔️ | | | |  | ✔️ | | ✔️ |

### ZZFLEXAngel

ZZFlexibleLayoutViewController为列表页的开发带来的优异的拓展性和可维护性，但它是一个VC级别的实现，在一些业务场景下还是不够灵活的。

ZZFLEXAngel是ZZFlexibleLayoutViewController核心思想和设计提炼而成的一个“列表控制中心”，它与页面和列表控件是完全解耦的。

使用它，我们只需通过任意collectionView或tableView来初始化一个ZZFLEXAngel实例（本质是将列表页的dataSource和delegate指向ZZFLEXAngel或其子类的实例），然后就可以通过这个实例、和ZZFlexibleLayoutViewController中一样，使用那些好用的API了。

<img src="./Screenshot/demo5.png" alt="screenshot1" align=center />

### ZZFLEXEditExtension

此拓展使得ZZFlexibleLayoutViewController和ZZFLEXAngel具有了处理编辑页面的能力，其主要原理为规范了编辑类页面处理流程，并使用一个额外的模型来控制它：

初始标准数据模型 -> 经ZZFLEXEditModel封装的数据 -> UI展现 -> 用户编辑 -> 输入合法性判断 -> 标准数据模型 -> 导出数据

<img src="./Screenshot/3.gif" width = "375" height = "667" alt="screenshot1" align=center />  <img src="./Screenshot/4.gif" width = "375" height = "667" alt="screenshot1" align=center />

### ZZFLEXRequestQueue

一些复杂的页面中会存在多个异步数据请求（net、db等），然而同时发起的异步请求，其结果的返回顺序是不确定的，这样会导致UI展示顺序的不确定性，很多情况下这是我们不希望看到的。

ZZFLEXRequestQueue的核心思想是“将一次数据请求的过程封装成对象”，它可以保证在此业务场景下，按队列顺序加载展示UI。

详见Demo。

## 其他

使用中的任何问题，欢迎提issure，也可与我交流：libokun@126.com
