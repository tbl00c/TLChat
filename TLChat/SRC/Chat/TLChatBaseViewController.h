//
//  TLChatBaseViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLMoreKeyboardDelegate.h"
#import "TLChatTableView.h"

#import "TLChatBar.h"
#import "TLMoreKeyboard.h"
#import "TLEmojiKeyboard.h"

#import "TLUser.h"
#import "TLGroup.h"

typedef NS_ENUM(NSUInteger, TLChatVCType) {
    TLChatVCTypeFriend,
    TLChatVCTypeGroup,
};

@interface TLChatBaseViewController : UIViewController <TLMoreKeyboardDelegate, TLEmojiKeyboardDelegate>

/**
 *  当前聊天类型 （赋值User或Group时自动设置）
 */
@property (nonatomic, assign, readonly) TLChatVCType curChatType;

@property (nonatomic, strong) TLUser *user;

@property (nonatomic, strong) TLGroup *group;

/// 聊天数据
@property (nonatomic, strong) NSMutableArray *data;

/// UI
@property (nonatomic, strong) TLChatTableView *tableView;

@property (nonatomic, strong) TLChatBar *chatBar;

@property (nonatomic, strong) TLMoreKeyboard *moreKeyboard;

@property (nonatomic, strong) TLEmojiKeyboard *emojiKeyboard;


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
- (void)sendImageMessage:(NSString *)imagePath;

@end
