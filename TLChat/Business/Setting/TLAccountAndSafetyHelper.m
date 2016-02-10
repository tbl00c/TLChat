//
//  TLAccountAndSafetyHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLAccountAndSafetyHelper.h"

@implementation TLAccountAndSafetyHelper

- (id) init
{
    if (self = [super init]) {
        self.mineAccountAndSafetySettingData = [[NSMutableArray alloc] init];
        [self p_initTestData];
    }
    return self;
}

- (void) p_initTestData
{
    TLSettingItem *item1 = TLCreateSettingItem(@"微信号");
    item1.subTitle = @"li-bokun";
    item1.showDisclosureIndicator = NO;
    TLSettingGroup *group1 = TLCreateSettingGroup(nil, nil, @[item1]);
    
    TLSettingItem *item2 = TLCreateSettingItem(@"QQ号");
    item2.subTitle = @"123456";
    TLSettingItem *item3 = TLCreateSettingItem(@"手机号");
    item3.subTitle = @"18888888888";
    TLSettingItem *item4 = TLCreateSettingItem(@"邮箱地址");
    item4.subTitle = @"libokun@126.com";
    TLSettingGroup *group2 = TLCreateSettingGroup(nil, nil, (@[item2, item3, item4]));
    
    TLSettingItem *item5 = TLCreateSettingItem(@"声音锁");
    TLSettingItem *item6 = TLCreateSettingItem(@"微信密码");
    TLSettingItem *item7 = TLCreateSettingItem(@"账号保护");
    item7.subTitle = @"已保护";
    item7.rightImagePath = @"setting_lockon";
    TLSettingItem *item8 = TLCreateSettingItem(@"微信安全中心");
    TLSettingGroup *group3 = TLCreateSettingGroup(nil, @"如果遇到账号信息泄露、忘记密码、诈骗等账号问题，可前往微信安全中心。", (@[item5, item6, item7, item8]));
    
    [self.mineAccountAndSafetySettingData addObjectsFromArray:@[group1, group2, group3]];
}
@end
