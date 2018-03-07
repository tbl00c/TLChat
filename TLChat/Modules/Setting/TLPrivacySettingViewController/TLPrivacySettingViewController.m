//
//  TLPrivacySettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLPrivacySettingViewController.h"
#import "TLSettingItem.h"

typedef NS_ENUM(NSInteger, TLPrivacySettingVCSectionType) {
    TLPrivacySettingVCSectionTypeVerify,
    TLPrivacySettingVCSectionTypeWay,
    TLPrivacySettingVCSectionTypeBlackList,
    TLPrivacySettingVCSectionTypeMoments,
    TLPrivacySettingVCSectionTypeMomentsNoti,
    TLPrivacySettingVCSectionTypePower,
};

@implementation TLPrivacySettingViewController

- (void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
    [self setTitle:LOCSTR(@"隐私")];
    
    [self loadPrivacySettingUI];
}

#pragma mark - # UI
- (void)loadPrivacySettingUI
{
    self.clear();
    
    {
        NSInteger sectionTag = TLPrivacySettingVCSectionTypeVerify;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"加我为好友时需要验证")).eventAction(^ id(NSInteger eventType, id data) {
            
            return nil;
        });
    }
    
    {
        NSInteger sectionTag = TLPrivacySettingVCSectionTypeWay;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"添加我的方式")).selectedAction(^ (id data) {
       
        });
        
        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"向我推荐通讯录朋友")).eventAction(^ id(NSInteger eventType, id data) {
            
            return nil;
        });
        
        self.setFooter(VIEW_ST_FOOTER).toSection(sectionTag).withDataModel(@"开启后，为你推荐已经开通微信的手机联系人。");
    }
    
    {
        NSInteger sectionTag = TLPrivacySettingVCSectionTypeBlackList;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 5, 0));
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"通讯录黑名单")).selectedAction(^ (id data) {
            
        });
    }
    
    {
        NSInteger sectionTag = TLPrivacySettingVCSectionTypeMoments;
        self.addSection(sectionTag);
        
        self.setHeader(VIEW_ST_HEADER).toSection(sectionTag).withDataModel(@"朋友圈");
        
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"不让他(她)看我的朋友圈")).selectedAction(^ (id data) {
           
        });
        
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"不看他(她)的朋友圈")).selectedAction(^ (id data) {
            
        });
        
        TLSettingItem *areaItem = TLCreateSettingItem(@"允许朋友查看朋友圈的范围");
        areaItem.subTitle = @"全部";
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(areaItem).selectedAction(^ (id data) {
            
        });
        
        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"允许陌生人查看十张照片")).eventAction(^ id(NSInteger eventType, id data) {
            
            return nil;
        });
    }
    
    {
        NSInteger sectionTag = TLPrivacySettingVCSectionTypeMomentsNoti;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"朋友圈更新提醒")).eventAction(^ id(NSInteger eventType, id data) {
            
            return nil;
        });
        
        self.setFooter(VIEW_ST_FOOTER).toSection(sectionTag).withDataModel(@"关闭后，有朋友发表朋友圈时，界面下方的”发现“切换按钮上不再出现红点提示。");
    }
    
    {
        NSInteger sectionTag = TLPrivacySettingVCSectionTypePower;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(15, 0, 30, 0));
        
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"授权管理")).selectedAction(^ (id data) {
          
        });
    }
    
    [self reloadView];
}

@end
