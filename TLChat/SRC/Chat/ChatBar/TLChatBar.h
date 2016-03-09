//
//  TLChatBar.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLChatBarDelegate.h"

@class TLChatBar;
@protocol TLChatBarDataDelegate <NSObject>
/**
 *  发送文字
 */
- (void)chatBar:(TLChatBar *)chatBar sendText:(NSString *)text;
@end

@interface TLChatBar : UIView

@property (nonatomic, assign) id<TLChatBarDelegate> delegate;

@property (nonatomic, assign) id<TLChatBarDataDelegate> dataDelegate;

@property (nonatomic, assign) TLChatBarStatus status;

- (void)addEmojiString:(NSString *)emojiString;

- (void)sendCurrentText;

@end
