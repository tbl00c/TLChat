//
//  TLUserHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLUserHelper.h"

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

- (NSString *)userID
{
    return self.user.userID;
}

- (id) init
{
    if (self = [super init]) {
        self.user = [[TLUser alloc] init];
        self.user.userID = @"1000";
        self.user.avatarURL = @"http://p1.qq181.com/cms/120506/2012050623111097826.jpg";
        self.user.nikeName = @"李伯坤";
        self.user.username = @"li-bokun";
        self.user.detailInfo.qqNumber = @"1159197873";
        self.user.detailInfo.email = @"libokun@126.com";
        self.user.detailInfo.location = @"山东 滨州";
        self.user.detailInfo.sex = @"男";
        self.user.detailInfo.motto = @"Hello world!";
        self.user.detailInfo.momentsWallURL = @"http://img06.tooopen.com/images/20160913/tooopen_sy_178786212749.jpg";
    }
    return self;
}

@end
