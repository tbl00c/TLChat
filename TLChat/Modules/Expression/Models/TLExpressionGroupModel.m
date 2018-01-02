//
//  TLExpressionGroupModel.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/19.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionGroupModel.h"
#import "NSFileManager+TLChat.h"

@implementation TLExpressionGroupModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"groupID" : @"eId",
             @"groupIconURL" : @"coverUrl",
             @"groupName" : @"eName",
             @"groupInfo" : @"memo",
             @"groupDetailInfo" : @"memo1",
             @"count" : @"picCount",
             @"bannerID" : @"aId",
             @"bannerURL" : @"URL",
             };
}

- (void)setData:(NSMutableArray *)data
{
    _data = data;
    self.count = data.count;
}

- (id)objectAtIndex:(NSUInteger)index
{
    return [self.data objectAtIndex:index];
}


- (NSString *)path
{
    if (_path == nil && self.groupID != nil) {
        _path = [NSFileManager pathExpressionForGroupID:self.groupID];
    }
    return _path;
}

- (NSString *)groupIconPath
{
    if (_groupIconPath == nil && self.path != nil) {
        _groupIconPath = [NSString stringWithFormat:@"%@icon_%@", self.path, self.groupID];
    }
    return _groupIconPath;
}

@end
