//
//  TLFriendDetailViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendDetailViewController.h"
#import "TLUser.h"

@implementation TLFriendDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)setUser:(TLUser *)user
{
    _user = user;
    [self.navigationItem setTitle:user.showName];
}

@end
