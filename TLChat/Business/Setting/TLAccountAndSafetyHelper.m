//
//  TLAccountAndSafetyHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLAccountAndSafetyHelper.h"

@interface TLAccountAndSafetyHelper ()

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation TLAccountAndSafetyHelper

- (id)init
{
    if (self = [super init]) {
        self.data = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSMutableArray *)mineAccountAndSafetyDataByUserInfo:(TLUser *)userInfo
{
    TLSettingItem *username = TLCreateSettingItem(@"微信号");
    if (userInfo.username.length > 0) {
        username.subTitle = userInfo.username;
        username.showDisclosureIndicator = NO;
        username.disableHighlight = YES;
    }
    else {
        username.subTitle = @"未设置";
    }
    TLSettingGroup *group1 = TLCreateSettingGroup(nil, nil, @[username]);
    
    TLSettingItem *qqNumber = TLCreateSettingItem(@"QQ号");
    qqNumber.subTitle = userInfo.qqNumber;
    TLSettingItem *phoneNumber = TLCreateSettingItem(@"手机号");
    phoneNumber.subTitle = userInfo.phoneNumber;
    TLSettingItem *email = TLCreateSettingItem(@"邮箱地址");
    email.subTitle = userInfo.email;
    TLSettingGroup *group2 = TLCreateSettingGroup(nil, nil, (@[qqNumber, phoneNumber, email]));
    
    TLSettingItem *voiceLock = TLCreateSettingItem(@"声音锁");
    TLSettingItem *password = TLCreateSettingItem(@"微信密码");
    TLSettingItem *idProtect = TLCreateSettingItem(@"账号保护");
    idProtect.subTitle = @"已保护";
    idProtect.rightImagePath = @"setting_lockon";
    TLSettingItem *safetyCenter = TLCreateSettingItem(@"微信安全中心");
    TLSettingGroup *group3 = TLCreateSettingGroup(nil, @"如果遇到账号信息泄露、忘记密码、诈骗等账号问题，可前往微信安全中心。", (@[voiceLock, password, idProtect, safetyCenter]));
    
    [_data removeAllObjects];
    [_data addObjectsFromArray:@[group1, group2, group3]];
    return _data;
}

@end
