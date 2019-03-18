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

@interface ZZSeparatorChainModel ()

@property (nonatomic, weak, readonly) UIView *view;
@property (nonatomic, strong, readonly) ZZSeparatorModel *SeparatorModel;

@end

@implementation ZZSeparatorChainModel
@synthesize SeparatorModel = _SeparatorModel;

- (id)initWithView:(UIView *)view andPosition:(ZZSeparatorPosition)position
{
    if (self = [super init]) {
        _view = view;
        [self.SeparatorModel setPosition:position];
    }
    return self;
}

/// 偏移量
- (ZZSeparatorChainModel *(^)(CGFloat offset))offset
{
    @weakify(self);
    return ^(CGFloat offset) {
        @strongify(self);
        [self.SeparatorModel setOffset:offset];
        [self.view updateSeparator];
        return self;
    };
}

/// 位置
- (ZZSeparatorChainModel *(^)(UIColor *color))color
{
    @weakify(self);
    return ^(UIColor *color) {
        @strongify(self);
        [self.SeparatorModel setColor:color];
        [self.view updateSeparator];
        return self;
    };
}
/// 起点
- (ZZSeparatorChainModel *(^)(CGFloat begin))beginAt
{
    @weakify(self);
    return ^(CGFloat begin) {
        @strongify(self);
        [self.SeparatorModel setBegin:begin];
        [self.view updateSeparator];
        return self;
    };
}
/// 长度
- (ZZSeparatorChainModel *(^)(CGFloat length))length
{
    @weakify(self);
    return ^(CGFloat length) {
        @strongify(self);
        [self.SeparatorModel setLength:length];
        [self.view updateSeparator];
        return self;
    };
}
/// 终点
- (ZZSeparatorChainModel *(^)(CGFloat end))endAt
{
    @weakify(self);
    return ^(CGFloat end) {
        @strongify(self);
        [self.SeparatorModel setEnd:end];
        [self.view updateSeparator];
        return self;
    };
}
/// 线粗
- (ZZSeparatorChainModel *(^)(CGFloat borderWidth))borderWidth;
{
    @weakify(self);
    return ^(CGFloat borderWidth) {
        @strongify(self);
        [self.SeparatorModel setBorderWidth:borderWidth];
        [self.view updateSeparator];
        return self;
    };
}

#pragma mark - # Getters
- (ZZSeparatorModel *)SeparatorModel
{
    if (!_SeparatorModel) {
        _SeparatorModel = [[ZZSeparatorModel alloc] init];
    }
    return _SeparatorModel;
}

@end

#pragma mark - ## UIView (ZZSeparator)
@implementation UIView (ZZSeparator)

- (ZZSeparatorChainModel *(^)(ZZSeparatorPosition position))addSeparator;
{
    @weakify(self);
    return ^(ZZSeparatorPosition position) {
        @strongify(self);
        ZZSeparatorChainModel *chainModel = [[ZZSeparatorChainModel alloc] initWithView:self andPosition:position];
        self.removeSeparator(position);
        [self.SeparatorArray addObject:chainModel.SeparatorModel];
        [self updateSeparator];
        return chainModel;
    };
}

- (void (^)(ZZSeparatorPosition position))removeSeparator
{
    @weakify(self);
    return ^(ZZSeparatorPosition position) {
        @strongify(self);
        ZZSeparatorModel *model = [self SeparatorModelForPosition:position];
        if (model) {
            [model.layer removeFromSuperlayer];
            [self.SeparatorArray removeObject:model];
        }
    };
}

- (void)updateSeparator
{
    for (ZZSeparatorModel *model in self.SeparatorArray) {
        [self updateSeparatorWithModel:model];
    }
}

#pragma mark - # Private Methods
- (ZZSeparatorModel *)SeparatorModelForPosition:(ZZSeparatorPosition)position
{
    for (ZZSeparatorModel *model in self.SeparatorArray) {
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
- (NSMutableArray *)SeparatorArray
{
    NSMutableArray *separatorArray = objc_getAssociatedObject(self, &__zz_sepataror_key);
    if (!separatorArray) {
        separatorArray = [[NSMutableArray alloc] init];
        objc_setAssociatedObject(self, &__zz_sepataror_key, separatorArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return separatorArray;
}

@end
