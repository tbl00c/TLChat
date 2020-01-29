//
//  UIView+Extensions.m
//  TLKit
//
//  Created by 李伯坤 on 2017/8/27.
//  Copyright © 2017年 libokun. All rights reserved.
//

#import "UIView+Extensions.h"
#import <objc/runtime.h>

static NSString *kStringTag = @"kStringTag";

@implementation UIView (Extensions)

- (UIViewController *)viewController
{
    for (UIView *next = self; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (UINavigationController *)navigationController
{
    return self.viewController.navigationController;
}

- (BOOL)isShowInScreen
{
    if (self == nil) {
        return NO;
    }
    
    // 转换view对应window的Rect
    CGRect rect = [self convertRect:self.bounds toView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return NO;
    }
    
    if (self.hidden ||                              // view已隐藏
        self.superview == nil ||                    // 没有父视图
        CGSizeEqualToSize(rect.size, CGSizeZero)    // size为0
        ) {
        return NO;
    }
    
    // 计算view与window交叉的rect
    CGRect screenRect = [UIScreen mainScreen].bounds;
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return NO;
    }
    
    return YES;
}

- (void)removeAllSubviews
{
    for (id view in self.subviews) {
        [view removeFromSuperview];
    }
}

- (id)findSubViewWithClass:(Class)subViewClass
{
    for (id subView in self.subviews) {
        if ([subView isKindOfClass:subViewClass]) {
            return subView;
        }
    }
    
    return nil;
}

- (id)findSuperViewWithClass:(Class)superViewClass
{
    if (self == nil || self.superview == nil) {
        return nil;
    }
    else if ([self.superview isKindOfClass:superViewClass]) {
        return self.superview;
    }
    else {
        return [self.superview findSuperViewWithClass:superViewClass];
    }
}

- (UIView *)findFirstResponder
{
    if ([self canBecomeFirstResponder]  && self.isFirstResponder) {
        return self;
    }
    
    for (UIView *view in self.subviews) {
        UIView *firstResponder = [view findFirstResponder];
        if (firstResponder) {
            return firstResponder;
        }
    }
    return nil;
}

- (NSString *)stringTag {
    return objc_getAssociatedObject(self, &kStringTag);
}

- (void)setStringTag:(NSString *)tag {
    objc_setAssociatedObject(self, &kStringTag, tag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
