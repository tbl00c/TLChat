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

+ (TLFriendHelper *) sharedFriendHelper
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        friendHelper = [[TLFriendHelper alloc] init];
    });
    return friendHelper;
}

- (id) init
{
    if (self = [super init]) {
        self.friendsData = [[NSMutableArray alloc] init];
        self.data = [[NSMutableArray alloc] initWithObjects:self.defaultGroup, nil];
        self.sectionHeaders = [[NSMutableArray alloc] initWithObjects:UITableViewIndexSearch, nil];
        
        [self p_initTestData];
    }
    return self;
}

- (void) p_initTestData
{
    NSMutableArray *arr1 = [[NSMutableArray alloc] initWithCapacity:3];
    TLUser *user1 = [[TLUser alloc] init];
    user1.nikeName = @"吕轻侯";
    user1.userID = @"yun";
    user1.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
    [arr1 addObject:user1];
    TLUser *user2 = [[TLUser alloc] init];
    user2.nikeName = @"白展堂";
    user2.userID = @"小白2";
    user2.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
    [arr1 addObject:user2];
    TLUser *user3 = [[TLUser alloc] init];
    user3.remarkName = @"李秀莲";
    user3.userID = @"xiulian";
    user3.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
    [arr1 addObject:user3];
    
    TLUserGroup *defaultGroup = [[TLUserGroup alloc] initWithGroupName:@"A" users:arr1];
    [_data addObject:defaultGroup];
    
    NSMutableArray *arr2 = [[NSMutableArray alloc] init];
    TLUser *user4 = [[TLUser alloc] init];
    user4.remarkName = @"燕小六";
    user4.userID = @"xiao6";
    user4.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
    [arr2 addObject:user4];
    TLUserGroup *defaultGroup2 = [[TLUserGroup alloc] initWithGroupName:@"B" users:arr2];
    [_data addObject:defaultGroup2];
    
    NSMutableArray *arr3 = [[NSMutableArray alloc] init];
    TLUser *user5 = [[TLUser alloc] init];
    user5.remarkName = @"郭芙蓉";
    user5.userID = @"furongMM";
    user5.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
    [arr3 addObject:user5];
    TLUser *user6 = [[TLUser alloc] init];
    user6.nikeName = @"佟湘玉";
    user6.userID = @"yu";
    user6.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
    [arr3 addObject:user6];
    TLUser *user7 = [[TLUser alloc] init];
    user7.nikeName = @"莫小贝";
    user7.userID = @"XB";
    user7.avatarURL = @"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg";
    [arr3 addObject:user7];
    
    TLUserGroup *defaultGroup3 = [[TLUserGroup alloc] initWithGroupName:@"C" users:arr3];
    [_data addObject:defaultGroup3];
    
    for (int i = 1; i < _data.count; i ++) {
        TLUserGroup *group = _data[i];
        [_sectionHeaders addObject:group.groupName];
    }
}


#pragma mark - Getter
- (TLUserGroup *) defaultGroup
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

- (NSInteger) friendNumber
{
    return self.friendsData.count;
}

@end
