//
//  TLChatBar.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TLChatBarStatus) {
    TLChatBarStatusInit,
    TLChatBarStatusVoice,
    TLChatBarStatusEmoji,
    TLChatBarStatusMore,
    TLChatBarStatusKeyboard,
};

@class TLChatBar;
@protocol TLChatBarDelegate <NSObject>

/**
 *  键盘状态改变
 */
- (void)chatBar:(TLChatBar *)chatBar changeStatusFrom:(TLChatBarStatus)fromStatus to:(TLChatBarStatus)toStatus;

/**
 *  发送文字
 */
- (void)chatBar:(TLChatBar *)chatBar sendText:(NSString *)text;

@end

@interface TLChatBar : UIView

@property (nonatomic, assign) id<TLChatBarDelegate> delegate;

@property (nonatomic, assign) TLChatBarStatus status;

@end
