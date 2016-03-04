//
//  TLAccountAndSafetyHelper.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLSettingGroup.h"

@interface TLAccountAndSafetyHelper : NSObject

- (NSMutableArray *)mineAccountAndSafetyDataByUserInfo:(TLUser *)userInfo;

@end
