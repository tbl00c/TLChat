
//
//  TLUser.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLUser.h"

@implementation TLUser

- (id) initWithUserID:(NSString *)userID avatarPath:(NSString *)avatarPath remarkName:(NSString *)remarkName
{
    if (self = [super init]) {
        self.userID = userID;
        self.avatarPath = avatarPath;
        self.remarkName = remarkName;
    }
    return self;
}

@end
