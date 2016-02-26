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
    [self.navigationItem setTitle:@"详细资料"];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_more"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDown:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    self.data = @[@[[TLInfo createInfoWithTitle:@"测试 0-0" subTitle:nil]],
                  @[[TLInfo createInfoWithTitle:@"测试 1-0" subTitle:nil],
                    [TLInfo createInfoWithTitle:@"测试 1-1" subTitle:nil]]];
}


#pragma mark - Event Response -
- (void)rightBarButtonDown:(UIBarButtonItem *)sender
{

}

@end
