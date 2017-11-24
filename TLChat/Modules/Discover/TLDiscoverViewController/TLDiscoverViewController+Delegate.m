//
//  TLDiscoverViewController+Delegate.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/17.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLDiscoverViewController+Delegate.h"
#import "TLMomentsViewController.h"
#import "TLScanningViewController.h"
#import "TLShakeViewController.h"
#import "TLBottleViewController.h"
#import "TLGameViewController.h"
#import "TLGameViewController.h"

#import "TLMenuItem.h"

@implementation TLDiscoverViewController (Delegate)

- (void)collectionViewDidSelectItem:(TLMenuItem *)dataModel sectionTag:(NSInteger)sectionTag cellTag:(NSInteger)cellTag className:(NSString *)className indexPath:(NSIndexPath *)indexPath
{
    if (cellTag == TLDiscoverCellTagMoments) {          // 朋友圈
        if (!self.momentsVC) {
            self.momentsVC = [[TLMomentsViewController alloc] init];
        }
        PushVC(self.momentsVC);
    }
    else if (cellTag == TLDiscoverCellTagScaner) {       // 扫一扫
        TLScanningViewController *scannerVC = [[TLScanningViewController alloc] init];
        PushVC(scannerVC);
    }
    else if (cellTag == TLDiscoverCellTagShake) {       // 摇一摇
        TLShakeViewController *shakeVC = [[TLShakeViewController alloc] init];
        PushVC(shakeVC);
    }
    else if (cellTag == TLDiscoverCellTagRead) {        // 看一看
        TLWebViewController *webVC = [[TLWebViewController alloc] initWithUrl:@"http://www.jianshu.com/u/8dabd0639b26/"];
        [webVC setTitle:dataModel.title];
        PushVC(webVC);
    }
    else if (cellTag == TLDiscoverCellTagSearch) {      // 搜一搜
        TLWebViewController *webVC = [[TLWebViewController alloc] initWithUrl:@"https://www.zhihu.com/people/li-bo-kun-40/activities"];
        [webVC setTitle:dataModel.title];
        PushVC(webVC);
    }
    else if (cellTag == TLDiscoverCellTagNearby) {      // 附近的人
        
    }
    else if (cellTag == TLDiscoverCellTagBottle) {      // 漂流瓶
        TLBottleViewController *bottleVC = [[TLBottleViewController alloc] init];
        PushVC(bottleVC);
    }
    else if (cellTag == TLDiscoverCellTagShopping) {    // 购物
        TLWebViewController *webVC = [[TLWebViewController alloc] initWithUrl:@"http://m.zhuanzhuan.com"];
        [webVC setTitle:@"转转"];
        PushVC(webVC);
    }
    else if (cellTag == TLDiscoverCellTagGame) {        // 游戏
        TLGameViewController *gameVC = [[TLGameViewController alloc] init];
        PushVC(gameVC);
    }
    else if (cellTag == TLDiscoverCellTagProgram) {     // 小程序
        TLWebViewController *webVC = [[TLWebViewController alloc] initWithUrl:@"http://libokun.com"];
        PushVC(webVC)
    }

    if ([dataModel isKindOfClass:[TLMenuItem class]]) {
        BOOL needResetTabBarBadge = (dataModel.badge || (dataModel.rightIconURL && dataModel.showRightIconBadge));
        BOOL hasDesc = dataModel.subTitle.length > 0 || dataModel.rightIconURL.length > 0;
        
        if (needResetTabBarBadge) {
            [dataModel setBadge:nil];
            [self resetTabBarBadge];
        }
        if (hasDesc) {
            [dataModel setSubTitle:nil];
            [dataModel setRightIconURL:nil];
        }
        
        if (needResetTabBarBadge || hasDesc) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self reloadCellAtIndexPath:indexPath];
            });
        }
    }
}

- (void)resetTabBarBadge
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *badgeValue;
        NSArray *data = [self allDataModelArray];
        for (NSArray *section in data) {
            for (id item in section) {
                if ([item isKindOfClass:[TLMenuItem class]]) {
                    if ([(TLMenuItem *)item badge] || [(TLMenuItem *)item showRightIconBadge]) {
                        badgeValue = @"";
                        break;
                    }
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tabBarItem setBadgeValue:badgeValue];
        });
    });
}

@end
