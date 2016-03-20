//
//  TLChatBaseViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLChatTableViewController.h"
#import "TLEmojiDisplayView.h"
#import "TLImageExpressionDisplayView.h"

#import "TLMoreKeyboardDelegate.h"
#import "TLMessageManager+MessageRecord.h"

#import "TLChatBar.h"
#import "TLMoreKeyboard.h"
#import "TLEmojiKeyboard.h"

#import "TLUser.h"
#import "TLGroup.h"

typedef NS_ENUM(NSUInteger, TLChatVCType) {
    TLChatVCTypeFriend,
    TLChatVCTypeGroup,
};

@interface TLChatBaseViewController : UIViewController <TLMoreKeyboardDelegate>
{
    TLChatBarStatus lastStatus;
    TLChatBarStatus curStatus;
}

/// 当前聊天类型 （赋值User或Group时自动设置）
@property (nonatomic, assign, readonly) TLChatVCType curChatType;

@property (nonatomic, strong) TLUser *user;

@property (nonatomic, strong) TLGroup *group;


/// 消息展示页面
@property (nonatomic, strong) TLChatTableViewController *chatTableVC;

/// 聊天输入栏
@property (nonatomic, strong) TLChatBar *chatBar;

/// 更多键盘
@property (nonatomic, strong) TLMoreKeyboard *moreKeyboard;

/// 表情键盘
@property (nonatomic, strong) TLEmojiKeyboard *emojiKeyboard;

/// emoji展示view
@property (nonatomic, strong) TLEmojiDisplayView *emojiDisplayView;

/// 图片表情展示view
@property (nonatomic, strong) TLImageExpressionDisplayView *imageExpressionDisplayView;


/**
 *  设置“更多”键盘元素
 */
- (void)setChatMoreKeyboardData:(NSMutableArray *)moreKeyboardData;

/**
 *  设置“表情”键盘元素
 */
- (void)setChatEmojiKeyboardData:(NSMutableArray *)emojiKeyboardData;

/**
 *  发送图片信息
 */
- (void)sendImageMessage:(UIImage *)image;

/**
 *  重置chatVC
 */
- (void)resetChatVC;

@end
