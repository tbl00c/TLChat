//
//  ZZFlexibleLayoutViewController.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2016/10/10.
//  Copyright © 2016年 wuba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZFlexibleLayoutFlowLayout.h"
#import "ZZFLEXChainSectionModel.h"
#import "ZZFLEXChainViewModel.h"
#import "ZZFLEXChainViewArrayModel.h"

/**
 *  动态布局页面框架类 2.0
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
 */

#define     TAG_CELL_NONE                   0                                               // 默认cell Tag，在未指定时使用
#define     TAG_CELL_SEPERATOR              -1                                              // 空白分割cell Tag
#define     DEFAULT_SEPERATOR_SIZE          CGSizeMake(self.view.frame.size.width, 10.0f)   // 默认分割cell大小
#define     DEFAULT_SEPERATOR_COLOR         [UIColor clearColor]                            // 默认分割cell颜色

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
ZZFlexibleLayoutViewControllerProtocol,
UICollectionViewDataSource,
UICollectionViewDelegate,
ZZFlexibleLayoutFlowLayoutDelegate
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
