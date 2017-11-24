//
//  UITabBarItem+TLPrivateExtension.m
//  TLKit
//
//  Created by 李伯坤 on 2017/9/15.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "UITabBarItem+TLPrivateExtension.h"
#import <objc/runtime.h>

#define     TLExchangeMethod(oldSEL, newSEL) {  \
    Method oldMethod = class_getInstanceMethod(self, oldSEL);\
    Method newMethod = class_getInstanceMethod(self, newSEL);\
    method_exchangeImplementations(oldMethod, newMethod); \
}

static char *tl_tabBarControl = "__tl_tabBarControl";
static char *tl_badge = "__tl_badge";
static char *tl_isPlusButton = "__tl_isPlusButton";
static char *tl_actionBlock = "__tl_actionBlock";

@implementation UITabBarItem (TLPrivateExtension)

+ (void)load
{
    TLExchangeMethod(@selector(setBadgeValue:), @selector(tl_setBadgeValue:))
    TLExchangeMethod(@selector(setBadgeColor:), @selector(tl_setBadgeColor:))
}

- (void)tl_setBadgeValue:(NSString *)badgeValue
{
    [self.tlBadge setBadgeValue:badgeValue];
    
    [self p_resetBadgeView];
}

- (void)tl_setBadgeColor:(UIColor *)badgeColor
{
    [self.tlBadge setBackgroundColor:badgeColor];
}

#pragma mark - # Private Methods
- (void)p_resetBadgeView
{
    [self.tlBadge removeFromSuperview];

    if (!self.tabBarControl || self.badgeValue == nil) {
        return;
    }
    
    [self.tabBarControl addSubview:self.tlBadge];
    [self.tlBadge.layer setZPosition:100];

    CGSize size = [TLBadge badgeSizeWithValue:self.badgeValue];
    CGFloat x, y;
    CGFloat h = size.height;
    CGFloat w = MIN(size.width, self.tabBarControl.frame.size.width * 0.7);
    if ([self.badgeValue isEqualToString:@""]) {
        x = self.tabBarControl.frame.size.width * 0.63;
        y = 3.5;
    }
    else {
        x = self.tabBarControl.frame.size.width * 0.58;
        y = 2;
    }

    [self.tlBadge setFrame:CGRectMake(x, y, w, h)];
}

#pragma mark - # Getter & Setters
- (TLBadge *)tlBadge
{
    TLBadge *badge = objc_getAssociatedObject(self, tl_badge);
    if (!badge) {
        badge = [[TLBadge alloc] init];
        [badge setUserInteractionEnabled:NO];
        objc_setAssociatedObject(self, tl_badge, badge, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return badge;
}

- (NSString *)badgeValue
{
    return self.tlBadge.badgeValue;
}

- (UIColor *)badgeColor
{
    return self.tlBadge.backgroundColor;
}

- (void)setTabBarControl:(UIControl *)tabBarControl
{
    objc_setAssociatedObject(self, tl_tabBarControl, tabBarControl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self p_resetBadgeView];
}
- (UIControl *)tabBarControl
{
    return objc_getAssociatedObject(self, tl_tabBarControl);
}

- (void)setIsPlusButton:(BOOL)isPlusButton
{
    objc_setAssociatedObject(self, tl_isPlusButton, @(isPlusButton), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isPlusButton
{
    return [objc_getAssociatedObject(self, tl_isPlusButton) boolValue];
}

- (void)setClickActionBlock:(BOOL (^)())clickActionBlock
{
    objc_setAssociatedObject(self, tl_actionBlock, clickActionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL (^)())clickActionBlock
{
    return objc_getAssociatedObject(self, tl_actionBlock);
}


@end
