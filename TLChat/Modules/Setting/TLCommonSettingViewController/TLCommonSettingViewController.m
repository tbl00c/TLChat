//
//  TLCommonSettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/21.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLCommonSettingViewController.h"
#import "TLChatViewController.h"
#import "TLChatFontViewController.h"
#import "TLChatBackgroundViewController.h"
#import "TLMyExpressionViewController.h"

#import "TLMessageManager.h"
#import "TLSettingItem.h"
#import "TLChatNotificationKey.h"

typedef NS_ENUM(NSInteger, TLCommonSettingVCSectionType) {
    TLCommonSettingVCSectionTypeLanguage,
    TLCommonSettingVCSectionTypeChat,
    TLCommonSettingVCSectionTypeVoice,
    TLCommonSettingVCSectionTypeFunction,
    TLCommonSettingVCSectionTypeRecord,
    TLCommonSettingVCSectionTypeClear,
};

@implementation TLCommonSettingViewController

- (void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
    [self setTitle:LOCSTR(@"通用")];
    
    [self loadCommonSettingUI];
}

#pragma mark - # UI
- (void)loadCommonSettingUI
{
    @weakify(self);
    self.clear();
   
    // 语言
    {
        NSInteger sectionType = TLCommonSettingVCSectionTypeLanguage;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
        
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionType).withDataModel(TLCreateSettingItem(@"多语言")).selectedAction(^ (TLSettingItem *data) {
            
        });
    }
    
    // 社交
    {
        NSInteger sectionType = TLCommonSettingVCSectionTypeChat;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        // 字体
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionType).withDataModel(TLCreateSettingItem(@"字体大小")).selectedAction(^ (TLSettingItem *data) {
            @strongify(self);
            TLChatFontViewController *chatFontVC = [[TLChatFontViewController alloc] init];
            PushVC(chatFontVC);
        });
        
        // 聊天背景
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionType).withDataModel(TLCreateSettingItem(@"聊天背景")).selectedAction(^ (TLSettingItem *data) {
            @strongify(self);
            TLChatBackgroundViewController *chatBGSettingVC = [[TLChatBackgroundViewController alloc] init];
            PushVC(chatBGSettingVC);
        });
        
        // 表情
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionType).withDataModel(TLCreateSettingItem(@"我的表情")).selectedAction(^ (TLSettingItem *data) {
            @strongify(self);
            TLMyExpressionViewController *myExpressionVC = [[TLMyExpressionViewController alloc] init];
            PushVC(myExpressionVC);
        });
        
        // 聊天资源
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionType).withDataModel(TLCreateSettingItem(@"照片、视频和文件")).selectedAction(^ (TLSettingItem *data) {
            
        });
    }
    
    // 声音
    {
        NSInteger sectionType = TLCommonSettingVCSectionTypeVoice;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionType).withDataModel(TLCreateSettingItem(@"听筒模式")).selectedAction(^ (TLSettingItem *data) {
            
        });
    }
    
    // 功能
    {
        NSInteger sectionType = TLCommonSettingVCSectionTypeFunction;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        // 发现页管理
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionType).withDataModel(TLCreateSettingItem(@"发现页管理")).selectedAction(^ (TLSettingItem *data) {
            
        });
        
        // 辅助功能
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionType).withDataModel(TLCreateSettingItem(@"辅助功能")).selectedAction(^ (TLSettingItem *data) {
            
        });
    }
    
    // 记录
    {
        NSInteger sectionType = TLCommonSettingVCSectionTypeRecord;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        // 聊天记录迁移
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionType).withDataModel(TLCreateSettingItem(@"聊天记录迁移")).selectedAction(^ (TLSettingItem *data) {
            
        });
        
        // 存储空间
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionType).withDataModel(TLCreateSettingItem(@"存储空间")).selectedAction(^ (TLSettingItem *data) {
            
        });
    }
    
    // 清空聊天记录
    {
        NSInteger sectionType = TLCommonSettingVCSectionTypeClear;
        self.addSection(sectionType).sectionInsets(UIEdgeInsetsMake(20, 0, 40, 0));
        
        self.addCell(CELL_ST_ITEM_BUTTON).toSection(sectionType).withDataModel(TLCreateSettingItem(@"清空聊天记录")).selectedAction(^ (TLSettingItem *data) {
            TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:@"将删除所有个人和群的聊天记录。" clickAction:^(NSInteger buttonIndex) {
                if (buttonIndex == 0) {
                    [[TLMessageManager sharedInstance] deleteAllMessages];
                    [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CHAT_VIEW_RESET object:nil];
                }
            } cancelButtonTitle:@"取消" destructiveButtonTitle:@"清空聊天记录" otherButtonTitles:nil];
            [actionSheet show];
        });
    }
    
    [self reloadView];
}

@end
