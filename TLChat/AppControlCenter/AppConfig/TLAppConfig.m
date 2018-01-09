//
//  TLAppConfig.m
//  TLChat
//
//  Created by 李伯坤 on 2017/9/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLAppConfig.h"
#import "TLAddMenuItem.h"

@implementation TLAppConfig

+ (TLAppConfig *)sharedConfig
{
    static TLAppConfig *config;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[self alloc] init];
    });
    return config;
}

#pragma mark - # Private Methos
- (TLAddMenuItem *)p_getMenuItemByType:(TLAddMneuType)type
{
    switch (type) {
        case TLAddMneuTypeGroupChat:        // 群聊
            return [TLAddMenuItem createWithType:TLAddMneuTypeGroupChat title:LOCSTR(@"发起群聊") iconPath:@"nav_menu_groupchat" className:@""];
            break;
        case TLAddMneuTypeAddFriend:        // 添加好友
            return [TLAddMenuItem createWithType:TLAddMneuTypeAddFriend title:LOCSTR(@"添加朋友") iconPath:@"nav_menu_addfriend" className:@"TLAddContactsViewController"];
            break;
        case TLAddMneuTypeWallet:           // 收付款
            return [TLAddMenuItem createWithType:TLAddMneuTypeWallet title:LOCSTR(@"收付款") iconPath:@"nav_menu_wallet" className:@"TLWalletViewController"];
            break;
        case TLAddMneuTypeScan:             // 扫一扫
            return [TLAddMenuItem createWithType:TLAddMneuTypeScan title:LOCSTR(@"扫一扫") iconPath:@"nav_menu_scan" className:@"TLScanningViewController"];
            break;
        default:
            break;
    }
    return nil;
}

#pragma mark - # Getters
- (NSString *)version
{
    NSString *shortVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *buildID = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    NSString *version = [NSString stringWithFormat:@"%@ (%@)", shortVersion, buildID];

    return version;
}

- (NSArray *)addMenuItems
{
    if (!_addMenuItems) {
        return @[[self p_getMenuItemByType:0],
                 [self p_getMenuItemByType:1],
                 [self p_getMenuItemByType:2],
                 [self p_getMenuItemByType:3],];
    }
    return _addMenuItems;
}

@end
