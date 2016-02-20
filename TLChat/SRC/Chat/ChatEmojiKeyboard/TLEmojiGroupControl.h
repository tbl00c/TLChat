//
//  TLEmojiGroupControl.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/19.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLEmojiGroup.h"

@class TLEmojiGroupControl;
@protocol TLEmojiGroupControlDelegate <NSObject>

- (void)emojiGroupControl:(TLEmojiGroupControl*)emojiGroupControl didSelectedGroup:(TLEmojiGroup *)group;

@end

@interface TLEmojiGroupControl : UIView

@property (nonatomic, strong) NSMutableArray *emojiGroupData;

@property (nonatomic, assign) id<TLEmojiGroupControlDelegate>delegate;

- (void)selectGroupIndex:(NSUInteger)groupIndex;

@end
