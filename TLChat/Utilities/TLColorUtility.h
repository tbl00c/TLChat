//
//  TLColorUtility.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLColorUtility : NSObject

#pragma mark - Global
+ (UIColor *) colorTableViewBG;

+ (UIColor *) colorTabBarTint;
+ (UIColor *) colorTabBarBG;

+ (UIColor *) colorNavBarTint;
+ (UIColor *) colorNavBarBarTint;

+ (UIColor *) colorSearchBarTint;
+ (UIColor *) colorSearchBarBorder;

+ (UIColor *) colorCellLine;
+ (UIColor *) colorCellDeleteButton;
+ (UIColor *) colorCellMoreButton;

#pragma mark - Conversation
+ (UIColor *) colorConversationDetail;
+ (UIColor *) colorConversationTime;

#pragma mark - Friends


@end
