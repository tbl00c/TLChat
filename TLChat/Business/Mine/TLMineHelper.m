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
    TLMenuItem *item0 = TLCreateMenuItem(nil, nil);
    TLMenuItem *item1 = TLCreateMenuItem(@"mine_album", @"相册");
    TLMenuItem *item2 = TLCreateMenuItem(@"mine_favorites", @"收藏");
    TLMenuItem *item3 = TLCreateMenuItem(@"mine_wallet", @"钱包");
    TLMenuItem *item4 = TLCreateMenuItem(@"mine_card", @"优惠券");
    TLMenuItem *item5 = TLCreateMenuItem(@"mine_expression", @"表情");
    TLMenuItem *item6 = TLCreateMenuItem(@"mine_setting", @"设置");
    [self.mineMenuData addObjectsFromArray:@[@[item0], @[item1, item2, item3, item4], @[item5], @[item6]]];
}

@end
