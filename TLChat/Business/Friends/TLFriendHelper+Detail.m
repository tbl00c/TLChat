//
//  TLFriendHelper+Detail.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendHelper+Detail.h"
#import "TLSettingGroup.h"
#import "TLInfo.h"

@implementation TLFriendHelper (Detail)

- (NSMutableArray *)friendDetailArrayByUserInfo:(TLUser *)userInfo
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    // 1
    TLInfo *user = TLCreateInfo(@"个人", nil);
    user.type = TLInfoTypeOther;
    user.userInfo = userInfo;
    [arr addObject:user];
    [data addObject:arr];
    
    // 2
    arr = [[NSMutableArray alloc] init];
    if (userInfo.detailInfo.phoneNumber.length > 0) {
        TLInfo *tel = TLCreateInfo(@"电话号码", userInfo.detailInfo.phoneNumber);
        tel.showDisclosureIndicator = NO;
        [arr addObject:tel];
    }
    if (userInfo.detailInfo.tags.count == 0) {
        TLInfo *remark = TLCreateInfo(@"设置备注和标签" , nil);
        [arr insertObject:remark atIndex:0];
    }
    else {
        NSString *str = [userInfo.detailInfo.tags componentsJoinedByString:@","];
        TLInfo *remark = TLCreateInfo(@"标签", str);
        [arr addObject:remark];
    }
    [data addObject:arr];
    arr = [[NSMutableArray alloc] init];
    
    // 3
    if (userInfo.detailInfo.location.length > 0) {
        TLInfo *location = TLCreateInfo(@"地区", userInfo.detailInfo.location);
        location.showDisclosureIndicator = NO;
        location.disableHighlight = YES;
        [arr addObject:location];
    }
    TLInfo *album = TLCreateInfo(@"个人相册", nil);
    album.userInfo = userInfo.detailInfo.albumArray;
    album.type = TLInfoTypeOther;
    [arr addObject:album];
    TLInfo *more = TLCreateInfo(@"更多", nil);
    [arr addObject:more];
    [data addObject:arr];
    arr = [[NSMutableArray alloc] init];
    
    // 4
    TLInfo *sendMsg = TLCreateInfo(@"发消息", nil);
    sendMsg.type = TLInfoTypeButton;
    sendMsg.titleColor = [UIColor whiteColor];
    sendMsg.buttonBorderColor = [UIColor colorGrayLine];
    [arr addObject:sendMsg];
    if (![userInfo.userID isEqualToString:[TLUserHelper sharedHelper].userID]) {
        TLInfo *video = TLCreateInfo(@"视频聊天", nil);
        video.type = TLInfoTypeButton;
        video.buttonBorderColor = [UIColor colorGrayLine];
        video.buttonColor = [UIColor whiteColor];
        [arr addObject:video];
    }
    [data addObject:arr];
    
    return data;
}

- (NSMutableArray *)friendDetailSettingArrayByUserInfo:(TLUser *)userInfo
{
    TLSettingItem *remark = TLCreateSettingItem(@"设置备注及标签");
    if (userInfo.remarkName.length > 0) {
        remark.subTitle = userInfo.remarkName;
    }
    TLSettingGroup *group1 = TLCreateSettingGroup(nil, nil, @[remark]);
    
    TLSettingItem *recommand = TLCreateSettingItem(@"把他推荐给朋友");
    TLSettingGroup *group2 = TLCreateSettingGroup(nil, nil, @[recommand]);
    
    TLSettingItem *starFriend = TLCreateSettingItem(@"设为星标朋友");
    starFriend.type = TLSettingItemTypeSwitch;
    TLSettingGroup *group3 = TLCreateSettingGroup(nil, nil, @[starFriend]);
    
    TLSettingItem *prohibit = TLCreateSettingItem(@"不让他看我的朋友圈");
    prohibit.type = TLSettingItemTypeSwitch;
    TLSettingItem *dismiss = TLCreateSettingItem(@"不看他的朋友圈");
    dismiss.type = TLSettingItemTypeSwitch;
    TLSettingGroup *group4 = TLCreateSettingGroup(nil, nil, (@[prohibit, dismiss]));
    
    TLSettingItem *blackList = TLCreateSettingItem(@"加入黑名单");
    blackList.type = TLSettingItemTypeSwitch;
    TLSettingItem *report = TLCreateSettingItem(@"举报");
    TLSettingGroup *group5 = TLCreateSettingGroup(nil, nil, (@[blackList, report]));
    
    return [NSMutableArray arrayWithObjects:group1, group2, group3, group4, group5, nil];
}

@end
