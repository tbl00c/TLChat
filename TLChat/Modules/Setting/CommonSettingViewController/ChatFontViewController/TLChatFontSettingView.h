//
//  TLChatFontSettingView.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

#define     MIN_FONT_SIZE           15.0f
#define     STANDARD_FONT_SZIE      16.0f
#define     MAX_FONT_SZIE           20.0f

@interface TLChatFontSettingView : UIView

@property (nonatomic, assign) CGFloat curFontSize;

@property (nonatomic, copy) void (^fontSizeChangeTo)(CGFloat size);


@end
