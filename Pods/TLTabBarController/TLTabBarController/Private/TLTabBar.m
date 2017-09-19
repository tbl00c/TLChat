//
//  TLTabBar.m
//  TLKit
//
//  Created by 李伯坤 on 2017/7/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLTabBar.h"
#import "UITabBarItem+TLPrivateExtension.h"

@interface TLTabBar ()

@property (nonatomic, strong, readonly) NSArray *barControlItems;

@end

@implementation TLTabBar

- (id)init
{
    if (self = [super init]) {
        self.plusButtonImageOffset = 18;
        [self setBarTintColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self p_resetImageOrigin];          // 重置图片位置
    [self p_resetTabBarItems];          // 重置TabBarItem持有的Control
}

// 响应区域
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if (view) {
        return view;
    }
    for (UITabBarItem *tabBarItem in self.items) {
        if (tabBarItem.isPlusButton && tabBarItem.tabBarControl) {
            CGRect rect = tabBarItem.tabBarControl.frame;
            if (point.x > rect.origin.x && point.x < rect.origin.x + rect.size.width && point.y < rect.origin.y + rect.size.height && point.y > rect.origin.y - self.plusButtonImageOffset) {
                return tabBarItem.tabBarControl;
            }
        }
    }
    return nil;
}

#pragma mark - # Private Methods
/// 重置TabBarItem持有的Control
- (void)p_resetTabBarItems
{
    NSArray *controlItems = self.barControlItems;
    if (controlItems.count != self.items.count) {
        NSLog(@"p_resetTabBarItems error");
        return;
    }
    for (int i = 0; i < self.items.count; i++) {
        UITabBarItem *item = self.items[i];
        UIControl *control = controlItems[i];
        [item setTabBarControl:control];
    }
}

/// 重置图片位置
- (void)p_resetImageOrigin
{
    [self.items enumerateObjectsUsingBlock:^(UITabBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.title.length > 0) {
            if (obj.isPlusButton) {
                obj.imageInsets = UIEdgeInsetsMake(-self.plusButtonImageOffset, 0, self.plusButtonImageOffset, 0);
            }
            else {
                obj.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            }
        }
        else {
            obj.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
        }
    }];
}

#pragma mark - # Getters
- (NSArray *)barControlItems
{
    NSArray *barItems = [self.subviews sortedArrayUsingComparator:^NSComparisonResult(UIView * formerView, UIView * latterView) {
        CGFloat startX = formerView.frame.origin.x;
        CGFloat endX = latterView.frame.origin.x;
        return startX > endX ? NSOrderedDescending : NSOrderedAscending;
    }];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (UIControl *control in barItems) {
        if ([control isKindOfClass:[NSClassFromString(@"UITabBarButton") class]]) {
            [data addObject:control];
        }
    }
    return data;
}

@end
