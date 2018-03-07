//
//  TLChatGroupDetailViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatGroupDetailViewController.h"
#import "TLUserDetailViewController.h"
#import "TLGroupQRCodeViewController.h"
#import "TLChatFileViewController.h"
#import "TLChatBackgroundViewController.h"

#import "TLMessageManager+MessageRecord.h"
#import "TLUserGroupCell.h"
#import "TLChatNotificationKey.h"
#import "TLSettingItem.h"

typedef NS_ENUM(NSInteger, TLChatGroupDetailVCSectionType) {
    TLChatGroupDetailVCSectionTypeUsers,
    TLChatGroupDetailVCSectionTypeGroupInfo,
    TLChatGroupDetailVCSectionTypeMiniApp,
    TLChatGroupDetailVCSectionTypeChatDetail,
    TLChatGroupDetailVCSectionTypeConversation,
    TLChatGroupDetailVCSectionTypeNickName,
    TLChatGroupDetailVCSectionTypeBG,
    TLChatGroupDetailVCSectionTypeRecord,
    TLChatGroupDetailVCSectionTypeReport,
    TLChatGroupDetailVCSectionTypeExit,
};

@implementation TLChatGroupDetailViewController

- (instancetype)initWithGroupModel:(id)groupModel
{
    if (self = [super init]) {
        _group = groupModel;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self resetTitle];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];

    [self loadChatGroupDetailUI:self.group];
}

#pragma mark - # UI
- (void)resetTitle
{
    [self setTitle:[NSString stringWithFormat:@"%@(%ld)", LOCSTR(@"聊天详情"), self.group.users.count]];
}

- (void)loadChatGroupDetailUI:(TLGroup *)group
{
    @weakify(self);
    self.clear();
    
    // 好友
    {
        NSInteger sectionTag = TLChatGroupDetailVCSectionTypeUsers;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
        
        self.addCell(@"TLUserGroupCell").toSection(sectionTag).withDataModel(self.group.users).eventAction(^ id(TLUserGroupCellEventType eventType, id data) {
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
    
    // 基本信息
    {
        NSInteger sectionTag = TLChatGroupDetailVCSectionTypeGroupInfo;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        // 名称
        TLSettingItem *nameItem = TLCreateSettingItem(@"群聊名称");
        nameItem.subTitle = group.groupName;
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(nameItem).selectedAction(^ (id data) {
            
        });
        
        // 二维码
        TLSettingItem *qrItem = TLCreateSettingItem(@"群二维码");
        qrItem.rightImagePath = @"mine_cell_myQR";
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(qrItem).selectedAction(^ (id data) {
            @strongify(self);
            TLGroupQRCodeViewController *gorupQRCodeVC = [[TLGroupQRCodeViewController alloc] initWithGroupModel:self.group];
            PushVC(gorupQRCodeVC);
        });
        
        // 群公告
        TLSettingItem *notiItem = TLCreateSettingItem(@"群公告");
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(notiItem).selectedAction(^ (id data) {
            
        });
    }
    
    // 小程序
    {
        NSInteger sectionTag = TLChatGroupDetailVCSectionTypeMiniApp;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"聊天小程序")).selectedAction(^ (id data) {
            
        });
    }
    
    // 聊天记录
    {
        NSInteger sectionTag = TLChatGroupDetailVCSectionTypeChatDetail;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"查找聊天记录")).selectedAction(^ (id data) {
            
        });
        
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"聊天文件")).selectedAction(^ (id data) {
            @strongify(self);
            TLChatFileViewController *chatFileVC = [[TLChatFileViewController alloc] init];
            [chatFileVC setPartnerID:self.group.groupID];
            PushVC(chatFileVC);
        });
    }
    
    
    {
        NSInteger sectionTag = TLChatGroupDetailVCSectionTypeConversation;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        // 免打扰
        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"消息免打扰")).eventAction(^ id(NSInteger eventType, id data) {
            
            return nil;
        });
        
        // 置顶
        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"置顶聊天")).eventAction(^ id(NSInteger eventType, id data) {
            
            return nil;
        });
        
        // 保存
        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"保存到通讯录")).eventAction(^ id(NSInteger eventType, id data) {
            
            return nil;
        });
    }
    
    // 昵称
    {
        NSInteger sectionTag = TLChatGroupDetailVCSectionTypeNickName;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        // 我的昵称
        TLSettingItem *nickNameItem = TLCreateSettingItem(@"我在本群的昵称");
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(nickNameItem).selectedAction(^ (id data) {
            @strongify(self);
            TLChatBackgroundViewController *chatBGSettingVC = [[TLChatBackgroundViewController alloc] init];
            [chatBGSettingVC setPartnerID:self.group.groupID];
            PushVC(chatBGSettingVC);
        });
        
        // 成员昵称
        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"显示群成员昵称")).eventAction(^ id(NSInteger eventType, id data) {
            
            return nil;
        });
    }
    
    // 背景
    {
        NSInteger sectionTag = TLChatGroupDetailVCSectionTypeBG;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"设置当前聊天背景")).selectedAction(^ (id data) {
            @strongify(self);
            TLChatBackgroundViewController *chatBGSettingVC = [[TLChatBackgroundViewController alloc] init];
            [chatBGSettingVC setPartnerID:self.group.groupID];
            PushVC(chatBGSettingVC);
        });
    }
    
    // 清空聊天记录
    {
        NSInteger sectionTag = TLChatGroupDetailVCSectionTypeRecord;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"清空聊天记录")).selectedAction(^ (id data) {
            TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:nil clickAction:^(NSInteger buttonIndex) {
                @strongify(self);
                if (buttonIndex == 0) {
                    BOOL ok = [[TLMessageManager sharedInstance] deleteMessagesByPartnerID:self.group.groupID];
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
        NSInteger sectionTag = TLChatGroupDetailVCSectionTypeReport;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"投诉")).selectedAction(^ (id data) {
            
        });
    }
    
    // 退出
    {
        NSInteger sectionTag = TLChatGroupDetailVCSectionTypeExit;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 40, 0));
        
        self.addCell(@"TLSettingItemDeleteButtonCell").toSection(sectionTag).withDataModel(TLCreateSettingItem(@"删除并退出")).selectedAction(^ (id data) {
            
        });
    }
    
    [self reloadView];
}

@end
