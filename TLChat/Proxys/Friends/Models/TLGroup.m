//
//  TLGroup.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLGroup.h"
#import "TLFriendHelper.h"

@implementation TLGroup

- (NSInteger)count
{
    return self.users.count;
}

- (void)addObject:(id)anObject
{
    [self.users addObject:anObject];
}

- (id)objectAtIndex:(NSUInteger)index
{
    return [self.users objectAtIndex:index];
}

- (NSString *)groupName
{
    if (_groupName == nil || _groupName.length == 0) {
        for (NSString *userID in self.users) {
            TLUser *user = [[TLFriendHelper sharedFriendHelper] getFriendInfoByUserID:userID];
            if (user.showName.length > 0) {
                if (_groupName == nil || _groupName.length <= 0) {
                    _groupName = user.showName;
                }
                else {
                    _groupName = [NSString stringWithFormat:@"%@,%@", _groupName, user.showName];
                }
            }
        }
    }
    return _groupName;
}

- (NSString *)groupAvatarPath
{
    if (_groupAvatarPath == nil || _groupAvatarPath.length == 0) {
//        for (NSString *userID in self.users) {
//            TLUser *user = [[TLFriendHelper sharedFriendHelper] getFriendInfoByUserID:userID];
//          
//        }
    }
    return _groupAvatarPath;
}

- (NSString *)myNikeName
{
    if (_myNikeName.length == 0) {
        _myNikeName = [TLUserHelper sharedHelper].user.showName;
    }
    return _myNikeName;
}

@end
