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
    
    self.data = @[@[[TLInfo createInfoWithTitle:@"电话号码" subTitle:@"18888888888"],
                    [TLInfo createInfoWithTitle:@"标签" subTitle:@"同学"]],
                  @[[TLInfo createInfoWithTitle:@"地区" subTitle:@"山东 青岛"],
                    [TLInfo createInfoWithTitle:@"个人相册" subTitle:nil],
                    [TLInfo createInfoWithTitle:@"更多" subTitle:nil]]];
}


#pragma mark - Event Response -
- (void)rightBarButtonDown:(UIBarButtonItem *)sender
{

}

@end
