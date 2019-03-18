//
//  ZZFlexibleLayoutViewController.h
//  zhuanzhuan
//
//  Created by lbk on 2016/10/10.
//  Copyright © 2016年 wuba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZFLEXChainSectionModel.h"
#import "ZZFLEXChainViewModel.h"
#import "ZZFLEXChainViewBatchModel.h"
#import "ZZFLEXChainViewEditModel.h"

/**
 *  动态布局页面框架类 3.0
 *
 *  对UICollectionView的二次封装
 *
 *  注意：
 *  1、sectionTag是Section的表示，建议设置（如果涉及UI的刷新则必须设置），同时建议SectionTag唯一
 *  2、cellTag为cell的表示，需要时设置，能够结合SectionTag取到DataModel，可以不唯一
 *
 *  2.0更新：
 *  1、优化框架代码结构，此类只保留核心代码，将API、OldAPI拆分到分类中；
 *  2、主要API改为链式，使用更加灵活，原API已经移动到OldAPI分类中
 *  3、Cell模块化支持，使用eventAction代替delegate
 *
 *  3.0更新：
 *  1、加入UIView+ZZFLEX模块
 *  2、ZZFLEX主要API优化
 */

#define     TAG_CELL_NONE                   0                                               // 默认cell Tag，在未指定时使用
#define     TAG_CELL_SEPERATOR              -1                                              // 空白分割cell Tag
#define     DEFAULT_SEPERATOR_SIZE          CGSizeMake(self.view.frame.size.width, 10.0f)   // 默认分割cell大小
#define     DEFAULT_SEPERATOR_COLOR         [UIColor clearColor]                            // 默认分割cell颜色

#define     ZZFLEX_CHAINAPI_TYPE            @property (nonatomic, copy, readonly)

#pragma mark - ## ZZFlexibleLayoutViewControllerProtocol
@protocol ZZFlexibleLayoutViewControllerProtocol <NSObject>
@optional;
/**
 *  collectionView Cell 点击事件
 */
- (void)collectionViewDidSelectItem:(id)itemModel
                         sectionTag:(NSInteger)sectionTag
                            cellTag:(NSInteger)cellTag
                          className:(NSString *)className
                          indexPath:(NSIndexPath *)indexPath;
@end


#pragma mark - ## ZZFlexibleLayoutViewController
@class ZZFlexibleLayoutSectionModel;
@interface ZZFlexibleLayoutViewController : UIViewController <
ZZFlexibleLayoutViewControllerProtocol
>

/// 瀑布流列表
@property (nonatomic, strong, readonly) UICollectionView *collectionView;

/// 数据源
@property (nonatomic, strong, readonly) NSMutableArray *data;


/// 滚动方向，默认垂直
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

/// header悬浮，默认NO
@property (nonatomic, assign) BOOL sectionHeadersPinToVisibleBounds;
/// footer悬浮，默认NO
@property (nonatomic, assign) BOOL sectionFootersPinToVisibleBounds;

@end


#pragma mark - ## ZZFlexibleLayoutViewController (API)
@interface ZZFlexibleLayoutViewController (API)

#pragma mark - # 页面
/// 刷新页面
- (void)reloadView;


#pragma mark - # 整体
/// 删除所有元素
ZZFLEX_CHAINAPI_TYPE BOOL (^clear)(void);

/// 删除所有Cell
ZZFLEX_CHAINAPI_TYPE BOOL (^clearAllCells)(void);

/// 更新所有元素
ZZFLEX_CHAINAPI_TYPE BOOL (^upadte)(void);

/// 更新所有Cell
ZZFLEX_CHAINAPI_TYPE BOOL (^upadteAllCells)(void);

#pragma mark - # Section操作
/// 添加section
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainSectionModel *(^addSection)(NSInteger tag);

/// 插入section
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainSectionInsertModel *(^insertSection)(NSInteger tag);

/// 获取/编辑section
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainSectionEditModel *(^sectionForTag)(NSInteger tag);

/// 删除section
ZZFLEX_CHAINAPI_TYPE BOOL (^deleteSection)(NSInteger tag);

/// 判断section是否存在
ZZFLEX_CHAINAPI_TYPE BOOL (^hasSection)(NSInteger tag);

/// 删除section的所有元素（cell,header,footer），或使用 self.sectionFotTag(tag).clear();
- (BOOL)deleteAllItemsForSection:(NSInteger)tag;

/// 删除section的所有cell, 或使用 self.sectionFotTag(tag).clearAllCells()
- (BOOL)deleteAllCellsForSection:(NSInteger)tag;

/// 更新section信息，或使用 self.sectionFotTag(tag).update()
- (void)updateSectionForTag:(NSInteger)sectionTag;

/// 获取section index
- (NSInteger)sectionIndexForTag:(NSInteger)sectionTag;


#pragma mark - # Section HeaderFooter 操作
/// 为section添加headerView，传入nil将删除header
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewModel *(^setHeader)(NSString *className);

/// 为section添加footerView，传入nil将删除footer
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewModel *(^setFooter)(NSString *className);


#pragma mark - # Section Cell 操作
/// 添加cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewModel *(^ addCell)(NSString *className);

/// 批量添加cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewBatchModel *(^ addCells)(NSString *className);

/// 插入cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewInsertModel *(^ insertCell)(NSString *className);

/// 批量插入cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewBatchInsertModel *(^ insertCells)(NSString *className);

/// 添加空白cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewModel *(^ addSeperatorCell)(CGSize size, UIColor *color);

/// 删除第一个符合条件的cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewEditModel *deleteCell;

/// 删除所有符合条件的cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewBatchEditModel *deleteCells;

/// 更新第一个符合条件的cell高度
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewEditModel *updateCell;

/// 更新所有符合条件的cell高度
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewBatchEditModel *updateCells;

/// 是否包含cell
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewEditModel *hasCell;

#pragma mark - # DataModel 数据源获取
/// 数据源获取
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewEditModel *dataModel;
/// 批量数据源获取(注意，dataModel为nil的元素，在数组中以NSNull存在)
ZZFLEX_CHAINAPI_TYPE ZZFLEXChainViewBatchEditModel *dataModelArray;

@end

#pragma mark - ## ZZFlexibleLayoutViewController (View)
@interface ZZFlexibleLayoutViewController (View)

- (void)scrollToTop:(BOOL)animated;
- (void)scrollToBottom:(BOOL)animated;
- (void)scrollToSection:(NSInteger)sectionTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToSection:(NSInteger)sectionTag cell:(NSInteger)cellTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToCell:(NSInteger)cellTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToSectionIndex:(NSInteger)sectionIndex position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToIndexPath:(NSIndexPath *)indexPath position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;

@end

