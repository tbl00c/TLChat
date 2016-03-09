//
//  TLEmojiGroup.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/19.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiGroup.h"

@implementation TLEmojiGroup

- (void)setType:(TLEmojiType)type
{
    _type = type;
    switch (type) {
        case TLEmojiTypeFace:
        case TLEmojiTypeEmoji:
            self.lineNumber = 3;
            self.rowNumber = 7;
            break;
        case TLEmojiTypeImage:
        case TLEmojiTypeFavorite:
        case TLEmojiTypeImageWithTitle:
            self.lineNumber = 2;
            self.rowNumber = 4;
            break;
        default:
            break;
    }
    self.pageItemNumber = self.lineNumber * self.rowNumber;
    self.pageNumber = self.count / self.pageItemNumber + (self.count % self.pageItemNumber == 0 ? 0 : 1);
}

- (void)setData:(NSMutableArray *)data
{
    _data = data;
    self.pageItemNumber = self.lineNumber * self.rowNumber;
    self.pageNumber = self.count / self.pageItemNumber + (self.count % self.pageItemNumber == 0 ? 0 : 1);
}

- (NSUInteger)count
{
    return self.data.count;
}

- (id)objectAtIndex:(NSUInteger)index
{
    return [self.data objectAtIndex:index];
}

@end
