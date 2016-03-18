//
//  TLChatBar.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLChatBarDelegate.h"

@interface TLChatBar : UIView

@property (nonatomic, assign) id<TLChatBarDelegate> delegate;

@property (nonatomic, assign) id<TLChatBarDataDelegate> dataDelegate;

@property (nonatomic, assign) TLChatBarStatus status;

@property (nonatomic, strong, readonly) NSString *curText;

@property (nonatomic, assign) BOOL activity;

- (void)addEmojiString:(NSString *)emojiString;

- (void)sendCurrentText;

@end
