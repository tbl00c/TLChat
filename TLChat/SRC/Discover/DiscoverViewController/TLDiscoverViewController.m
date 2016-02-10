//
//  TLDiscoverViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDiscoverViewController.h"
#import "TLDiscoverHelper.h"

#import "TLShoppingViewController.h"

@interface TLDiscoverViewController ()

@property (nonatomic, strong) TLDiscoverHelper *discoverHelper;

@end

@implementation TLDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"发现"];
    
    self.discoverHelper = [[TLDiscoverHelper alloc] init];
    self.data = self.discoverHelper.discoverMenuData;
}

#pragma mark - 
#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLMenuItem *item = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    if ([item.title isEqualToString:@"购物"]) {
        TLShoppingViewController *webVC = [[TLShoppingViewController alloc] init];
        webVC.url = @"http://wq.jd.com/";
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:webVC animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
