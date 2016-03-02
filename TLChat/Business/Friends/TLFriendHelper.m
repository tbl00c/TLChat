//
//  TLFriendHelper.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/27.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendHelper.h"
#import "TLUserHelper.h"
#import "TLInfo.h"

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

+ (NSArray *)transformFriendDetailArrayFromUserInfo:(TLUser *)userInfo
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    // 1
    TLInfo *user = [TLInfo createInfoWithTitle:@"个人" subTitle:nil];
    user.type = TLInfoTypeOther;
    user.userInfo = userInfo;
    [arr addObject:user];
    [data addObject:arr];
    
    // 2
    arr = [[NSMutableArray alloc] init];
    if (userInfo.phoneNumber.length > 0) {
        TLInfo *tel = [TLInfo createInfoWithTitle:@"电话号码" subTitle:userInfo.phoneNumber];
        tel.showDisclosureIndicator = NO;
        [arr addObject:tel];
    }
    if (userInfo.remarkName.length == 0) {
        TLInfo *remark = [TLInfo createInfoWithTitle:@"设置备注和标签" subTitle:nil];
        [arr insertObject:remark atIndex:0];
    }
    else {
        TLInfo *remark = [TLInfo createInfoWithTitle:@"标签" subTitle:@"武林外传"];
        [arr addObject:remark];
    }
    [data addObject:arr];
    arr = [[NSMutableArray alloc] init];
    
    // 3
    if (userInfo.location.length > 0) {
        TLInfo *location = [TLInfo createInfoWithTitle:@"地区" subTitle:userInfo.location];
        location.showDisclosureIndicator = NO;
        [arr addObject:location];
    }
    TLInfo *album = [TLInfo createInfoWithTitle:@"个人相册" subTitle:nil];
    album.userInfo = userInfo.albumArray;
    album.type = TLInfoTypeOther;
    [arr addObject:album];
    TLInfo *more = [TLInfo createInfoWithTitle:@"更多" subTitle:nil];
    [arr addObject:more];
    [data addObject:arr];
    arr = [[NSMutableArray alloc] init];
    
    // 4
    TLInfo *sendMsg = [TLInfo createInfoWithTitle:@"发消息" subTitle:nil];
    sendMsg.type = TLInfoTypeButton;
    sendMsg.titleColor = [UIColor whiteColor];
    sendMsg.buttonBorderColor = [UIColor colorCellLine];
    [arr addObject:sendMsg];
    if (![userInfo.userID isEqualToString:[TLUserHelper sharedHelper].user.userID]) {
        TLInfo *video = [TLInfo createInfoWithTitle:@"视频聊天" subTitle:nil];
        video.type = TLInfoTypeButton;
        video.buttonBorderColor = [UIColor colorCellLine];
        video.buttonColor = [UIColor whiteColor];
        [arr addObject:video];
    }
    [data addObject:arr];
    
    return data;
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

#pragma mark - Public Methods -
- (TLUser *)getFriendInfoByUserID:(NSString *)userID
{
    if (userID == nil) {
        return nil;
    }
    for (TLUser *user in self.friendsData) {
        if ([user.userID isEqualToString:userID]) {
            return user;
        }
    }
    return nil;
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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"FriendList" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    NSArray *arr = [TLUser mj_objectArrayWithKeyValuesArray:jsonArray];
    [self.friendsData removeAllObjects];
    [self.friendsData addObjectsFromArray:arr];
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
