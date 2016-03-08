//
//  TLChatDetailHelper.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLSettingGroup.h"
#import "TLGroup.h"

@interface TLChatDetailHelper : NSObject

- (NSMutableArray *)chatDetailDataByUserInfo:(TLUser *)userInfo;

- (NSMutableArray *)chatDetailDataByGroupInfo:(TLGroup *)groupInfo;

@end
