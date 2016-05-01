//
//  TLDiscoverViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDiscoverViewController.h"
#import "TLDiscoverHelper.h"

#import "TLMomentsViewController.h"
#import "TLScanningViewController.h"
#import "TLShakeViewController.h"
#import "TLBottleViewController.h"
#import "TLShoppingViewController.h"
#import "TLGameViewController.h"

@interface TLDiscoverViewController ()

@property (nonatomic, strong) TLMomentsViewController *momentsVC;

@property (nonatomic, strong) TLDiscoverHelper *discoverHelper;

@end

@implementation TLDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"发现"];
    
    self.discoverHelper = [[TLDiscoverHelper alloc] init];
    self.data = self.discoverHelper.discoverMenuData;
}

#pragma mark - Delegate - 
//MARK: UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLMenuItem *item = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    if ([item.title isEqualToString:@"朋友圈"]) {
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:self.momentsVC animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }
    if ([item.title isEqualToString:@"扫一扫"]) {
        TLScanningViewController *scannerVC = [[TLScanningViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:scannerVC animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }
    else if ([item.title isEqualToString:@"摇一摇"]) {
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
    else if ([item.title isEqualToString:@"游戏"]) {
        TLGameViewController *gameVC = [[TLGameViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:gameVC animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

#pragma mark - # Getter 
- (TLMomentsViewController *)momentsVC
{
    if (_momentsVC == nil) {
        _momentsVC = [[TLMomentsViewController alloc] init];
    }
    return _momentsVC;
}

@end
