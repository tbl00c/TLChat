//
//  UIView+ZZSeparator.h
//  TLChat
//
//  Created by lbk on 2017/7/5.
//  Copyright © 2017年 lbk. All rights reserved.
//

//  给View添加分割线，未完成

#import <UIKit/UIKit.h>

#define     ZZSEPERATOR_DEFAULT_COLOR       [UIColor colorWithString:@"#eaeaea" alpha:1.0]

typedef NS_ENUM(NSInteger, ZZSeparatorPosition) {
    ZZSeparatorPositionTop,
    ZZSeparatorPositionBottom,
    ZZSeparatorPositionLeft,
    ZZSeparatorPositionRight,
    ZZSeparatorPositionCenterX,
    ZZSeparatorPositionCenterY,
};

@class ZZSeparatorModel;
@interface ZZSeparatorChainModel : NSObject

/// 偏移量（相对于方向）
- (ZZSeparatorChainModel *(^)(CGFloat offset))offset;
/// 颜色
- (ZZSeparatorChainModel *(^)(UIColor *color))color;
/// 起点
- (ZZSeparatorChainModel *(^)(CGFloat begin))beginAt;
/// 长度
- (ZZSeparatorChainModel *(^)(CGFloat length))length;
/// 终点（优先使用长度）
- (ZZSeparatorChainModel *(^)(CGFloat end))endAt;
/// 线粗
- (ZZSeparatorChainModel *(^)(CGFloat borderWidth))borderWidth;

@end

@interface UIView (ZZSeparator)

- (ZZSeparatorChainModel *(^)(ZZSeparatorPosition position))addSeparator;

- (void (^)(ZZSeparatorPosition position))removeSeparator;

- (void)updateSeparator;

@end
