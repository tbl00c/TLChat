//
//  TLDiscoverViewController.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/6.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLDiscoverViewController.h"
#import "TLMomentsViewController.h"
#import "TLScanningViewController.h"
#import "TLShakeViewController.h"
#import "TLBottleViewController.h"
#import "TLGameViewController.h"
#import "TLGameViewController.h"

#import "TLMenuItem.h"

typedef NS_ENUM(NSInteger, TLDiscoverSectionTag) {
    TLDiscoverSectionTagMoments,
    TLDiscoverSectionTagFounction,
    TLDiscoverSectionTagStudy,
    TLDiscoverSectionTagSocial,
    TLDiscoverSectionTagLife,
    TLDiscoverSectionTagProgram,
};

typedef NS_ENUM(NSInteger, TLDiscoverCellTag) {
    TLDiscoverCellTagMoments,       // 好友圈
    TLDiscoverCellTagScaner,        // 扫一扫
    TLDiscoverCellTagShake,         // 摇一摇
    TLDiscoverCellTagRead,          // 看一看
    TLDiscoverCellTagSearch,        // 搜一搜
    TLDiscoverCellTagNearby,        // 附近的人
    TLDiscoverCellTagBottle,        // 漂流瓶
    TLDiscoverCellTagShopping,      // 购物
    TLDiscoverCellTagGame,          // 游戏
    TLDiscoverCellTagProgram,       // 小程序
};

@implementation TLDiscoverViewController

#pragma mark - # Life Cycle
- (id)init
{
    if (self = [super init]) {
        initTabBarItem(self.tabBarItem, LOCSTR(@"发现"), @"tabbar_discover", @"tabbar_discoverHL");
        [self.tabBarItem setBadgeValue:@""];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    [self.navigationItem setTitle:LOCSTR(@"发现")];
    [self loadMenus];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    self.momentsVC = nil;
}

#pragma mark - # UI
- (void)loadMenus
{
    @weakify(self);
    self.clear();
    
    // 好友圈
    {
        NSInteger sectionTag = TLDiscoverSectionTagMoments;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
        TLMenuItem *moments = createMenuItem(@"discover_album", LOCSTR(@"朋友圈"));
        [moments setRightIconURL:@"http://i01.pic.sogou.com/23112449ac395e72" withRightIconBadge:YES];
        self.addCell(CELL_MENU_ITEM).toSection(sectionTag).withDataModel(moments).selectedAction(^ (TLMenuItem *data) {
           @strongify(self);
            if (!self.momentsVC) {
                self.momentsVC = [[TLMomentsViewController alloc] init];
            }
            PushVC(self.momentsVC);
        });
    }
    
    // 功能
    {
        NSInteger sectionTag = TLDiscoverSectionTagFounction;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        // 扫一扫
        self.addCell(CELL_MENU_ITEM).toSection(sectionTag).withDataModel(createMenuItem(@"discover_scaner", LOCSTR(@"扫一扫"))).selectedAction(^ (TLMenuItem *data) {
            @strongify(self);
            TLScanningViewController *scannerVC = [[TLScanningViewController alloc] init];
            PushVC(scannerVC);
        });
        // 摇一摇
        self.addCell(CELL_MENU_ITEM).toSection(sectionTag).withDataModel(createMenuItem(@"discover_shake", LOCSTR(@"摇一摇"))).selectedAction(^ (TLMenuItem *data) {
            @strongify(self);
            TLShakeViewController *shakeVC = [[TLShakeViewController alloc] init];
            PushVC(shakeVC);
        });
    }
    
    // 学习
    {
        NSInteger sectionTag = TLDiscoverSectionTagStudy;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        // 看一看
        TLMenuItem *read = createMenuItem(@"discover_read", LOCSTR(@"看一看"));
        [read setBadge:@"2"];
        self.addCell(CELL_MENU_ITEM).toSection(sectionTag).withDataModel(read).viewTag(TLDiscoverCellTagRead).selectedAction(^ (TLMenuItem *data) {
            @strongify(self);
            TLWebViewController *webVC = [[TLWebViewController alloc] initWithUrl:@"http://www.jianshu.com/u/8dabd0639b26/"];
            [webVC setTitle:data.title];
            PushVC(webVC);
        });
        // 搜一搜
        self.addCell(CELL_MENU_ITEM).toSection(sectionTag).withDataModel(createMenuItem(@"discover_search", LOCSTR(@"搜一搜"))).selectedAction(^ (TLMenuItem *data) {
            @strongify(self);
            TLWebViewController *webVC = [[TLWebViewController alloc] initWithUrl:@"https://www.zhihu.com/people/li-bo-kun-40/activities"];
            [webVC setTitle:data.title];
            PushVC(webVC);
        });
    }
    
    // 社交
    {
        NSInteger sectionTag = TLDiscoverSectionTagSocial;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        // 附近的人
//        self.addCell(CELL_MENU_ITEM).toSection(sectionTag).withDataModelcreateMenuItem(@"discover_location", LOCSTR(@"附近的人")).selectedAction(^ (TLMenuItem *data) {
//            @strongify(self);
//            
//        });
        // 漂流瓶
        self.addCell(CELL_MENU_ITEM).toSection(sectionTag).withDataModel(createMenuItem(@"discover_bottle", LOCSTR(@"漂流瓶"))).selectedAction(^ (TLMenuItem *data) {
            @strongify(self);
            TLBottleViewController *bottleVC = [[TLBottleViewController alloc] init];
            PushVC(bottleVC);
        });
    }
    
    // 生活
    {
        NSInteger sectionTag = TLDiscoverSectionTagLife;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        // 购物
        TLMenuItem *shopping = createMenuItem(@"discover_shopping", LOCSTR(@"购物"));
        self.addCell(CELL_MENU_ITEM).toSection(sectionTag).withDataModel(shopping).selectedAction(^ (TLMenuItem *data) {
            @strongify(self);
            TLWebViewController *webVC = [[TLWebViewController alloc] initWithUrl:@"http://m.zhuanzhuan.com"];
            [webVC setTitle:@"转转"];
            PushVC(webVC);
        });
        // 游戏
        TLMenuItem *game = createMenuItem(@"discover_game", LOCSTR(@"游戏"));
        [game setRightIconURL:@"http://qq1234.org/uploads/allimg/140404/3_140404151205_8.jpg" withRightIconBadge:YES];
        [game setSubTitle:@"英雄联盟计算器版"];
        self.addCell(CELL_MENU_ITEM).toSection(sectionTag).withDataModel(game).selectedAction(^ (TLMenuItem *data) {
            @strongify(self);
            TLGameViewController *gameVC = [[TLGameViewController alloc] init];
            PushVC(gameVC);
        });
    }
    
    // 小程序
    {
        NSInteger sectionTag = TLDiscoverSectionTagProgram;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 40, 0));
        TLMenuItem *program = createMenuItem(@"discover_app", LOCSTR(@"小程序"));
        self.addCell(CELL_MENU_ITEM).toSection(sectionTag).withDataModel(program).selectedAction(^ (id data) {
            @strongify(self);
            TLWebViewController *webVC = [[TLWebViewController alloc] initWithUrl:@"https://github.com/tbl00c"];
            PushVC(webVC);
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
