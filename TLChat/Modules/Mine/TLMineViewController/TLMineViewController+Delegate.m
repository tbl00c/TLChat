//
//  TLMineViewController+Delegate.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLMineViewController+Delegate.h"
#import "TLMineInfoViewController.h"
#import "TLWalletViewController.h"
#import "TLExpressionViewController.h"
#import "TLMineSettingViewController.h"
#import "TLMenuItem.h"

@implementation TLMineViewController (Delegate)

- (void)collectionViewDidSelectItem:(TLMenuItem *)dataModel sectionTag:(NSInteger)sectionTag cellTag:(NSInteger)cellTag className:(NSString *)className indexPath:(NSIndexPath *)indexPath
{
    if (cellTag == TLMineCellTagUserInfo) {
        TLMineInfoViewController *mineInfoVC = [[TLMineInfoViewController alloc] init];
        PushVC(mineInfoVC);
    }
    else if (cellTag == TLMineCellTagWallet) {
        TLWalletViewController *walletVC = [[TLWalletViewController alloc] init];
        PushVC(walletVC);
    }
    else if (cellTag == TLMineCellTagExpression) {
        TLExpressionViewController *expressionVC = [[TLExpressionViewController alloc] init];
        PushVC(expressionVC);
    }
    else if (cellTag == TLMineCellTagSetting) {
        TLMineSettingViewController *settingVC = [[TLMineSettingViewController alloc] init];
        PushVC(settingVC);
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
