//
//  TLMomentsViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/5.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentsViewController.h"
#import "TLMomentsViewController+TableView.h"
#import "TLMomentsViewController+Proxy.h"

@interface TLMomentsViewController ()

@end

@implementation TLMomentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"朋友圈"];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 60.0f)]];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_camera"] style:UIBarButtonItemStylePlain actionBlick:^{
        
    }];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    [self registerCellForTableView:self.tableView];
    [self loadData];
}

@end
