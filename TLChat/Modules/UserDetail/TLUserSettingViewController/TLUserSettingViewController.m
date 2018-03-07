//
//  TLUserSettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLUserSettingViewController.h"
#import "TLSettingItem.h"
#import "TLUserHelper.h"
#import "TLFriendHelper.h"

typedef NS_ENUM(NSInteger, TLUserSettingVCSectionType) {
    TLUserSettingVCSectionTypeRemark,
    TLUserSettingVCSectionTypeInvite,
    TLUserSettingVCSectionTypeStar,
    TLUserSettingVCSectionTypeRights,
    TLUserSettingVCSectionTypeBlack,
    TLUserSettingVCSectionTypeDelete,
};

@implementation TLUserSettingViewController

- (instancetype)initWithUserModel:(TLUser *)userModel
{
    if (self = [super init]) {
        _userModel = userModel;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self setTitle:LOCSTR(@"资料设置")];
    [self.view setBackgroundColor:[UIColor colorGrayBG]];
    
    [self loadUserSettingUIWithUserModel:self.userModel];
}

- (void)loadUserSettingUIWithUserModel:(TLUser *)userInfo
{
    @weakify(self);
    self.clear();
    
    // 备注
    {
        NSInteger sectionTag = TLUserSettingVCSectionTypeRemark;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(15, 0, 0, 0));
        
        TLSettingItem *remark = TLCreateSettingItem(@"设置备注及标签");
        if (userInfo.remarkName.length > 0) {
            remark.subTitle = userInfo.remarkName;
        }
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(remark).selectedAction(^ (TLSettingItem *data) {
            
        });
    }
    
    // 推荐
    {
        NSInteger sectionTag = TLUserSettingVCSectionTypeInvite;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"把他推荐给朋友")).selectedAction(^ (TLSettingItem *data) {
            
        });
    }
    
    // 星标
    {
        NSInteger sectionTag = TLUserSettingVCSectionTypeStar;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));

        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"设为星标朋友")).eventAction(^ id(NSInteger eventType, id data) {
            
            return nil;
        });
    }
    
    // 权限
    {
        NSInteger sectionTag = TLUserSettingVCSectionTypeRights;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        TLSettingItem *prohibit = TLCreateSettingItem(@"不让他看我的朋友圈");
        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionTag).withDataModel(prohibit).eventAction(^ id(NSInteger eventType, id data) {
            
            return nil;
        });
        
        TLSettingItem *dismiss = TLCreateSettingItem(@"不看他的朋友圈");
        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionTag).withDataModel(dismiss).eventAction(^ id(NSInteger eventType, id data) {
            
            return nil;
        });
    }
    
    // 黑名单
    {
        NSInteger sectionTag = TLUserSettingVCSectionTypeBlack;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 0, 0));
        
        // 黑名单
        self.addCell(CELL_ST_ITEM_SWITCH).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"加入黑名单")).eventAction(^ id(NSInteger eventType, id data) {
            
            return nil;
        });
        
        // 举报
        self.addCell(CELL_ST_ITEM_NORMAL).toSection(sectionTag).withDataModel(TLCreateSettingItem(@"举报")).selectedAction(^ (TLSettingItem *data) {
            
        });
    }
    
    // 删除
    {
        NSInteger sectionTag = TLUserSettingVCSectionTypeDelete;
        self.addSection(sectionTag).sectionInsets(UIEdgeInsetsMake(20, 0, 40, 0));

        self.addCell(@"TLSettingItemDeleteButtonCell").toSection(sectionTag).withDataModel(TLCreateSettingItem(@"删除")).eventAction(^ id(NSInteger eventType, id data) {
            @strongify(self);
            TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:[NSString stringWithFormat:@"将联系人“%@”删除，同时删除与该联系人的聊天记录", self.userModel.showName] clickAction:^(NSInteger buttonIndex) {
                @strongify(self);
                if (buttonIndex == 0) {
                    [[TLFriendHelper sharedFriendHelper] deleteFriendByUserId:self.userModel.userID];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            } cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除联系人" otherButtonTitles:nil];
            [actionSheet show];
            
            return nil;
        });
    }
    
    [self reloadView];
}

@end
