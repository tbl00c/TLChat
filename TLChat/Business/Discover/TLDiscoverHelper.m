//
//  TLDiscoverHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDiscoverHelper.h"
#import "TLMenuItem.h"

@implementation TLDiscoverHelper

- (id) init
{
    if (self = [super init]) {
        self.discoverMenuData = [[NSMutableArray alloc] init];
        [self p_initTestData];
    }
    return self;
}


- (void) p_initTestData
{
    TLMenuItem *item1 = [TLMenuItem createMenuWithIconPath:@"discover_album" title:@"朋友圈"];
    TLMenuItem *item2 = [TLMenuItem createMenuWithIconPath:@"discover_QRcode" title:@"扫一扫"];
    TLMenuItem *item3 = [TLMenuItem createMenuWithIconPath:@"discover_shake" title:@"摇一摇"];
    TLMenuItem *item4 = [TLMenuItem createMenuWithIconPath:@"discover_location" title:@"附近的人"];
    TLMenuItem *item5 = [TLMenuItem createMenuWithIconPath:@"discover_bottle" title:@"漂流瓶"];
    TLMenuItem *item6 = [TLMenuItem createMenuWithIconPath:@"discover_shopping" title:@"购物"];
    TLMenuItem *item7 = [TLMenuItem createMenuWithIconPath:@"discover_game" title:@"游戏"];
    [self.discoverMenuData addObjectsFromArray:@[@[item1], @[item2, item3], @[item4, item5], @[item6, item7]]];
}

@end
