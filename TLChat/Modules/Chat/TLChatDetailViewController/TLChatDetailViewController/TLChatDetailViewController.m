//
//  TLChatDetailViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatDetailViewController.h"
#import "TLUserDetailViewController.h"
#import "TLChatFileViewController.h"
#import "TLChatBackgroundViewController.h"
#import "TLMessageManager+MessageRecord.h"
#import "TLUserGroupCell.h"
#import "TLChatNotificationKey.h"
#import "TLSettingItem.h"

typedef NS_ENUM(NSInteger, TLChatDetailVCSectionType) {
    TLChatDetailVCSectionTypeUsers,
    TLChatDetailVCSectionTypeMiniApp,
    TLChatDetailVCSectionTypeChatDetail,
    TLChatDetailVCSectionTypeConversation,
    TLChatDetailVCSectionTypeBG,
    TLChatDetailVCSectionTypeRecord,
    TLChatDetailVCSectionTypeReport,
};

@implementation TLChatDetailViewController

- (instancetype)initWithUserModel:(TLUser *)user
{
    if (self = [super init]) {
        _user = user;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self setTitle:LOCSTR(@"聊天详情")];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
    
    [self loadChatDetailUI];
}

- (void)loadChatDetailUI
{
    @weakify(self);
    self.clear();
    
    // 好友
    {
        NSInteger sectionTag = TLChatDetailVCSectionTypeUsers;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
        
        self.addCell(@"TLUserGroupCell").toSection(sectionTag).withDataModel(@[self.user]).eventAction(^ id(TLUserGroupCellEventType eventType, id data) {
            @strongify(self);
            if (eventType == TLUserGroupCellEventTypeClickUser) {
                TLUserDetailViewController *userDetailVC = [[TLUserDetailViewController alloc] initWithUserModel:data];
                PushVC(userDetailVC);
            }
            else if (eventType == TLUserGroupCellEventTypeAdd) {
                [TLUIUtility showAlertWithTitle:@"提示" message:@"添加讨论组成员"];
            }
            return nil;
        });;
    }
    
    // 小程序
    {
        NSInteger sectionTag = TLChatDetailVCSectionTypeMiniApp;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"聊天小程序")).selectedAction(^ (id data) {
            
        });
    }
    
    // 聊天记录
    {
        NSInteger sectionTag = TLChatDetailVCSectionTypeChatDetail;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"查找聊天记录")).selectedAction(^ (id data) {
            
        });
        
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"聊天文件")).selectedAction(^ (id data) {
            @strongify(self);
            TLChatFileViewController *chatFileVC = [[TLChatFileViewController alloc] init];
            [chatFileVC setPartnerID:self.user.userID];
            PushVC(chatFileVC);
        });
    }
    
    
    {
        NSInteger sectionTag = TLChatDetailVCSectionTypeConversation;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        // 置顶
        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"置顶聊天")).eventAction(^ id(NSInteger eventType, id data) {
            
            return nil;
        });
        
        // 免打扰
        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"消息免打扰")).eventAction(^ id(NSInteger eventType, id data) {
            
            return nil;
        });
    }
    
    // 背景
    {
        NSInteger sectionTag = TLChatDetailVCSectionTypeBG;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"设置当前聊天背景")).selectedAction(^ (id data) {
            @strongify(self);
            TLChatBackgroundViewController *chatBGSettingVC = [[TLChatBackgroundViewController alloc] init];
            [chatBGSettingVC setPartnerID:self.user.userID];
            PushVC(chatBGSettingVC);
        });
    }
    
    // 清空聊天记录
    {
        NSInteger sectionTag = TLChatDetailVCSectionTypeRecord;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"清空聊天记录")).selectedAction(^ (id data) {
            TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:nil clickAction:^(NSInteger buttonIndex) {
                @strongify(self);
                if (buttonIndex == 0) {
                    BOOL ok = [[TLMessageManager sharedInstance] deleteMessagesByPartnerID:self.user.userID];
                    if (!ok) {
                        [TLUIUtility showAlertWithTitle:@"错误" message:@"清空聊天记录失败"];
                    }
                    else {
                        [[NSNotificationCenter defaultCenter] postNotificationName:NOTI_CHAT_VIEW_RESET object:nil];
                    }
                }
            } cancelButtonTitle:@"取消" destructiveButtonTitle:@"清空聊天记录" otherButtonTitles: nil];
            [actionSheet show];
        });
    }
    
    // 投诉
    {
        NSInteger sectionTag = TLChatDetailVCSectionTypeReport;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"投诉")).selectedAction(^ (id data) {
            
        });
    }
    
    [self reloadView];
}

@end
