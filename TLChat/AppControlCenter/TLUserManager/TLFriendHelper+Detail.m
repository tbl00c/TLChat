//
//  TLFriendHelper+Detail.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendHelper+Detail.h"
#import "TLSettingGroup.h"
#import "TLUserHelper.h"

@implementation TLFriendHelper (Detail)

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
