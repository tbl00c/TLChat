//
//  ZZFlexibleLayoutViewController.h
//  zhuanzhuan
//
//  Created by lbk on 2016/10/10.
//  Copyright © 2016年 wuba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZFLEXAngel.h"

/**
 *  动态布局页面
 *
 *  基于UICollectionView和ZZFLEXAngel封装
 *
 *  注意：
 *  1、sectionTag是Section的表示，建议设置（如果涉及UI的刷新则必须设置），同时建议SectionTag唯一
 *  2、viewTag为cell/header/footer的标识，需要时设置，能够结合SectionTag取到DataModel，可以不唯一
 */

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
@interface ZZFlexibleLayoutViewController : UIViewController <ZZFLEXAngelAPIProtocol, ZZFlexibleLayoutViewControllerProtocol>

/// 瀑布流列表
@property (nonatomic, strong, readonly) UICollectionView *collectionView;

/// 数据源
@property (nonatomic, strong, readonly) NSMutableArray *data;

/// 天使，数据源控制器
@property (nonatomic, strong, readonly) ZZFLEXAngel *angel;


/// 滚动方向，默认垂直
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

/// header悬浮，默认NO
@property (nonatomic, assign) BOOL sectionHeadersPinToVisibleBounds;
/// footer悬浮，默认NO
@property (nonatomic, assign) BOOL sectionFootersPinToVisibleBounds;

@end

#pragma mark - ## ZZFlexibleLayoutViewController (Scroll)
@interface ZZFlexibleLayoutViewController (Scroll)

- (void)scrollToTop:(BOOL)animated;
- (void)scrollToBottom:(BOOL)animated;
- (void)scrollToSection:(NSInteger)sectionTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToSection:(NSInteger)sectionTag cell:(NSInteger)cellTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToCell:(NSInteger)cellTag position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToSectionIndex:(NSInteger)sectionIndex position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToIndexPath:(NSIndexPath *)indexPath position:(UICollectionViewScrollPosition)scrollPosition animated:(BOOL)animated;

@end

