//
//  UINavigationBar+JZPrivate.m
//  navbarTest
//
//  Created by 李伯坤 on 2017/11/23.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "UINavigationBar+JZPrivate.h"
#import <objc/runtime.h>

@implementation UINavigationBar (JZPrivate)

#pragma mark - # 背景色
- (void)setJz_barTintColor:(UIColor *)jz_barTineColor
{
    [self setBarTintColor:jz_barTineColor];
}
- (UIColor *)jz_barTintColor
{
    return self.barTintColor;
}

#pragma mark - # 背景透明度
- (void)setJz_alpha:(CGFloat)alpha {
    UIView *barBackgroundView = [self valueForKey:@"_backgroundView"];
    if (@available(iOS 11.0, *)) {
        for (UIView *view in barBackgroundView.subviews) {
            view.alpha = alpha;
        }
    }
    else {
        barBackgroundView.alpha = alpha;
    }
}
- (CGFloat)jz_alpha {
    UIView *bgView = [self valueForKey:@"_backgroundView"];
    return bgView.alpha;
}

#pragma mark - # 大小
- (void)setJz_size:(CGSize)size {
    objc_setAssociatedObject(self, @selector(jz_size), [NSValue valueWithCGSize:size], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self sizeToFit];
}
- (CGSize)jz_size {
    return [objc_getAssociatedObject(self, _cmd) CGSizeValue];
}
- (CGSize)jz_sizeThatFits:(CGSize)size {
    CGSize newSize = [self jz_sizeThatFits:size];
    return CGSizeMake(self.jz_size.width == 0.f ? newSize.width : self.jz_size.width, self.jz_size.height == 0.f ? newSize.height : self.jz_size.height); \
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.jz_alpha < 1.0f) {
        return CGRectContainsPoint(CGRectMake(0, self.bounds.size.height - 44.f, self.bounds.size.width, 44.f), point);
    } else {
        return [super pointInside:point withEvent:event];
    }
}

@end
