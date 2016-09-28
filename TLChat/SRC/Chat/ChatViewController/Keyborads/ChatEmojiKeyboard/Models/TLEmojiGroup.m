//
//  TLEmojiGroup.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/19.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiGroup.h"

@implementation TLEmojiGroup

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
    self.pageItemCount = self.rowNumber * self.colNumber;
    self.pageNumber = self.count / self.pageItemCount + (self.count % self.pageItemCount == 0 ? 0 : 1);
}

- (id)objectAtIndex:(NSUInteger)index
{
    return [self.data objectAtIndex:index];
}

- (NSUInteger)rowNumber
{
    if (self.type == TLEmojiTypeFace || self.type == TLEmojiTypeEmoji) {
        return 3;
    }
    return 2;
}

- (NSUInteger)colNumber
{
    if (self.type == TLEmojiTypeFace || self.type == TLEmojiTypeEmoji) {
        return 7;
    }
    return 4;
}

- (NSUInteger)pageItemCount
{
    if (self.type == TLEmojiTypeFace || self.type == TLEmojiTypeEmoji) {
        return self.rowNumber * self.colNumber - 1;
    }
    return self.rowNumber * self.colNumber;
}

- (NSUInteger)pageNumber
{
    return self.count / self.pageItemCount + (self.count % self.pageItemCount == 0 ? 0 : 1);
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
