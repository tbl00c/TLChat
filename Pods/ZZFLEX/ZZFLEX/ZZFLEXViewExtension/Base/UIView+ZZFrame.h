//
//  UIView+ZZFrame.h
//  ZZFLEXDemo
//
//  Created by lbk on 2017/11/27.
//  Copyright © 2017年 lbk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZZFrame)

#pragma mark - Origin
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

#pragma mark - Size
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

#pragma mark - Center
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

#pragma mark - Coords
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;

@end
