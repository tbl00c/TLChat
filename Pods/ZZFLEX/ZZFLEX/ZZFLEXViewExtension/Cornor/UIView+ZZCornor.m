//
//  UIView+ZZCornor.m
//  TLChat
//
//  Created by lbk on 2017/7/5.
//  Copyright © 2017年 lbk. All rights reserved.
//

#import "UIView+ZZCornor.h"
#import <objc/runtime.h>
#import "ZZFLEXMacros.h"

#define     TLSEPERATOR_DEFAULT_COLOR       [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0]

#pragma mark - ## ZZCornerModel
@interface ZZCornerModel : NSObject

@property (nonatomic, assign) ZZCornerPosition position;

@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, strong, readonly) CAShapeLayer *layer;

@end

@implementation ZZCornerModel
@synthesize layer = _layer;

- (CAShapeLayer *)layer
{
    if (!_layer) {
        _layer = [CAShapeLayer layer];
    }
    return _layer;
}

@end

#pragma mark - ## ZZCornerChainModel
@interface UIView (ZZCornerChainModel)

- (void)zz_updateCornor;

@end

@interface ZZCornerChainModel ()

@property (nonatomic, weak, readonly) UIView *view;
@property (nonatomic, strong, readonly) ZZCornerModel *cornorModel;

@end

@implementation ZZCornerChainModel

- (id)initWithView:(UIView *)view andPosition:(ZZCornerPosition)position
{
    if (self = [super init]) {
        _view = view;
        _cornorModel = [[ZZCornerModel alloc] init];
        [self.cornorModel setPosition:position];
    }
    return self;
}

/// 偏移量
- (ZZCornerChainModel *(^)(CGFloat radius))radius
{
    return ^(CGFloat radius) {
        [self.cornorModel setRadius:radius];
        [self.view zz_updateCornor];
        return self;
    };
}

/// 位置
- (ZZCornerChainModel *(^)(UIColor *color))color
{
    return ^(UIColor *color) {
        [self.cornorModel setColor:color];
        [self.view zz_updateCornor];
        return self;
    };
}

/// 线粗
- (ZZCornerChainModel *(^)(CGFloat borderWidth))borderWidth;
{
    return ^(CGFloat borderWidth) {
        [self.cornorModel setBorderWidth:borderWidth];
        [self.view zz_updateCornor];
        return self;
    };
}

@end

#pragma mark - ## UIView (ZZSeparator)
@implementation UIView (ZZSeparator)

- (ZZCornerChainModel *(^)(ZZCornerPosition position))setCornor;
{
    return ^(ZZCornerPosition position) {
        self.removeCornor();
        ZZCornerChainModel *chainModel = [[ZZCornerChainModel alloc] initWithView:self andPosition:position];
        [self setZz_cornerModel:chainModel.cornorModel];
        [self zz_updateCornor];
        return chainModel;
    };
}

- (void (^)(void))removeCornor
{
    return ^ {
        [self.zz_cornerModel.layer removeFromSuperlayer];
        [self setZz_cornerModel:nil];
    };
}

- (void)zz_updateCornor
{
    [self updateCornorWithModel:self.zz_cornerModel];
}

#pragma mark - # Private Methods
- (void)updateCornorWithModel:(ZZCornerModel *)cornorModel
{
    cornorModel.color = [UIColor redColor];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:cornorModel.position cornerRadii:CGSizeMake(cornorModel.radius, cornorModel.radius)];
    
    CAShapeLayer *layer = cornorModel.layer;
    [layer setFrame:self.bounds];
    [layer setPath:path.CGPath];
    [layer setStrokeColor:[cornorModel.color CGColor]];
    [layer setFillColor:[cornorModel.color CGColor]];
    [layer setLineWidth:cornorModel.borderWidth];

    [self.layer setMask:layer];
}

#pragma mark - # Getters
static NSString *__zz_corner_key = @"";
- (ZZCornerModel *)zz_cornerModel
{
    ZZCornerModel *model = objc_getAssociatedObject(self, &__zz_corner_key);
    return model;
}

- (void)setZz_cornerModel:(ZZCornerModel *)cornerModel
{
    objc_setAssociatedObject(self, &__zz_corner_key, cornerModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
