//
//  UIView+Separator.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/5.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

//  给View添加分割线，未完成

#import <UIKit/UIKit.h>

#define     TLSEPERATOR_DEFAULT_COLOR       [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0]

typedef NS_ENUM(NSInteger, TLSeparatorPosition) {
    TLSeparatorPositionTop,
    TLSeparatorPositionBottom,
    TLSeparatorPositionLeft,
    TLSeparatorPositionRight,
    TLSeparatorPositionCenterX,
    TLSeparatorPositionCenterY,
};

@class TLSeparatorModel;
@interface TLSeparatorChainModel : NSObject

/// 偏移量（相对于方向）
- (TLSeparatorChainModel *(^)(CGFloat offset))offset;
/// 颜色
- (TLSeparatorChainModel *(^)(UIColor *color))color;
/// 起点
- (TLSeparatorChainModel *(^)(CGFloat begin))beginAt;
/// 长度
- (TLSeparatorChainModel *(^)(CGFloat length))length;
/// 终点（优先使用长度）
- (TLSeparatorChainModel *(^)(CGFloat end))endAt;
/// 线粗
- (TLSeparatorChainModel *(^)(CGFloat borderWidth))borderWidth;

@end

@interface UIView (Separator)

- (TLSeparatorChainModel *(^)(TLSeparatorPosition position))addSeparator;

- (void (^)(TLSeparatorPosition position))removeSeparator;

- (void)updateSeparator;

@end
