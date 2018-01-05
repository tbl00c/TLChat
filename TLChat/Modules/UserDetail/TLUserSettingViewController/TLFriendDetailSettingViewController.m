//
//  TLFriendDetailSettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendDetailSettingViewController.h"
#import "TLFriendHelper+Detail.h"
#import "TLFriendHelper.h"

@interface TLFriendDetailSettingViewController ()

@end

@implementation TLFriendDetailSettingViewController

- (instancetype)initWithUserModel:(TLUser *)userModel
{
    if (self = [super init]) {
        _userModel = userModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"资料设置"];
    
    self.data = [[TLFriendHelper sharedFriendHelper] friendDetailSettingArrayByUserInfo:self.userModel];
}



@end
