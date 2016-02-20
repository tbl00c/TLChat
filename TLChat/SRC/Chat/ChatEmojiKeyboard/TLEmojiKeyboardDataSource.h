//
//  TLEmojiKeyboardDataSource.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLEmojiGroup.h"

@protocol TLEmojiKeyboardDataSource <NSObject>

@optional
- (NSMutableArray *)emojiKeyboard:(id)emojiKeyboard emojiDataForGroupItem:(TLEmojiGroup *)item;

@end
