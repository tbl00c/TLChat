//
//  TLContactsAngel.m
//  TLChat
//
//  Created by 李伯坤 on 2018/1/8.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLContactsAngel.h"
#import <ZZFLEX/ZZFLEXAngel+Private.h>
#import <ZZFLEX/ZZFlexibleLayoutSectionModel.h>
#import "TLUserGroup.h"
#import "TLContactsItemCell.h"

#import "TLNewFriendViewController.h"
#import "TLGroupViewController.h"
#import "TLTagsViewController.h"
#import "TLOfficialAccountViewController.h"
#import "TLUserDetailViewController.h"

@interface TLContactsAngel ()

/// header
@property (nonatomic, strong) NSArray *sectionHeaders;

@end

@implementation TLContactsAngel

- (instancetype)initWithHostView:(__kindof UIScrollView *)hostView pushAction:(void (^)(__kindof UIViewController *vc))pushAction
{
    if (self = [super initWithHostView:hostView]) {
        self.pushAction = pushAction;
    }
    return self;
}

- (void)resetListWithContactsData:(NSArray *)contactsData sectionHeaders:(NSArray *)sectionHeaders
{
    self.sectionHeaders = sectionHeaders;
    
    @weakify(self);
    self.clear();
    
    /// 功能
    self.addSection(TLContactsVCSectionTypeFuncation);
    {
        TLContactsItemModel *newModel = createContactsItemModelWithTag(TLContactsVCCellTypeNew, @"friends_new", nil, LOCSTR(@"新的朋友"), nil, nil);
        TLContactsItemModel *groupModel = createContactsItemModelWithTag(TLContactsVCCellTypeGroup, @"friends_group", nil, LOCSTR(@"群聊"), nil, nil);
        TLContactsItemModel *tagModel = createContactsItemModelWithTag(TLContactsVCCellTypeTag, @"friends_tag", nil, LOCSTR(@"标签"), nil, nil);
        TLContactsItemModel *publicModel = createContactsItemModelWithTag(TLContactsVCCellTypePublic, @"friends_public", nil, LOCSTR(@"公众号"), nil, nil);
        NSArray *funcationData = @[newModel, groupModel, tagModel, publicModel];
        self.addCells(NSStringFromClass([TLContactsItemCell class])).toSection(TLContactsVCSectionTypeFuncation).withDataModelArray(funcationData).selectedAction(^ (TLContactsItemModel *model) {
            @strongify(self);
            if (model.tag == TLContactsVCCellTypeNew) {
                TLNewFriendViewController *newFriendVC = [[TLNewFriendViewController alloc] init];
                [self tryPushVC:newFriendVC];
            }
            else if (model.tag == TLContactsVCCellTypeGroup) {
                TLGroupViewController *groupVC = [[TLGroupViewController alloc] init];
                [self tryPushVC:groupVC];
            }
            else if (model.tag == TLContactsVCCellTypeTag) {
                TLTagsViewController *tagsVC = [[TLTagsViewController alloc] init];
                [self tryPushVC:tagsVC];
            }
            else if (model.tag == TLContactsVCCellTypePublic) {
                TLOfficialAccountViewController *publicServerVC = [[TLOfficialAccountViewController alloc] init];
                [self tryPushVC:publicServerVC];
            }
        });
    }
    // 企业
    self.addSection(TLContactsVCSectionTypeEnterprise);
    
    // 好友
    TLContactsItemModel *(^createContactsItemModelWithUserModel)(TLUser *userModel) = ^TLContactsItemModel *(TLUser *userModel){
        TLContactsItemModel *model = createContactsItemModel(userModel.avatarPath, userModel.avatarURL, userModel.showName, userModel.detailInfo.remarkInfo, userModel);
        return model;
    };
    for (TLUserGroup *group in contactsData) {
        NSInteger sectionTag = group.tag;
        self.addSection(sectionTag);
        self.setHeader(@"TLContactsHeaderView").toSection(sectionTag).withDataModel(group.groupName);
        
        NSMutableArray *data = [[NSMutableArray alloc]initWithCapacity:group.users.count];
        for (TLUser *user in group.users) {
            TLContactsItemModel *newModel = createContactsItemModelWithUserModel(user);
            [data addObject:newModel];
        }
        self.addCells(NSStringFromClass([TLContactsItemCell class])).toSection(sectionTag).withDataModelArray(data).selectedAction(^ (TLContactsItemModel *data) {
            @strongify(self);
            TLUser *user = data.userInfo;
            TLUserDetailViewController *detailVC = [[TLUserDetailViewController alloc] initWithUserModel:user];
            [self tryPushVC:detailVC];
        });
    }
}

- (void)tryPushVC:(__kindof UIViewController *)vc
{
    if (self.pushAction) {
        self.pushAction(vc);
    }
}

#pragma mark - # Delegate
// 拼音首字母检索
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionHeaders;
}

// 检索时空出搜索框
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if(index == 0) {
        [tableView scrollRectToVisible:CGRectMake(0, 0, tableView.width, tableView.height) animated:NO];
        return -1;
    }
    return index;
}

// 备注
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    if (sectionModel.sectionTag != TLContactsVCSectionTypeFuncation && sectionModel.sectionTag != TLContactsVCSectionTypeEnterprise) {
        @weakify(self);
        TLContactsItemModel *itemModel = self.dataModel.atIndexPath(indexPath);
        UITableViewRowAction *remarkAction;
        remarkAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                          title:@"备注"
                                                        handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                            @strongify(self);
                                                            [TLUIUtility showSuccessHint:@"备注：暂未实现"];
                                                        }];
        return @[remarkAction];
    }
    return @[];
}

@end
