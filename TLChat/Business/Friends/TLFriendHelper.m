//
//  TLFriendHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/27.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendHelper.h"

static TLFriendHelper *friendHelper = nil;

@implementation TLFriendHelper

+ (TLFriendHelper *)sharedFriendHelper
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        friendHelper = [[TLFriendHelper alloc] init];
    });
    return friendHelper;
}

- (id)init
{
    if (self = [super init]) {
        self.friendsData = [[NSMutableArray alloc] init];
        self.data = [[NSMutableArray alloc] initWithObjects:self.defaultGroup, nil];
        self.sectionHeaders = [[NSMutableArray alloc] initWithObjects:UITableViewIndexSearch, nil];
        
        [self p_initTestData];
    }
    return self;
}

#pragma mark - Private Methods -
- (void)p_resetFriendData
{
    // 1、排序
    NSArray *serializeArray = [self.friendsData sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        int i;
        NSString *strA = ((TLUser *)obj1).pinyin;
        NSString *strB = ((TLUser *)obj2).pinyin;
        for (i = 0; i < strA.length && i < strB.length; i ++) {
            char a = toupper([strA characterAtIndex:i]);
            char b = toupper([strB characterAtIndex:i]);
            if (a > b) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            else if (a < b) {
                return (NSComparisonResult)NSOrderedAscending;
            }
        }
        if (strA.length > strB.length) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        else if (strA.length < strB.length){
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    // 2、分组
    NSMutableArray *ansData = [[NSMutableArray alloc] initWithObjects:self.defaultGroup, nil];
    NSMutableArray *ansSectionHeaders = [[NSMutableArray alloc] initWithObjects:UITableViewIndexSearch, nil];
    char lastC = '1';
    TLUserGroup *curGroup;
    TLUserGroup *othGroup = [[TLUserGroup alloc] init];
    [othGroup setGroupName:@"#"];
    for (TLUser *user in serializeArray) {
        // 获取拼音失败
        if (user.pinyin == nil || user.pinyin.length == 0) {
            [othGroup addObject:user];
            continue;
        }
        
        char c = toupper([user.pinyin characterAtIndex:0]);
        if (!isalpha(c)) {      // #组
            [othGroup addObject:user];
        }
        else if (c != lastC){
            if (curGroup && curGroup.count > 0) {
                [ansData addObject:curGroup];
                [ansSectionHeaders addObject:curGroup.groupName];
            }
            lastC = c;
            curGroup = [[TLUserGroup alloc] init];
            [curGroup setGroupName:[NSString stringWithFormat:@"%c", c]];
            [curGroup addObject:user];
        }
        else {
            [curGroup addObject:user];
        }
    }
    if (curGroup && curGroup.count > 0) {
        [ansData addObject:curGroup];
        [ansSectionHeaders addObject:curGroup.groupName];
    }
    if (othGroup.count > 0) {
        [ansData addObject:othGroup];
        [ansSectionHeaders addObject:othGroup.groupName];
    }
    
    [self.data removeAllObjects];
    [self.data addObjectsFromArray:ansData];
    [self.sectionHeaders removeAllObjects];
    [self.sectionHeaders addObjectsFromArray:ansSectionHeaders];
    if (self.dataChangedBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.dataChangedBlock(self.data, self.sectionHeaders);
        });
    }
}

- (void)p_initTestData
{
    TLUser *user1 = [[TLUser alloc] init];
    user1.nikeName = @"吕轻侯";
    user1.userID = @"yun";
    user1.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
    TLUser *user2 = [[TLUser alloc] init];
    user2.nikeName = @"白展堂";
    user2.userID = @"小白2";
    user2.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
    TLUser *user3 = [[TLUser alloc] init];
    user3.remarkName = @"李秀莲";
    user3.userID = @"xiulian";
    user3.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
    TLUser *user4 = [[TLUser alloc] init];
    user4.remarkName = @"燕小六";
    user4.userID = @"xiao6";
    user4.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
    TLUser *user5 = [[TLUser alloc] init];
    user5.remarkName = @"郭芙蓉";
    user5.userID = @"furongMM";
    user5.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
    TLUser *user6 = [[TLUser alloc] init];
    user6.nikeName = @"佟湘玉";
    user6.userID = @"yu";
    user6.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
    TLUser *user7 = [[TLUser alloc] init];
    user7.nikeName = @"莫小贝";
    user7.userID = @"XB";
    user7.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
    
    [self.friendsData removeAllObjects];
    [self.friendsData addObjectsFromArray:@[user1, user2, user3, user4, user5, user6, user7]];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self p_resetFriendData];
    });
}

#pragma mark - Getter
- (TLUserGroup *)defaultGroup
{
    if (_defaultGroup == nil) {
        TLUser *item_new = [[TLUser alloc] initWithUserID:@"-1" avatarPath:@"friends_new" remarkName:@"新的朋友"];
        TLUser *item_group = [[TLUser alloc] initWithUserID:@"-2" avatarPath:@"friends_group" remarkName:@"群聊"];
        TLUser *item_tag = [[TLUser alloc] initWithUserID:@"-3" avatarPath:@"friends_tag" remarkName:@"标签"];
        TLUser *item_public = [[TLUser alloc] initWithUserID:@"-4" avatarPath:@"friends_public" remarkName:@"公共号"];
        _defaultGroup = [[TLUserGroup alloc] initWithGroupName:nil users:[NSMutableArray arrayWithObjects:item_new, item_group, item_tag, item_public, nil]];
    }
    return _defaultGroup;
}

- (NSInteger)friendNumber
{
    return self.friendsData.count;
}

@end
