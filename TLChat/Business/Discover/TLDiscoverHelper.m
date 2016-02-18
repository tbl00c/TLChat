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
    item1.rightIconURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
    item1.showRightRedPoint = YES;
    TLMenuItem *item2 = TLCreateMenuItem(@"discover_QRcode", @"扫一扫");
    TLMenuItem *item3 = TLCreateMenuItem(@"discover_shake", @"摇一摇");
    TLMenuItem *item4 = TLCreateMenuItem(@"discover_location", @"附近的人");
    TLMenuItem *item5 = TLCreateMenuItem(@"discover_bottle", @"漂流瓶");
    TLMenuItem *item6 = TLCreateMenuItem(@"discover_shopping", @"购物");
    TLMenuItem *item7 = TLCreateMenuItem(@"discover_game", @"游戏");
    item7.rightIconURL = @"http://qq1234.org/uploads/allimg/140404/3_140404151205_8.jpg";
    item7.subTitle = @"英雄联盟计算器版";
    item7.showRightRedPoint = YES;
    [self.discoverMenuData addObjectsFromArray:@[@[item1], @[item2, item3], @[item4, item5], @[item6, item7]]];
}

@end
