//
//  UIView+Separator.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/5.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "UIView+Separator.h"
#import "NSObject+Association.h"
#import <objc/runtime.h>
#import "TLShortcutMacros.h"

#define     BORDER_WIDTH_1PX            ([[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0)

#pragma mark - ## TLSeparatorModel
@interface TLSeparatorModel : NSObject

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) TLSeparatorPosition position;

@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, assign) CGFloat offset;

@property (nonatomic, assign) CGFloat begin;
@property (nonatomic, assign) CGFloat end;
@property (nonatomic, assign) CGFloat length;

@property (nonatomic, strong, readonly) CAShapeLayer *layer;

@end

@implementation TLSeparatorModel
@synthesize layer = _layer;

- (id)init
{
    if (self = [super init]) {
        [self setPosition:TLSeparatorPositionBottom];
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

#pragma mark - ## TLSeparatorChainModel

@interface TLSeparatorChainModel ()

@property (nonatomic, weak, readonly) UIView *view;
@property (nonatomic, strong, readonly) TLSeparatorModel *SeparatorModel;

@end

@implementation TLSeparatorChainModel
@synthesize SeparatorModel = _SeparatorModel;

- (id)initWithView:(UIView *)view andPosition:(TLSeparatorPosition)position
{
    if (self = [super init]) {
        _view = view;
        [self.SeparatorModel setPosition:position];
    }
    return self;
}

/// 偏移量
- (TLSeparatorChainModel *(^)(CGFloat offset))offset
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
- (TLSeparatorChainModel *(^)(UIColor *color))color
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
- (TLSeparatorChainModel *(^)(CGFloat begin))beginAt
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
- (TLSeparatorChainModel *(^)(CGFloat length))length
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
- (TLSeparatorChainModel *(^)(CGFloat end))endAt
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
- (TLSeparatorChainModel *(^)(CGFloat borderWidth))borderWidth;
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
- (TLSeparatorModel *)SeparatorModel
{
    if (!_SeparatorModel) {
        _SeparatorModel = [[TLSeparatorModel alloc] init];
    }
    return _SeparatorModel;
}

@end

#pragma mark - ## UIView (Separator)
@implementation UIView (Separator)

- (TLSeparatorChainModel *(^)(TLSeparatorPosition position))addSeparator;
{
    @weakify(self);
    return ^(TLSeparatorPosition position) {
        @strongify(self);
        TLSeparatorChainModel *chainModel = [[TLSeparatorChainModel alloc] initWithView:self andPosition:position];
        self.removeSeparator(position);
        [self.SeparatorArray addObject:chainModel.SeparatorModel];
        [self updateSeparator];
        return chainModel;
    };
}

- (void (^)(TLSeparatorPosition position))removeSeparator
{
    @weakify(self);
    return ^(TLSeparatorPosition position) {
        @strongify(self);
        TLSeparatorModel *model = [self SeparatorModelForPosition:position];
        if (model) {
            [model.layer removeFromSuperlayer];
            [self.SeparatorArray removeObject:model];
        }
    };
}

- (void)updateSeparator
{
    for (TLSeparatorModel *model in self.SeparatorArray) {
        [self updateSeparatorWithModel:model];
    }
}

#pragma mark - # Private Methods
- (TLSeparatorModel *)SeparatorModelForPosition:(TLSeparatorPosition)position
{
    for (TLSeparatorModel *model in self.SeparatorArray) {
        if (model.position == position) {
            return model;
        }
    }
    return nil;
}

- (void)updateSeparatorWithModel:(TLSeparatorModel *)separatorModel
{
    CGFloat startX = 0, startY = 0, endX = 0, endY = 0, offset = separatorModel.offset;
    CGFloat borderWidth = separatorModel.borderWidth;
    UIColor *color = separatorModel.color;
    if (separatorModel.position == TLSeparatorPositionTop) {
        startY = endY = borderWidth / 2.0 + offset;
        startX = separatorModel.begin;
        if (separatorModel.length > 0) {
            endX = startX + separatorModel.length;
        }
        else {
            endX = self.frame.size.width + separatorModel.end;
        }
    }
    else if (separatorModel.position == TLSeparatorPositionBottom) {
        startY = endY = self.frame.size.height - borderWidth / 2.0 + offset;
        startX = separatorModel.begin;
        if (separatorModel.length > 0) {
            endX = startX + separatorModel.length;
        }
        else {
            endX = self.frame.size.width + separatorModel.end;
        }
    }
    else if (separatorModel.position == TLSeparatorPositionLeft) {
        startX = endX = borderWidth / 2.0 + offset;
        startY = separatorModel.begin;
        if (separatorModel.length > 0) {
            endY = startY + separatorModel.length;
        }
        else {
            endY = self.frame.size.height + separatorModel.end;
        }
    }
    else if (separatorModel.position == TLSeparatorPositionRight) {
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
- (NSMutableArray *)SeparatorArray
{
    NSMutableArray *SeparatorArray = [self associatedObjectForKey:@"SeparatorArray"];
    if (!SeparatorArray) {
        SeparatorArray = [[NSMutableArray alloc] init];
        [self setAssociatedObject:SeparatorArray forKey:@"SeparatorArray" association:TLAssociationStrong isAtomic:NO];
    }
    return SeparatorArray;
}

@end
