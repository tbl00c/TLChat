//
//  TLMobileContactsAngel.m
//  TLChat
//
//  Created by 李伯坤 on 2018/1/9.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLMobileContactsAngel.h"
#import "TLUserGroup.h"

@interface TLMobileContactsAngel ()

/// header
@property (nonatomic, strong) NSArray *sectionHeaders;

@end

@implementation TLMobileContactsAngel

- (void)resetListWithMobileContactsData:(NSArray *)contactsData sectionHeaders:(NSArray *)sectionHeaders
{
    self.sectionHeaders = sectionHeaders;
    
    self.clear();
    for (TLUserGroup *group in contactsData) {
        NSInteger sectionTag = group.tag;
        self.addSection(sectionTag);
        self.setHeader(@"TLContactsHeaderView").toSection(sectionTag).withDataModel(group.groupName);
        self.addCells(@"TLMobileContactsItemCell").toSection(sectionTag).withDataModelArray(group.users).selectedAction(^ (id data) {
        });
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

@end
