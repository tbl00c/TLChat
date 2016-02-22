//
//  TLDiscoverViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDiscoverViewController.h"
#import "TLDiscoverHelper.h"

#import "TLShakeViewController.h"
#import "TLBottleViewController.h"
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
    if ([item.title isEqualToString:@"摇一摇"]) {
        TLShakeViewController *shakeVC = [[TLShakeViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:shakeVC animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }
    else if ([item.title isEqualToString:@"漂流瓶"]) {
        TLBottleViewController *bottleVC = [[TLBottleViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:bottleVC animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }
    else if ([item.title isEqualToString:@"购物"]) {
        TLShoppingViewController *shoppingVC = [[TLShoppingViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:shoppingVC animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

@end
