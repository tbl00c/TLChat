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
- (void)loadView
{
    [super loadView];
    
    [self.navigationItem setTitle:LOCSTR(@"发现")];
    [self loadMenus];
}

#pragma mark - # Private Methods
- (void)loadMenus
{
    [self deleteAllItems];
    
    // 好友圈
    self.addSection(TLDiscoverSectionTagMoments).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
    TLMenuItem *moments = createMenuItem(@"discover_album", LOCSTR(@"朋友圈"));
    [moments setBadge:@""];
    [moments setRightIconURL:@"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg"];
    self.addCell(NAME_DISCOVER_MENU_CELL).toSection(TLDiscoverSectionTagMoments).withDataModel(moments).viewTag(TLDiscoverCellTagMoments);
    
    // 功能
    self.addSection(TLDiscoverSectionTagFounction).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
    self.addCell(NAME_DISCOVER_MENU_CELL).toSection(TLDiscoverSectionTagFounction).withDataModel(createMenuItem(@"discover_scaner", LOCSTR(@"扫一扫"))).viewTag(TLDiscoverCellTagScaner);
    self.addCell(NAME_DISCOVER_MENU_CELL).toSection(TLDiscoverSectionTagFounction).withDataModel(createMenuItem(@"discover_shake", LOCSTR(@"摇一摇"))).viewTag(TLDiscoverCellTagShake);
    
    // 学习
    self.addSection(TLDiscoverSectionTagStudy).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
    TLMenuItem *read = createMenuItem(@"discover_read", LOCSTR(@"看一看"));
    [read setBadge:@""];
    self.addCell(NAME_DISCOVER_MENU_CELL).toSection(TLDiscoverSectionTagStudy).withDataModel(read).viewTag(TLDiscoverCellTagRead);
    TLMenuItem *search = createMenuItem(@"discover_search", LOCSTR(@"搜一搜"));
    self.addCell(NAME_DISCOVER_MENU_CELL).toSection(TLDiscoverSectionTagStudy).withDataModel(search).viewTag(TLDiscoverCellTagSearch);
    
    // 社交
    self.addSection(TLDiscoverSectionTagSocial).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
    TLMenuItem *nearby = createMenuItem(@"discover_location", LOCSTR(@"附近的人"));
    self.addCell(NAME_DISCOVER_MENU_CELL).toSection(TLDiscoverSectionTagSocial).withDataModel(nearby).viewTag(TLDiscoverCellTagNearby);
    self.addCell(NAME_DISCOVER_MENU_CELL).toSection(TLDiscoverSectionTagSocial).withDataModel(createMenuItem(@"discover_bottle", LOCSTR(@"漂流瓶"))).viewTag(TLDiscoverCellTagBottle);
    
    // 生活
    self.addSection(TLDiscoverSectionTagLife).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
    TLMenuItem *shopping = createMenuItem(@"discover_shopping", LOCSTR(@"购物"));
    self.addCell(NAME_DISCOVER_MENU_CELL).toSection(TLDiscoverSectionTagLife).withDataModel(shopping).viewTag(TLDiscoverCellTagShopping);
    TLMenuItem *game = createMenuItem(@"discover_game", LOCSTR(@"游戏"));
    [game setRightIconURL:@"http://qq1234.org/uploads/allimg/140404/3_140404151205_8.jpg"];
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
