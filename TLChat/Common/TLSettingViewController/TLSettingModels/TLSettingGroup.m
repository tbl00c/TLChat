//
//  TLSettingGroup.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLSettingGroup.h"

@implementation TLSettingGroup

+ (TLSettingGroup *) createGroupWithHeaderTitle:(NSString *)headerTitle
                                    footerTitle:(NSString *)footerTitle
                                          items:(NSMutableArray *)items
{
    TLSettingGroup *group= [[TLSettingGroup alloc] init];
    group.headerTitle = headerTitle;
    group.footerTitle = footerTitle;
    group.items = items;
    return group;
}

#pragma mark - Public Mthods
- (id) objectAtIndex:(NSUInteger)index
{
    return [self.items objectAtIndex:index];
}

- (NSUInteger)indexOfObject:(id)obj
{
    return [self.items indexOfObject:obj];
}


- (void)removeObject:(id)obj
{
    [self.items removeObject:obj];
}

#pragma mark - Setter
- (void) setHeaderTitle:(NSString *)headerTitle
{
    _headerTitle = headerTitle;
    _headerHeight = [TLUIUtility getTextHeightOfText:headerTitle font:[UIFont fontSettingHeaderAndFooterTitle] width:WIDTH_SCREEN - 30];
}

- (void) setFooterTitle:(NSString *)footerTitle
{
    _footerTitle = footerTitle;
    _footerHeight = [TLUIUtility getTextHeightOfText:footerTitle font:[UIFont fontSettingHeaderAndFooterTitle] width:WIDTH_SCREEN - 30];
}

#pragma mark - Getter
- (NSUInteger) count
{
    return self.items.count;
}

@end
