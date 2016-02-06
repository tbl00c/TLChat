//
//  TLUserHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLUserHelper.h"
#import "TLUser.h"

static TLUserHelper *helper;

@implementation TLUserHelper

+ (TLUserHelper *) sharedHelper
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        helper = [[TLUserHelper alloc] init];
    });
    return helper;
}

- (id) init
{
    if (self = [super init]) {
        self.user = [[TLUser alloc] init];
        self.user.avatarPath = @"10.jpeg";
        self.user.nikeName = @"李伯坤";
        self.user.username = @"li-bokun";
    }
    return self;
}

@end
