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
    TLMenuItem *item1 = TLCreateMenuItem(@"discover_album", @"朋友圈");
    TLMenuItem *item2 = TLCreateMenuItem(@"discover_QRcode", @"扫一扫");
    TLMenuItem *item3 = TLCreateMenuItem(@"discover_shake", @"摇一摇");
    TLMenuItem *item4 = TLCreateMenuItem(@"discover_location", @"附近的人");
    TLMenuItem *item5 = TLCreateMenuItem(@"discover_bottle", @"漂流瓶");
    TLMenuItem *item6 = TLCreateMenuItem(@"discover_shopping", @"购物");
    TLMenuItem *item7 = TLCreateMenuItem(@"discover_game", @"游戏");
    [self.discoverMenuData addObjectsFromArray:@[@[item1], @[item2, item3], @[item4, item5], @[item6, item7]]];
}

@end
