//
//  UIColor+TLChat.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/27.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "UIColor+TLChat.h"

@implementation UIColor (TLChat)


#pragma mark - Global
+ (UIColor *) colorTableViewBG
{
    return TLColor(239.0, 239.0, 244.0, 1.0);
}

+ (UIColor *) colorTabBarTint
{
    return TLColor(2.0, 187.0, 0.0, 1.0f);
}

+ (UIColor *) colorTabBarBG
{
    return TLColor(239.0, 239.0, 244.0, 1.0);
}

+ (UIColor *) colorNavBarTint
{
    return [UIColor whiteColor];
}

+ (UIColor *) colorNavBarBarTint
{
    return TLColor(20.0, 20.0, 20.0, 0.9);
}

+ (UIColor *) colorSearchBarTint
{
    return TLColor(239.0, 239.0, 244.0, 1.0);
}

+ (UIColor *) colorSearchBarBorder
{
    return [UIColor colorSearchBarTint];
    //    return TLColor(220, 220, 220, 1.0);
}

+ (UIColor *) colorCellLine
{
    return [UIColor colorWithWhite:0.5 alpha:0.3];
}

+ (UIColor *) colorCellMoreButton
{
    return [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0];
}

#pragma mark - Conversation
+ (UIColor *) colorConversationDetail
{
    return [UIColor grayColor];
}

+ (UIColor *) colorConversationTime
{
    return TLColor(160, 160, 160, 1.0);
}

@end
