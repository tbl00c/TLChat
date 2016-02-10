//
//  TLMineInfoHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMineInfoHelper.h"
#import "TLUserHelper.h"

@implementation TLMineInfoHelper

- (id) init
{
    if (self = [super init]) {
        self.mineInfoData = [[NSMutableArray alloc] init];
        [self p_initTestData];
    }
    return self;
}

- (void) p_initTestData
{
    TLSettingItem *item1 = TLCreateSettingItem(@"头像");
    item1.rightImageURL = [TLUserHelper sharedHelper].user.avatarURL;
    TLSettingItem *item2 = TLCreateSettingItem(@"名字");
    item2.subTitle = @"李伯坤";
    TLSettingItem *item3 = TLCreateSettingItem(@"微信号");
    item3.subTitle = @"li-bokun";
    item3.showDisclosureIndicator = NO;
    TLSettingItem *item4 = TLCreateSettingItem(@"我的二维码");
    item4.rightImagePath = @"mine_cell_myQR";
    TLSettingItem *item5 = TLCreateSettingItem(@"我的地址");
    TLSettingGroup *group1 = TLCreateSettingGroup(nil, nil, (@[item1, item2, item3, item4, item5]));
    
    TLSettingItem *item6 = TLCreateSettingItem(@"性别");
    item6.subTitle = @"男";
    TLSettingItem *item7 = TLCreateSettingItem(@"地区");
    item7.subTitle = @"山东 滨州";
    TLSettingItem *item8 = TLCreateSettingItem(@"个性签名");
    item8.subTitle = @"新年快乐~";
    TLSettingGroup *group2 = TLCreateSettingGroup(nil, nil, (@[item6, item7, item8]));
    
    [self.mineInfoData addObjectsFromArray:@[group1, group2]];
}

@end
