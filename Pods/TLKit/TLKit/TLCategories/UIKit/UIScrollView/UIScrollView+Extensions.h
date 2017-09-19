//
//  UIScrollView+Extensions.h
//  TLKit
//
//  Created by 李伯坤 on 2017/8/27.
//  Copyright © 2017年 libokun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Extensions)

#pragma mark - # ContentOffset
@property (nonatomic, assign) CGFloat offsetX;
- (void)setOffsetX:(CGFloat)offsetX animated:(BOOL)animated;
@property (nonatomic, assign) CGFloat offsetY;
- (void)setOffsetY:(CGFloat)offsetY animated:(BOOL)animated;


#pragma mark - # ContentSize
@property (nonatomic, assign) CGFloat contentWidth;
@property (nonatomic, assign) CGFloat contentHeight;


#pragma mark - # Scroll
/**
 *  滚动到最顶端
 */
- (void)scrollToTopWithAnimation:(BOOL)animation;
/**
 *  滚动到最底端
 */
- (void)scrollToBottomWithAnimation:(BOOL)animation;
/**
 *  滚动到最左端
 */
- (void)scrollToLeftWithAnimation:(BOOL)animation;
/**
 *  滚动到最右端
 */
- (void)scrollToRightWithAnimation:(BOOL)animation;

@end
