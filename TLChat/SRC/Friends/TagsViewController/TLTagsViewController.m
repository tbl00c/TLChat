//
//  TLTagsViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTagsViewController.h"
#import "TLTagsViewController+Delegate.h"

@implementation TLTagsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"标签"];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self registerCellClass];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"新建" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDown:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    self.data = [TLFriendHelper sharedFriendHelper].tagsData;
}

#pragma mark - Event Response -
- (void)rightBarButtonDown:(UIBarButtonItem *)sender
{
    
}

@end
