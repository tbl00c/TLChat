//
//  TLMineHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMineHelper.h"
#import "TLMenuItem.h"

@implementation TLMineHelper

- (id) init
{
    if (self = [super init]) {
        self.mineMenuData = [[NSMutableArray alloc] init];
        [self p_initTestData];
    }
    return self;
}


- (void) p_initTestData
{
    TLMenuItem *item1 = [TLMenuItem createMenuWithIconPath:@"mine_album" title:@"相册"];
    TLMenuItem *item2 = [TLMenuItem createMenuWithIconPath:@"mine_favorites" title:@"收藏"];
    TLMenuItem *item3 = [TLMenuItem createMenuWithIconPath:@"mine_wallet" title:@"钱包"];
    TLMenuItem *item4 = [TLMenuItem createMenuWithIconPath:@"mint_card" title:@"优惠券"];
    TLMenuItem *item5 = [TLMenuItem createMenuWithIconPath:@"mine_expression" title:@"表情"];
    TLMenuItem *item6 = [TLMenuItem createMenuWithIconPath:@"mine_setting" title:@"设置"];
    [self.mineMenuData addObjectsFromArray:@[@[item1, item2, item3, item4], @[item5], @[item6]]];
}

@end
