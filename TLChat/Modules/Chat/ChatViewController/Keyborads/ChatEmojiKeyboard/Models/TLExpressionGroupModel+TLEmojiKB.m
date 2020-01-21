//
//  TLExpressionGroupModel+TLEmojiKB.m
//  TLChat
//
//  Created by 李伯坤 on 2018/1/2.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLExpressionGroupModel+TLEmojiKB.h"

@implementation TLExpressionGroupModel (TLEmojiKB)

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

@end
