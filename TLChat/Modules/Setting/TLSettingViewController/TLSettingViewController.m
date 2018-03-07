//
//  TLSettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLSettingViewController.h"
#import "TLAccountSettingViewController.h"
#import "TLNewMessageSettingViewController.h"
#import "TLPrivacySettingViewController.h"
#import "TLCommonSettingViewController.h"
#import "TLAboutViewController.h"
#import "TLWebViewController.h"
#import "TLSettingItem.h"

typedef NS_ENUM(NSInteger, TLSettingVCSectionType) {
    TLSettingVCSectionTypeAccount,
    TLSettingVCSectionTypeNomal,
    TLSettingVCSectionTypeAbout,
    TLSettingVCSectionTypeExit,
};

@implementation TLSettingViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:LOCSTR(@"设置")];
    [self.collectionView setBackgroundColor:[UIColor colorGrayBG]];

    [self loadSettingUI];
}

#pragma mark - # UI
- (void)loadSettingUI
{
    @weakify(self);
    self.clear();
    
    {
        NSInteger sectionTag = TLSettingVCSectionTypeAccount;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
        // 账号与安全
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"账号与安全")).selectedAction(^ (id data) {
            @strongify(self);
            TLAccountSettingViewController *accountAndSafetyVC = [[TLAccountSettingViewController alloc] init];
            PushVC(accountAndSafetyVC);
        });
    }
    
    {
        NSInteger sectionTag = TLSettingVCSectionTypeNomal;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        // 新消息通知
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"新消息通知")).selectedAction(^ (id data) {
            @strongify(self);
            TLNewMessageSettingViewController *newMessageSettingVC = [[TLNewMessageSettingViewController alloc] init];
            PushVC(newMessageSettingVC);
        });
        // 隐私
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"隐私")).selectedAction(^ (id data) {
            @strongify(self);
            TLPrivacySettingViewController *privacySettingVC = [[TLPrivacySettingViewController alloc] init];
            PushVC(privacySettingVC);
        });
        // 通用
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"通用")).selectedAction(^ (id data) {
            @strongify(self);
            TLCommonSettingViewController *commonSettingVC = [[TLCommonSettingViewController alloc] init];
            PushVC(commonSettingVC);
        });
    }
    
    {
        NSInteger sectionTag = TLSettingVCSectionTypeAbout;
        self.addSection(TLSettingVCSectionTypeAbout).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        // 帮助与反馈
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"帮助与反馈")).selectedAction(^ (id data) {
            @strongify(self);
            TLWebViewController *webVC = [[TLWebViewController alloc] initWithUrl:@"https://github.com/tbl00c/TLChat/issues"];
            PushVC(webVC);
        });
        // 关于微信
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"关于微信")).selectedAction(^ (id data) {
            @strongify(self);
            TLAboutViewController *aboutVC = [[TLAboutViewController alloc] init];
            PushVC(aboutVC);
        });
    }
    
    {
        NSInteger sectionTag = TLSettingVCSectionTypeExit;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 40, 0));
        self.addCell(CELL_ST_ITEM_BUTTON).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"退出登录")).selectedAction(^ (id data) {
            TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:@"退出后不会删除任何历史数据，下次登录依然可以使用本账号。" clickAction:^(NSInteger buttonIndex) {
                
            } cancelButtonTitle:LOCSTR(@"取消") destructiveButtonTitle:LOCSTR(@"退出登录") otherButtonTitles:nil];
            [actionSheet show];
        });
    }
    
    [self reloadView];
}

@end
