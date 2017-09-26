//
//  TLMineViewController.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/6.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLMineViewController.h"
#import "TLMineViewController+Delegate.h"
#import "TLMenuItem.h"
#import "TLUser.h"
#import "TLUserHelper.h"

#define     NAME_MINE_MENU_CELL     @"TLMenuItemCell"

@interface TLMineViewController ()

@end

@implementation TLMineViewController

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

    [self.navigationItem setTitle:LOCSTR(@"我")];
    [self loadMenus];
}

#pragma mark - # Private Methods
- (void)loadMenus
{
    [self deleteAllItems];
    
    TLUser *user = [TLUserHelper sharedHelper].user;
    
    // 用户信息
    self.addSection(TLMineSectionTagUserInfo).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
    self.addCell(@"TLMineHeaderCell").toSection(TLMineCellTagUserInfo).withDataModel(user).viewTag(TLMineCellTagUserInfo);
    
    // 钱包
    self.addSection(TLMineSectionTagWallet).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
    TLMenuItem *wallet = createMenuItem(@"mine_wallet", LOCSTR(@"钱包"));
    [wallet setBadge:@""];
    self.addCell(NAME_MINE_MENU_CELL).toSection(TLMineSectionTagWallet).withDataModel(wallet).viewTag(TLMineCellTagWallet);
    
    // 功能
    self.addSection(TLMineSectionTagFounction).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
    TLMenuItem *collect = createMenuItem(@"mine_favorites", LOCSTR(@"收藏"));
    self.addCell(NAME_MINE_MENU_CELL).toSection(TLMineSectionTagFounction).withDataModel(collect).viewTag(TLMineCellTagCollect);
    TLMenuItem *album = createMenuItem(@"mine_album", LOCSTR(@"相册"));
    self.addCell(NAME_MINE_MENU_CELL).toSection(TLMineSectionTagFounction).withDataModel(album).viewTag(TLMineCellTagAlbum);
//    TLMenuItem *card = createMenuItem(@"mine_card", LOCSTR(@"卡包"));
//    self.addCell(NAME_MINE_MENU_CELL).toSection(TLMineSectionTagFounction).withDataModel(card).viewTag(TLMineCellTagCard);
    
    // 表情
    self.addSection(TLMineSectionTagExpression).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
    TLMenuItem *expression = createMenuItem(@"mine_expression", LOCSTR(@"表情"));
    [expression setBadge:@"NEW"];
    self.addCell(NAME_MINE_MENU_CELL).toSection(TLMineSectionTagExpression).withDataModel(expression).viewTag(TLMineCellTagExpression);
    
    // 设置
    self.addSection(TLMineSectionTagSetting).sectionInsets(UIEdgeInsetsMake(20, 0, 30, 0));
    TLMenuItem *setting = createMenuItem(@"mine_setting", LOCSTR(@"设置"));
    self.addCell(NAME_MINE_MENU_CELL).toSection(TLMineSectionTagSetting).withDataModel(setting).viewTag(TLMineCellTagSetting);
    
    [self reloadView];
    
    [self resetTabBarBadge];
}

@end
