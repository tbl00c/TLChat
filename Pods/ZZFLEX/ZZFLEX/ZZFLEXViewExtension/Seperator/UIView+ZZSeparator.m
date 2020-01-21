//
//  UIView+ZZSeparator.m
//  TLChat
//
//  Created by lbk on 2017/7/5.
//  Copyright © 2017年 lbk. All rights reserved.
//

#import "UIView+ZZSeparator.h"
#import <objc/runtime.h>
#import "ZZFLEXMacros.h"

#define     TLSEPERATOR_DEFAULT_COLOR       [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0]

#pragma mark - ## ZZSeparatorModel
@interface ZZSeparatorModel : NSObject

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) ZZSeparatorPosition position;

@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, assign) CGFloat offset;

@property (nonatomic, assign) CGFloat begin;
@property (nonatomic, assign) CGFloat end;
@property (nonatomic, assign) CGFloat length;

@property (nonatomic, strong, readonly) CAShapeLayer *layer;

@end

@implementation ZZSeparatorModel
@synthesize layer = _layer;

- (id)init
{
    if (self = [super init]) {
        [self setPosition:ZZSeparatorPositionBottom];
        [self setColor:TLSEPERATOR_DEFAULT_COLOR];
        [self setBegin:0];
        [self setEnd:0];
        [self setLength:0];
        [self setBorderWidth:BORDER_WIDTH_1PX];
    }
    return self;
}

- (CAShapeLayer *)layer
{
    if (!_layer) {
        _layer = [CAShapeLayer layer];
    }
    return _layer;
}

@end

#pragma mark - ## ZZSeparatorChainModel
@interface UIView (ZZSeparatorChainModel)

- (void)zz_updateSeparator;

@end

@interface ZZSeparatorChainModel ()

@property (nonatomic, weak, readonly) UIView *view;
@property (nonatomic, strong, readonly) ZZSeparatorModel *separatorModel;

@end

@implementation ZZSeparatorChainModel

- (id)initWithView:(UIView *)view andPosition:(ZZSeparatorPosition)position
{
    if (self = [super init]) {
        _view = view;
        _separatorModel = [[ZZSeparatorModel alloc] init];
        [self.separatorModel setPosition:position];
    }
    return self;
}

/// 偏移量
- (ZZSeparatorChainModel *(^)(CGFloat offset))offset
{
    return ^(CGFloat offset) {
        [self.separatorModel setOffset:offset];
        [self.view zz_updateSeparator];
        return self;
    };
}

/// 位置
- (ZZSeparatorChainModel *(^)(UIColor *color))color
{
    return ^(UIColor *color) {
        [self.separatorModel setColor:color];
        [self.view zz_updateSeparator];
        return self;
    };
}
/// 起点
- (ZZSeparatorChainModel *(^)(CGFloat begin))beginAt
{
    return ^(CGFloat begin) {
        [self.separatorModel setBegin:begin];
        [self.view zz_updateSeparator];
        return self;
    };
}
/// 长度
- (ZZSeparatorChainModel *(^)(CGFloat length))length
{
    return ^(CGFloat length) {
        [self.separatorModel setLength:length];
        [self.view zz_updateSeparator];
        return self;
    };
}
/// 终点
- (ZZSeparatorChainModel *(^)(CGFloat end))endAt
{
    return ^(CGFloat end) {
        [self.separatorModel setEnd:end];
        [self.view zz_updateSeparator];
        return self;
    };
}
/// 线粗
- (ZZSeparatorChainModel *(^)(CGFloat borderWidth))borderWidth;
{
    return ^(CGFloat borderWidth) {
        [self.separatorModel setBorderWidth:borderWidth];
        [self.view zz_updateSeparator];
        return self;
    };
}

@end

#pragma mark - ## UIView (ZZSeparator)
@implementation UIView (ZZSeparator)

- (ZZSeparatorChainModel *(^)(ZZSeparatorPosition position))addSeparator;
{
    return ^(ZZSeparatorPosition position) {
        ZZSeparatorChainModel *chainModel = [[ZZSeparatorChainModel alloc] initWithView:self andPosition:position];
        self.removeSeparator(position);
        [self.zz_separatorArray addObject:chainModel.separatorModel];
        [self zz_updateSeparator];
        return chainModel;
    };
}

- (void (^)(ZZSeparatorPosition position))removeSeparator
{
    return ^(ZZSeparatorPosition position) {
        ZZSeparatorModel *model = [self separatorModelForPosition:position];
        if (model) {
            [model.layer removeFromSuperlayer];
            [self.zz_separatorArray removeObject:model];
        }
    };
}

- (void)zz_updateSeparator
{
    for (ZZSeparatorModel *model in self.zz_separatorArray) {
        [self updateSeparatorWithModel:model];
    }
}

#pragma mark - # Private Methods
- (ZZSeparatorModel *)separatorModelForPosition:(ZZSeparatorPosition)position
{
    for (ZZSeparatorModel *model in self.zz_separatorArray) {
        if (model.position == position) {
            return model;
        }
    }
    return nil;
}

- (void)updateSeparatorWithModel:(ZZSeparatorModel *)separatorModel
{
    CGFloat startX = 0, startY = 0, endX = 0, endY = 0, offset = separatorModel.offset;
    CGFloat borderWidth = separatorModel.borderWidth;
    UIColor *color = separatorModel.color;
    if (separatorModel.position == ZZSeparatorPositionTop) {
        startY = endY = borderWidth / 2.0 + offset;
        startX = separatorModel.begin;
        if (separatorModel.length > 0) {
            endX = startX + separatorModel.length;
        }
        else {
            endX = self.frame.size.width + separatorModel.end;
        }
    }
    else if (separatorModel.position == ZZSeparatorPositionBottom) {
        startY = endY = self.frame.size.height - borderWidth / 2.0 + offset;
        startX = separatorModel.begin;
        if (separatorModel.length > 0) {
            endX = startX + separatorModel.length;
        }
        else {
            endX = self.frame.size.width + separatorModel.end;
        }
    }
    else if (separatorModel.position == ZZSeparatorPositionLeft) {
        startX = endX = borderWidth / 2.0 + offset;
        startY = separatorModel.begin;
        if (separatorModel.length > 0) {
            endY = startY + separatorModel.length;
        }
        else {
            endY = self.frame.size.height + separatorModel.end;
        }
    }
    else if (separatorModel.position == ZZSeparatorPositionRight) {
        startX = endX = self.frame.size.width - borderWidth / 2.0 + offset;
        startY = separatorModel.begin;
        if (separatorModel.length > 0) {
            endY = startY + separatorModel.length;
        }
        else {
            endY = self.frame.size.height + separatorModel.end;
        }
    }
    
    CAShapeLayer *layer = separatorModel.layer;
    [layer setStrokeColor:[color CGColor]];
    [layer setFillColor:[color CGColor]];
    [layer setLineWidth:borderWidth];
    
    CGMutablePathRef path =  CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, startX, startY);
    CGPathAddLineToPoint(path, NULL, endX, endY);
    [layer setPath:path];
    CGPathRelease(path);
    
    [self.layer addSublayer:layer];
}

#pragma mark - # Getters
static NSString *__zz_sepataror_key = @"";
- (NSMutableArray *)zz_separatorArray
{
    NSMutableArray *zz_separatorArray = objc_getAssociatedObject(self, &__zz_sepataror_key);
    if (!zz_separatorArray) {
        zz_separatorArray = [[NSMutableArray alloc] init];
        objc_setAssociatedObject(self, &__zz_sepataror_key, zz_separatorArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return zz_separatorArray;
}

@end
