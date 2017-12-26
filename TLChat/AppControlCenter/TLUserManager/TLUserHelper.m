//
//  TLUserHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLUserHelper.h"
#import "TLDBUserStore.h"

@implementation TLUserHelper
@synthesize user = _user;

+ (TLUserHelper *)sharedHelper
{
    static TLUserHelper *helper;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        helper = [[TLUserHelper alloc] init];
    });
    return helper;
}

- (void)loginTestAccount
{
    TLUser *user = [[TLUser alloc] init];
    user.userID = @"1000";
    user.avatarURL = @"http://p1.qq181.com/cms/120506/2012050623111097826.jpg";
    user.nikeName = @"李伯坤";
    user.username = @"li-bokun";
    user.detailInfo.qqNumber = @"1159197873";
    user.detailInfo.email = @"libokun@126.com";
    user.detailInfo.location = @"山东 滨州";
    user.detailInfo.sex = @"男";
    user.detailInfo.motto = @"Hello world!";
    user.detailInfo.momentsWallURL = @"http://pic1.win4000.com/wallpaper/c/5791e49b37a5c.jpg";

    [self setUser:user];
}

- (void)setUser:(TLUser *)user
{
    _user = user;
    TLDBUserStore *userStore = [[TLDBUserStore alloc] init];
    if (![userStore updateUser:user]) {
        DDLogError(@"登录数据存库失败");
    }

    [[NSUserDefaults standardUserDefaults] setObject:user.userID forKey:@"loginUid"];
}
- (TLUser *)user
{
    if (!_user) {
        if (self.userID.length > 0) {
            TLDBUserStore *userStore = [[TLDBUserStore alloc] init];
            _user = [userStore userByID:self.userID];
            _user.detailInfo.momentsWallURL = @"http://pic1.win4000.com/wallpaper/c/5791e49b37a5c.jpg";
            if (!_user) {
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"loginUid"];
            }
        }
    }
    return _user;
}

- (NSString *)userID
{
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginUid"];
    return uid;
}

- (BOOL)isLogin
{
    return self.user.userID.length > 0;
}

@end
