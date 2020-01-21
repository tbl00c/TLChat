//
//  UIView+ZZCornor.h
//  TLChat
//
//  Created by lbk on 2017/7/5.
//  Copyright © 2017年 lbk. All rights reserved.
//

//  给View添加圆角

#import <UIKit/UIKit.h>

#define     ZZSEPERATOR_DEFAULT_COLOR       [UIColor colorWithString:@"#eaeaea" alpha:1.0]

typedef NS_OPTIONS(NSInteger, ZZCornerPosition) {
    ZZCornerPositionTopLeft = 1 << 0,
    ZZCornerPositionTopRight = 1 << 1,
    ZZCornerPositionBottomLeft = 1 << 2,
    ZZCornerPositionBottomRight = 1 << 3,
    ZZCornerPositionTop = ZZCornerPositionTopLeft | ZZCornerPositionTopRight,
    ZZCornerPositionLeft = ZZCornerPositionTopLeft | ZZCornerPositionBottomLeft,
    ZZCornerPositionBottom = ZZCornerPositionBottomLeft | ZZCornerPositionBottomRight,
    ZZCornerPositionRight = ZZCornerPositionTopRight | ZZCornerPositionBottomRight,
    ZZCornerPositionAll = ZZCornerPositionTop | ZZCornerPositionBottom,
};

@class ZZCornerModel;
@interface ZZCornerChainModel : NSObject

/// 圆角
- (ZZCornerChainModel *(^)(CGFloat radius))radius;
/// 颜色
- (ZZCornerChainModel *(^)(UIColor *color))color;
/// 线粗
- (ZZCornerChainModel *(^)(CGFloat borderWidth))borderWidth;

@end

@interface UIView (ZZCornor)

- (ZZCornerChainModel *(^)(ZZCornerPosition position))setCornor;

- (void (^)(void))removeCornor;

@end
