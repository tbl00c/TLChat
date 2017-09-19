//
//  UITabBar+TLExtension.m
//  TLKit
//
//  Created by 李伯坤 on 2017/9/15.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "UITabBar+TLExtension.h"
#import <objc/runtime.h>

UIImage *__tl_imageWithColor(UIColor *color)
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

static char *tl_plusButtonImageOffset = "tl_plusButtonImageOffset";

@implementation UITabBar (TLExtension)

- (void)setHiddenShadow:(BOOL)hiddenShadow
{
    if (self.barTintColor) {
        [self setBackgroundImage:__tl_imageWithColor(self.barTintColor)];
    }
    else {
        [self setBackgroundImage:__tl_imageWithColor([UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:244.0/255.0 alpha:1.0])];
    }
    if (hiddenShadow) {
        [self setShadowImage:[UIImage new]];
    }
    else {
        [self setShadowImage:nil];
    }
}

- (void)setShadowColor:(UIColor *)shadowColor
{
    [self setHiddenShadow:NO];
    if (shadowColor) {
        [self setShadowImage:__tl_imageWithColor(shadowColor)];
    }
    else {
        [self setShadowImage:[UIImage new]];
    }
}

- (void)setPlusButtonImageOffset:(CGFloat)plusButtonImageOffset
{
    objc_setAssociatedObject(self, tl_plusButtonImageOffset, @(plusButtonImageOffset), OBJC_ASSOCIATION_ASSIGN);
}
- (CGFloat)plusButtonImageOffset
{
    return [(NSNumber *)objc_getAssociatedObject(self, tl_plusButtonImageOffset) doubleValue];
}

@end
