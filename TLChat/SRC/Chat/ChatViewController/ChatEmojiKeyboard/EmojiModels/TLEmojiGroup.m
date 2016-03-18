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
    self.pageItemCount = self.rowNumber * self.colNumber;
    self.pageNumber = self.count / self.pageItemCount + (self.count % self.pageItemCount == 0 ? 0 : 1);
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
