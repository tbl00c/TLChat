# ZZFLEX
一个iOS UI敏捷开发框架，基于UIKit实现，主要包含常用控件的链式API拓展、一个数据驱动的列表框架、一个事件处理队列。

<img src="./Screenshot/1.gif" width = "375" height = "667" alt="screenshot1" align=center />

## 功能模块

目前ZZFLEX主要包含以下5个功能模块：

* **UIView+ZZFLEX**：为UIKit中常用的控件增加了链式API拓展；
* **ZZFlexibleLayoutViewController**：基于UICollectionView的数据驱动的列表页框架；
* **ZZFLEXAngel**：ZZFlexibleLayoutViewController核心逻辑抽离出的一个列表控制器，更加轻量，支持tableView、collectionView；
* **ZZFLEXEditExtension**：为ZZFLEXAngel和ZZFlexibleLayoutViewController增加了处理编辑类页面的能力；
* **ZZFLEXRequestQueue**：一个事件处理队列，设计的初衷为解决复杂页面多接口请求时、UI刷新顺序的问题。

### UIView+ZZFLEX

UIView+ZZFLEX主要是为UIkit中的常用控件增加了链式API的拓展，引入它后，我们可以直接为view```addButton```、```addLabel```、```addImageView```等等，然后通过链式API可以更加连贯快捷的进行控件的属性设置、Masonry布局和事件处理。

以给视图添加button为例说明，通常我们的做法是这样的：

<img src="./Screenshot/demo1.png" alt="screenshot1" align=center />

使用UIView+ZZFLEX后，你可以这样写：

<img src="./Screenshot/demo2.png" alt="screenshot1" align=center />

以上可以很直观的看出，同样的功能，代码行数有原先的33行缩减到了20行，并且写起来更加顺畅。如果我们需要持有这个button指针，只需在最后加一个```.view```即可。

UIView+ZZFLEX是使用的是Objective-C的泛型实现的，所以可以无视继承关系、随意顺序设置控件的属性。

如需对控件的属性进行编辑，可以这样写：

```
button.zz_make.frame(CGRectMake(0, 0, 100, 40)).title(@"hi").titleColor(@"how are u");
```

如需单独创建一个控件，不添加到视图上：

```
UIButton *button = UIButton.zz_create(1001).title(@"hello").titleHL(@"world").view;
```

目前，UIView+ZZFLEX已添加链式API的控件有：

* UIView
* UIImageView
* UILabel
* UIControl
* UITextField
* UIButton
* UISwitch
* UIScrollView
* UITextView
* UITableView
* UICollectionView

### ZZFlexibleLayoutViewController

ZZFlexibleLayoutViewController继承自UIViewController，是一个基于collectionView实现的数据驱动的列表页框架，可大幅降低复杂列表界面实现和维护的难度。

我们知道collectionView在使用过程中，各种代理方法重复度高，并且越复杂的界面各种代理方法中的代码就越复杂、越难以维护，一旦设计不好还容易出现性能问题。很多设计模式和第三方库从代码结构和数据缓存等各个角度做出了优化，也取得了一定的效果。但ZZFLEX不同的是，它将从根源解决这一个问题。

使用ZZFlexibleLayoutViewController，我们几乎丝毫不用实现collectionView的各种代理方法。它使得列表页的构建就如同拼图一般，只需要一件件的add需要的模块，即可绘制出我们想要的界面：

<img src="./Screenshot/demo3.png" alt="screenshot1" align=center />

在ZZFlexibleLayoutViewController中，我们不在使用sectionIndex/indexPath确定section/cell的位置，转而使用更唯一的sectionTag/viewTag代替。因为前者本质上是一个很不确定的数据、它会随着界面的变化而发生改变，很多与tableView/collectionView相关的崩溃也都与此有关。

说完了collectionView容器，再说容器里的元素。和之前不同的是，所有添加到ZZFlexibleLayoutViewController中的cell、header、footer需要额外实现一个协议—ZZFlexibleLayoutViewProtocol：

<img src="./Screenshot/viewProtocol.png" alt="screenshot1" align=center />

cell/view实现这个协议的目的是，方便框架层统一处理collectionView中的的各种代理方法，并且也有一些性能优化方面的考虑，想计算大小/高度的那个方法，实际会做大小/高度的缓存，即在不手动调用刷新方法时，自始至终只会在添加时调用一次，大家可以放心使用。

目前主要支持的功能：
 
| | 添加 | 插入 | 获取 | 批量添加 | 批量插入 | 批量获取 | 编辑 | 删除 | 清空子数据 | 更新高度 |
|:-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| section | ✔️ | ✔️ | ✔️ | | | | ✔️ | ✔️ | ✔️ | ✔️ |
| cell | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ | ✔️ |  | ✔️ |  | ✔️ |
| header/footer | ✔️ | | ✔️ | | | |  | ✔️ | | ✔️ |

使用方法简述：

<img src="./Screenshot/demo4.png" alt="screenshot1" align=center />

### ZZFLEXAngel

ZZFlexibleLayoutViewController为列表页的开发带来的优异的拓展性和可维护性，但它是一个VC级别的实现，在一些业务场景下还是不够灵活的。

<img src="./Screenshot/2.gif" width = "375" height = "667" alt="screenshot1" align=center />

ZZFLEXAngel是ZZFlexibleLayoutViewController核心思想和设计提炼而成的一个“列表控制中心”，它与页面和列表控件是完全解耦的。

使用它，我们只需通过任意collectionView或tableView来初始化一个ZZFLEXAngel实例（本质是将列表页的dataSource和delegate指向ZZFLEXAngel或其子类的实例），然后就可以通过这个实例、和ZZFlexibleLayoutViewController中一样，使用那些好用的API了。

<img src="./Screenshot/demo5.png" alt="screenshot1" align=center />

### ZZFLEXEditExtension

此拓展使得ZZFlexibleLayoutViewController和ZZFLEXAngel具有了处理编辑页面的能力，其主要原理为规范了编辑类页面处理流程，并使用一个额外的模型来控制它：

初始标准数据模型 -> 经ZZFLEXEditModel封装的数据 -> UI展现 -> 用户编辑 -> 输入合法性判断 -> 标准数据模型 -> 导出数据

<img src="./Screenshot/3.gif" width = "375" height = "667" alt="screenshot1" align=center />

### ZZFLEXRequestQueue

一些复杂的页面中会存在多个异步数据请求（net、db等），然而同时发起的异步请求，其结果的返回顺序是不确定的，这样会导致UI展示顺序的不确定性，很多情况下这是我们不希望看到的。

ZZFLEXRequestQueue的核心思想是“将一次数据请求的过程封装成对象”，它可以保证在此业务场景下，按队列顺序加载展示UI。

<img src="./Screenshot/4.gif" width = "375" height = "667" alt="screenshot1" align=center />


详见Demo。

## 如何使用
### 1、直接导入方式
将项目下载到本地后，把ZZFlexibleLayoutFramework拖入到你的项目中，即可正常使用。

### 2、CocoaPods方式

```
Pod 'ZZFLEX', :git => 'git@github.com:tbl00c/ZZFLEX.git'
```

## 其他

使用中的任何问题，欢迎提issure，也可与我交流：libokun@126.com
