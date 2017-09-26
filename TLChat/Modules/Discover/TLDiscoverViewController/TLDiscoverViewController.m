//
//  TLDiscoverViewController.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/6.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLDiscoverViewController.h"
#import "TLDiscoverViewController+Delegate.h"
#import "TLMenuItem.h"

#define     NAME_DISCOVER_MENU_CELL         @"TLMenuItemCell"

@interface TLDiscoverViewController ()

@end

@implementation TLDiscoverViewController

#pragma mark - # Life Cycle
- (id)init
{
    if (self = [super init]) {
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

#pragma mark - # Private Methods
- (void)loadMenus
{
    [self deleteAllItems];
    
    // 好友圈
    self.addSection(TLDiscoverSectionTagMoments).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
    TLMenuItem *moments = createMenuItem(@"discover_album", LOCSTR(@"朋友圈"));
    [moments setRightIconURL:@"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg" withRightIconBadge:YES];
    self.addCell(NAME_DISCOVER_MENU_CELL).toSection(TLDiscoverSectionTagMoments).withDataModel(moments).viewTag(TLDiscoverCellTagMoments);
    
    // 功能
    self.addSection(TLDiscoverSectionTagFounction).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
    // 扫一扫
    self.addCell(NAME_DISCOVER_MENU_CELL).toSection(TLDiscoverSectionTagFounction).withDataModel(createMenuItem(@"discover_scaner", LOCSTR(@"扫一扫"))).viewTag(TLDiscoverCellTagScaner);
    // 摇一摇
    self.addCell(NAME_DISCOVER_MENU_CELL).toSection(TLDiscoverSectionTagFounction).withDataModel(createMenuItem(@"discover_shake", LOCSTR(@"摇一摇"))).viewTag(TLDiscoverCellTagShake);
    
    // 学习
    self.addSection(TLDiscoverSectionTagStudy).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
    // 看一看
    TLMenuItem *read = createMenuItem(@"discover_read", LOCSTR(@"看一看"));
    [read setBadge:@"2"];
    self.addCell(NAME_DISCOVER_MENU_CELL).toSection(TLDiscoverSectionTagStudy).withDataModel(read).viewTag(TLDiscoverCellTagRead);
    // 搜一搜
    self.addCell(NAME_DISCOVER_MENU_CELL).toSection(TLDiscoverSectionTagStudy).withDataModel(createMenuItem(@"discover_search", LOCSTR(@"搜一搜"))).viewTag(TLDiscoverCellTagSearch);
    
    // 社交
    self.addSection(TLDiscoverSectionTagSocial).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
    // 附近的人
//    self.addCell(NAME_DISCOVER_MENU_CELL).toSection(TLDiscoverSectionTagSocial).withDataModelcreateMenuItem(@"discover_location", LOCSTR(@"附近的人")).viewTag(TLDiscoverCellTagNearby);
    // 漂流瓶
    self.addCell(NAME_DISCOVER_MENU_CELL).toSection(TLDiscoverSectionTagSocial).withDataModel(createMenuItem(@"discover_bottle", LOCSTR(@"漂流瓶"))).viewTag(TLDiscoverCellTagBottle);
    
    // 生活
    self.addSection(TLDiscoverSectionTagLife).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
    // 购物
    TLMenuItem *shopping = createMenuItem(@"discover_shopping", LOCSTR(@"购物"));
    self.addCell(NAME_DISCOVER_MENU_CELL).toSection(TLDiscoverSectionTagLife).withDataModel(shopping).viewTag(TLDiscoverCellTagShopping);
    // 游戏
    TLMenuItem *game = createMenuItem(@"discover_game", LOCSTR(@"游戏"));
    [game setRightIconURL:@"http://qq1234.org/uploads/allimg/140404/3_140404151205_8.jpg" withRightIconBadge:YES];
    [game setSubTitle:@"英雄联盟计算器版"];
    self.addCell(NAME_DISCOVER_MENU_CELL).toSection(TLDiscoverSectionTagLife).withDataModel(game).viewTag(TLDiscoverCellTagGame);
    
    // 小程序
    self.addSection(TLDiscoverSectionTagProgram).sectionInsets(UIEdgeInsetsMake(20, 0, 30, 0));
    TLMenuItem *program = createMenuItem(@"discover_app", LOCSTR(@"小程序"));
    self.addCell(NAME_DISCOVER_MENU_CELL).toSection(TLDiscoverSectionTagProgram).withDataModel(program).viewTag(TLDiscoverCellTagProgram);
    
    [self reloadView];
    
    [self resetTabBarBadge];
}

@end
