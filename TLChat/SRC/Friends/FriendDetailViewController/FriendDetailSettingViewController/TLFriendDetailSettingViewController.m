//
//  TLFriendDetailSettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendDetailSettingViewController.h"
#import "TLFriendHelper+Detail.h"

@interface TLFriendDetailSettingViewController ()

@end

@implementation TLFriendDetailSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"资料设置"];
    
    self.data = [[TLFriendHelper sharedFriendHelper] friendDetailSettingArrayByUserInfo:self.user];
}



@end
