//
//  TLMineInfoViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMineInfoViewController.h"
#import "TLMyQRCodeViewController.h"
#import "TLUserHelper.h"
#import "TLSettingItem.h"

typedef NS_ENUM(NSInteger, TLMineInfoVCSectionType) {
    TLMineInfoVCSectionTypeBase,
    TLMineInfoVCSectionTypeMore,
};

@implementation TLMineInfoViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:LOCSTR(@"个人信息")];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
    
    [self loadMineInfoUI];
}

#pragma mark - # UI
- (void)loadMineInfoUI
{
    @weakify(self);
    self.clear();
    
    TLUser *userInfo = [TLUserHelper sharedHelper].user;
    
    {
        NSInteger sectionTag = TLMineInfoVCSectionTypeBase;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
        
        // 头像
        TLSettingItem *avatar = TLCreateSettingItem(@"头像");
        avatar.rightImageURL = userInfo.avatarURL;
        self.addCell(@"TLMineInfoAvatarCell").toSection(sectionTag).withDataModel(avatar).selectedAction(^ (id data) {
            
        });
        
        // 名字
        TLSettingItem *nikename = TLCreateSettingItem(@"名字");
        nikename.subTitle = userInfo.nikeName.length > 0 ? userInfo.nikeName : @"未设置";
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(nikename).selectedAction(^ (id data) {
            
        });
        
        // 微信号
        TLSettingItem *wechatId = TLCreateSettingItem(@"微信号");
        wechatId.showDisclosureIndicator = userInfo.username.length == 0;
        wechatId.subTitle = userInfo.username.length > 0 ? userInfo.username : @"未设置";
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(wechatId).selectedAction(^ (id data) {
            
        });
        
        // 二维码
        TLSettingItem *qrCode = TLCreateSettingItem(@"我的二维码");
        qrCode.rightImagePath = @"mine_cell_myQR";
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(qrCode).selectedAction(^ (id data) {
            @strongify(self);
            TLMyQRCodeViewController *myQRCodeVC = [[TLMyQRCodeViewController alloc] init];
            PushVC(myQRCodeVC);
        });
        
        // 更多
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"更多")).selectedAction(^ (id data) {
            
        });
    }
    
    {
        NSInteger sectionTag = TLMineInfoVCSectionTypeMore;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 40, 0));
        
        // 我的地址
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"我的地址")).selectedAction(^ (id data) {
            
        });
        
        // 我的发票抬头
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"我的发票抬头")).selectedAction(^ (id data) {
            
        });
    }
    
    [self reloadView];
}

@end
