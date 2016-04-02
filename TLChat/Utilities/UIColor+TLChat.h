//
//  UIColor+TLChat.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/27.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TLChat)

#pragma mark - Global
/**
 *  默认背景色
 */
+ (UIColor *)colorTableViewBG;

/**
 *  默认的绿色
 */
+ (UIColor *)colorDefaultGreen;

/**
 *  默认的灰色
 */
+ (UIColor *)colorDefaultBlack;

+ (UIColor *)colorTabBarBG;

+ (UIColor *)colorNavBarTint;
+ (UIColor *)colorNavBarBarTint;

+ (UIColor *)colorSearchBarTint;
+ (UIColor *)colorSearchBarBorder;

+ (UIColor *)colorCellLine;
+ (UIColor *)colorCellMoreButton;

#pragma mark - Conversation
+ (UIColor *)colorConversationDetail;
+ (UIColor *)colorConversationTime;
+ (UIColor *)colorNavAddMenuBG;
+ (UIColor *)colorNavAddMenuBGHL;

#pragma mark - Friends

#pragma mark - Discover
+ (UIColor *)colorBlackBG;
+ (UIColor *)colorScannerBG;


#pragma mark - Chat
+ (UIColor *)colorChatTableViewBG;
+ (UIColor *)colorChatBar;
+ (UIColor *)colorChatBox;
+ (UIColor *)colorChatBoxLine;
+ (UIColor *)colorChatEmojiSend;

#pragma mark - WebView
+ (UIColor *)colorWebViewAuthText;
@end
