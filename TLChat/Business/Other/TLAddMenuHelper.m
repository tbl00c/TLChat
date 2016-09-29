//
//  TLAddMenuHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/11.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLAddMenuHelper.h"

@interface TLAddMenuHelper ()

@property (nonatomic, strong) NSArray *menuItemTypes;

@end

@implementation TLAddMenuHelper

- (id)init
{
    if (self = [super init]) {
        _menuItemTypes = @[@"0", @"1", @"2", @"3"];
    }
    return self;
}

- (NSMutableArray *)menuData
{
    if (_menuData == nil) {
        _menuData = [[NSMutableArray alloc] init];
        for (NSString *type in self.menuItemTypes) {
            TLAddMenuItem *item = [self p_getMenuItemByType:[type integerValue]];
            [_menuData addObject:item];
        }
    }
    return _menuData;
}

- (TLAddMenuItem *)p_getMenuItemByType:(TLAddMneuType)type
{
    switch (type) {
        case TLAddMneuTypeGroupChat:        // 群聊
            return  [TLAddMenuItem createWithType:TLAddMneuTypeGroupChat title:@"发起群聊" iconPath:@"nav_menu_groupchat" className:@""];
            break;
        case TLAddMneuTypeAddFriend:        // 添加好友
            return [TLAddMenuItem createWithType:TLAddMneuTypeAddFriend title:@"添加朋友" iconPath:@"nav_menu_addfriend" className:@"TLAddFriendViewController"];
            break;
        case TLAddMneuTypeWallet:           // 收付款
            return [TLAddMenuItem createWithType:TLAddMneuTypeWallet title:@"收付款" iconPath:@"nav_menu_wallet" className:@"TLWalletViewController"];
            break;
        case TLAddMneuTypeScan:             // 扫一扫
            return [TLAddMenuItem createWithType:TLAddMneuTypeScan title:@"扫一扫" iconPath:@"nav_menu_scan" className:@"TLScanningViewController"];
            break;
        default:
            break;
    }
}

@end
