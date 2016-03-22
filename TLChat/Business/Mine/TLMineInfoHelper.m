//
//  TLMineInfoHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMineInfoHelper.h"

@interface TLMineInfoHelper ()

@property (nonatomic, strong) NSMutableArray *mineInfoData;

@end

@implementation TLMineInfoHelper

- (id) init
{
    if (self = [super init]) {
        _mineInfoData = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSMutableArray *)mineInfoDataByUserInfo:(TLUser *)userInfo
{
    TLSettingItem *avatar = TLCreateSettingItem(@"头像");
    avatar.rightImageURL = userInfo.avatarURL;
    TLSettingItem *nikename = TLCreateSettingItem(@"名字");
    nikename.subTitle = userInfo.nikeName.length > 0 ? userInfo.nikeName : @"未设置";
    TLSettingItem *username = TLCreateSettingItem(@"微信号");
    if (userInfo.username.length > 0) {
        username.subTitle = userInfo.username;
        username.showDisclosureIndicator = NO;
        username.disableHighlight = YES;
    }
    else {
        username.subTitle = @"未设置";
    }
    
    TLSettingItem *qrCode = TLCreateSettingItem(@"我的二维码");
    qrCode.rightImagePath = @"mine_cell_myQR";
    TLSettingItem *location = TLCreateSettingItem(@"我的地址");
    TLSettingGroup *group1 = TLCreateSettingGroup(nil, nil, (@[avatar, nikename, username, qrCode, location]));
    
    TLSettingItem *sex = TLCreateSettingItem(@"性别");
    sex.subTitle = userInfo.detailInfo.sex;
    TLSettingItem *city = TLCreateSettingItem(@"地区");
    city.subTitle = userInfo.detailInfo.location;
    TLSettingItem *motto = TLCreateSettingItem(@"个性签名");
    motto.subTitle = userInfo.detailInfo.motto.length > 0 ? userInfo.detailInfo.motto : @"未填写";
    TLSettingGroup *group2 = TLCreateSettingGroup(nil, nil, (@[sex, city, motto]));
    
    [_mineInfoData removeAllObjects];
    [_mineInfoData addObjectsFromArray:@[group1, group2]];
    return _mineInfoData;
}

@end
