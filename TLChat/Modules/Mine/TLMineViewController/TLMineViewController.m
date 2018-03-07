//
//  TLMineViewController.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/6.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLMineViewController.h"
#import "TLMenuItem.h"
#import "TLUserHelper.h"

#import "TLMineInfoViewController.h"
#import "TLWalletViewController.h"
#import "TLExpressionViewController.h"
#import "TLSettingViewController.h"

typedef NS_ENUM(NSInteger, TLMineSectionTag) {
    TLMineSectionTagUserInfo,
    TLMineSectionTagWallet,
    TLMineSectionTagFounction,
    TLMineSectionTagSetting,
};

@implementation TLMineViewController

- (id)init
{
    if (self = [super init]) {
        initTabBarItem(self.tabBarItem, LOCSTR(@"我"), @"tabbar_me", @"tabbar_meHL");
        [self.tabBarItem setBadgeValue:@""];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self.navigationItem setTitle:LOCSTR(@"我")];
    
    [self loadMenus];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if (!CGRectEqualToRect(self.view.bounds, self.collectionView.frame)) {
        [self.collectionView setFrame:self.view.bounds];
    }
}

#pragma mark - # UI
- (void)loadMenus
{
    @weakify(self);
    self.clear();
    TLUser *user = [TLUserHelper sharedHelper].user;
    
    // 用户信息
    {
        NSInteger sectionTag = TLMineSectionTagUserInfo;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
        self.addCell(@"TLMineHeaderCell").toSection(sectionTag).withDataModel(user).selectedAction(^ (id data) {
            @strongify(self);
            TLMineInfoViewController *mineInfoVC = [[TLMineInfoViewController alloc] init];
            PushVC(mineInfoVC);
        });
    }
    
    // 钱包
    {
        NSInteger sectionTag = TLMineSectionTagWallet;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        TLMenuItem *wallet = createMenuItem(@"mine_wallet", LOCSTR(@"钱包"));
        [wallet setSubTitle:@"新入账1024元"];
        [wallet setBadge:@""];
        self.addCell(CELL_MENU_ITEM).toSection(sectionTag).withDataModel(wallet).selectedAction(^ (id data) {
            @strongify(self);
            TLWalletViewController *walletVC = [[TLWalletViewController alloc] init];
            PushVC(walletVC);
        });
    }
    
    // 功能
    {
        NSInteger sectionTag = TLMineSectionTagFounction;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        // 收藏
//        TLMenuItem *collect = createMenuItem(@"mine_favorites", LOCSTR(@"收藏"));
//        self.addCell(CELL_MENU_ITEM).toSection(sectionTag).withDataModel(collect);
        
        // 相册
        TLMenuItem *album = createMenuItem(@"mine_album", LOCSTR(@"相册"));
        self.addCell(CELL_MENU_ITEM).toSection(sectionTag).withDataModel(album);
        
        // 卡包
//        TLMenuItem *card = createMenuItem(@"mine_card", LOCSTR(@"卡包"));
//        self.addCell(CELL_MENU_ITEM).toSection(sectionTag).withDataModel(card);
        
        // 表情
        TLMenuItem *expression = createMenuItem(@"mine_expression", LOCSTR(@"表情"));
        [expression setBadge:@"NEW"];
        self.addCell(CELL_MENU_ITEM).toSection(sectionTag).withDataModel(expression).selectedAction(^ (id data) {
            @strongify(self);
            TLExpressionViewController *expressionVC = [[TLExpressionViewController alloc] init];
            PushVC(expressionVC);
        });
    }
    
    // 设置
    {
        NSInteger sectionTag = TLMineSectionTagSetting;
        self.addSection(TLMineSectionTagSetting).sectionInsets(UIEdgeInsetsMake(20, 0, 40, 0));
        TLMenuItem *setting = createMenuItem(@"mine_setting", LOCSTR(@"设置"));
        self.addCell(CELL_MENU_ITEM).toSection(TLMineSectionTagSetting).withDataModel(setting).selectedAction(^ (id data) {
            @strongify(self);
            TLSettingViewController *settingVC = [[TLSettingViewController alloc] init];
            PushVC(settingVC);
        });
    }
    
    [self reloadView];
    [self resetTabBarBadge];
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

#pragma mark - # Delegate
- (void)collectionViewDidSelectItem:(TLMenuItem *)dataModel sectionTag:(NSInteger)sectionTag cellTag:(NSInteger)cellTag className:(NSString *)className indexPath:(NSIndexPath *)indexPath
{
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
                [self reloadView];
            });
        }
    }
}

@end
