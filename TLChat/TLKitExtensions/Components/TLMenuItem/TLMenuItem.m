//
//  TLMenuItem.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/17.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLMenuItem.h"
#import <TLTabBarController/TLBadge.h>

TLMenuItem *createMenuItem(NSString *icon, NSString *title)
{
    TLMenuItem *item = [[TLMenuItem alloc] init];
    [item setIconName:icon];
    [item setTitle:title];
    return item;
}

@implementation TLMenuItem

- (void)setBadge:(NSString *)badge
{
    _badge = badge;
    _badgeSize = [TLBadge badgeSizeWithValue:badge];
}

- (void)setRightIconURL:(NSString *)rightIconURL withRightIconBadge:(BOOL)rightIconBadge
{
    [self setRightIconURL:rightIconURL];
    [self setShowRightIconBadge:rightIconBadge];
}

- (BOOL)showRightIconBadge
{
    if (!self.rightIconURL) {
        return NO;
    }
    return _showRightIconBadge;
}

@end
