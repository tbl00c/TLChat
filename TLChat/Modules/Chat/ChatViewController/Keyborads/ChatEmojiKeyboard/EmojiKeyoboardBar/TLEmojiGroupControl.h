//
//  TLEmojiGroupControl.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/19.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLExpressionGroupModel.h"

typedef NS_ENUM(NSInteger, TLGroupControlSendButtonStatus) {
    TLGroupControlSendButtonStatusGray,
    TLGroupControlSendButtonStatusBlue,
    TLGroupControlSendButtonStatusNone,
};

@class TLEmojiGroupControl;
@protocol TLEmojiGroupControlDelegate <NSObject>

- (void)emojiGroupControl:(TLEmojiGroupControl*)emojiGroupControl didSelectedGroup:(TLExpressionGroupModel *)group;

- (void)emojiGroupControlEditButtonDown:(TLEmojiGroupControl *)emojiGroupControl;

- (void)emojiGroupControlEditMyEmojiButtonDown:(TLEmojiGroupControl *)emojiGroupControl;

- (void)emojiGroupControlSendButtonDown:(TLEmojiGroupControl *)emojiGroupControl;

@end

@interface TLEmojiGroupControl : UIView

@property (nonatomic, assign) TLGroupControlSendButtonStatus sendButtonStatus;

@property (nonatomic, strong) NSMutableArray *emojiGroupData;

@property (nonatomic, assign) id<TLEmojiGroupControlDelegate>delegate;

- (void)selectEmojiGroupAtIndex:(NSInteger)index;

@end
