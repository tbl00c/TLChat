//
//  TLEmojiKeyboard+CollectionViewDataSource.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiKeyboard.h"
#import "TLEmojiItemCell.h"
#import "TLEmojiFaceItemCell.h"
#import "TLEmojiImageItemCell.h"
#import "TLEmojiImageTitleItemCell.h"

@interface TLEmojiKeyboard (CollectionViewDataSource) <UICollectionViewDataSource>

- (void)registerCellClass;

- (NSUInteger)transformCellIndex:(NSInteger)index;

- (NSUInteger)transformModelIndex:(NSInteger)index;

@end
