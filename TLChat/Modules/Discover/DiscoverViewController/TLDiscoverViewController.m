//
//  TLDiscoverViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDiscoverViewController.h"
#import "TLMomentsViewController.h"
#import "TLScanningViewController.h"
#import "TLShakeViewController.h"
#import "TLBottleViewController.h"
#import "TLShoppingViewController.h"
#import "TLGameViewController.h"

@interface TLDiscoverViewController ()

@property (nonatomic, strong) TLMomentsViewController *momentsVC;

@end

@implementation TLDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"发现"];
    
    [self p_initMomentsData];
}

#pragma mark - # Delegate
//MARK: UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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

#pragma mark - # Private Methods
- (void)p_initMomentsData
{
    TLMenuItem *item1 = TLCreateMenuItem(@"discover_album", @"朋友圈");
    item1.rightIconURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
    item1.showRightRedPoint = YES;
    TLMenuItem *item2 = TLCreateMenuItem(@"discover_QRcode", @"扫一扫");
    TLMenuItem *item3 = TLCreateMenuItem(@"discover_shake", @"摇一摇");
    TLMenuItem *item4 = TLCreateMenuItem(@"discover_location", @"附近的人");
    TLMenuItem *item5 = TLCreateMenuItem(@"discover_bottle", @"漂流瓶");
    TLMenuItem *item6 = TLCreateMenuItem(@"discover_shopping", @"购物");
    TLMenuItem *item7 = TLCreateMenuItem(@"discover_game", @"游戏");
    item7.rightIconURL = @"http://qq1234.org/uploads/allimg/140404/3_140404151205_8.jpg";
    item7.subTitle = @"英雄联盟计算器版";
    item7.showRightRedPoint = YES;
    self.data = @[@[item1], @[item2, item3], @[item4, item5], @[item6, item7]].mutableCopy;
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
