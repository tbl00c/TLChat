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
             };
}

- (id)init
{
    if (self = [super init]) {
        [self setType:TLEmojiTypeImageWithTitle];
    }
    return self;
}

- (void)setType:(TLEmojiType)type
{
    _type = type;
    switch (type) {
        case TLEmojiTypeOther:
            return;
        case TLEmojiTypeFace:
        case TLEmojiTypeEmoji:
            self.rowNumber = 3;
            self.colNumber = 7;
            break;
        case TLEmojiTypeImage:
        case TLEmojiTypeFavorite:
        case TLEmojiTypeImageWithTitle:
            self.rowNumber = 2;
            self.colNumber = 4;
            break;
        default:
            break;
    }
    self.pageItemCount = self.rowNumber * self.colNumber;
    self.pageNumber = self.count / self.pageItemCount + (self.count % self.pageItemCount == 0 ? 0 : 1);
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
