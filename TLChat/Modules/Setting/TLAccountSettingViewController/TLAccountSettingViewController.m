//
//  TLAccountSettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLAccountSettingViewController.h"
#import "TLWebViewController.h"
#import "TLUserHelper.h"
#import "TLSettingItem.h"

typedef NS_ENUM(NSInteger, TLAccountSettingVCSectionType) {
    TLAccountSettingVCSectionTypeAccount,
    TLAccountSettingVCSectionTypeLock,
    TLAccountSettingVCSectionTypeSafe,
    TLAccountSettingVCSectionTypeHelp,
};

@implementation TLAccountSettingViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:LOCSTR(@"账号与安全")];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
    
    [self loadAccountSettingUI];
}

- (void)loadAccountSettingUI
{
    @weakify(self);
    self.clear();
    TLUser *userInfo = [TLUserHelper sharedHelper].user;
    
    {
        NSInteger sectionTag = TLAccountSettingVCSectionTypeAccount;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
        
        // 微信号
        TLSettingItem *nameItem = TLCreateSettingItem(@"微信号");
        if (userInfo.username.length > 0) {
            nameItem.subTitle = userInfo.username;
            nameItem.showDisclosureIndicator = NO;
            nameItem.disableHighlight = YES;
        }
        else {
            nameItem.subTitle = LOCSTR(@"未设置");
            nameItem.showDisclosureIndicator = YES;
            nameItem.disableHighlight = NO;
        }
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(nameItem).selectedAction(^ (TLSettingItem *data) {

        });
        
        // 手机号
        TLSettingItem *phoneItem = TLCreateSettingItem(@"手机号");
        if (userInfo.detailInfo.phoneNumber.length > 0) {
            phoneItem.subTitle = userInfo.detailInfo.phoneNumber;
            phoneItem.rightImagePath = @"setting_lockon";
        }
        else {
            phoneItem.subTitle = LOCSTR(@"未设置");
            phoneItem.rightImagePath = @"setting_lockoff";
            
        }
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(phoneItem).selectedAction(^ (TLSettingItem *data) {
            @strongify(self);
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"手机号" message:nil preferredStyle:UIAlertControllerStyleAlert];
            __block UITextField *phoneTextField;
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                phoneTextField = textField;
                [textField setKeyboardType:UIKeyboardTypePhonePad];
                [textField setPlaceholder:@"请输入手机号"];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                @strongify(self);
                [TLUserHelper sharedHelper].user.detailInfo.phoneNumber = phoneTextField.text;
                [self loadAccountSettingUI];
            }];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        });
    }
    
    {
        NSInteger sectionTag = TLAccountSettingVCSectionTypeLock;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        // 微信密码
        TLSettingItem *passItem = TLCreateSettingItem(@"微信密码");
        passItem.subTitle = @"已设置";
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(passItem).selectedAction(^ (TLSettingItem *data) {
            
        });
        
        // 声音锁
        TLSettingItem *voiceItem = TLCreateSettingItem(@"声音锁");
        voiceItem.subTitle = @"未设置";
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(voiceItem).selectedAction(^ (TLSettingItem *data) {
            
        });
    }
    
    {
        NSInteger sectionTag = TLAccountSettingVCSectionTypeSafe;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        // 应急联系人
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"应急联系人")).selectedAction(^ (TLSettingItem *data) {
            
        });
        
        // 登录设备管理
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"登录设备管理")).selectedAction(^ (TLSettingItem *data) {
            
        });
        
        // 更多安全设置
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"更多安全设置")).selectedAction(^ (TLSettingItem *data) {
            
        });
    }
    
    {
        NSInteger sectionTag = TLAccountSettingVCSectionTypeHelp;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        // 微信安全中心
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"微信安全中心")).selectedAction(^ (TLSettingItem *data) {
            
        });
        
        self.setFooter(VIEW_ST_FOOTER).toSection(sectionTag).withDataModel(LOCSTR(@"如果遇到账号信息泄露、忘记密码、诈骗等账号问题，可前往微信安全中心。"));
    }
    
    [self reloadView];
}

@end
