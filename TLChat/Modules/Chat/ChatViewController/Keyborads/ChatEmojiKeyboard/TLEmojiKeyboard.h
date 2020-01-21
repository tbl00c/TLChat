//
//  TLEmojiKeyboard.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLBaseKeyboard.h"
#import "TLEmojiKeyboardDelegate.h"
#import "TLEmojiGroupControl.h"
#import "TLEmojiGroupDisplayView.h"

@interface TLEmojiKeyboard : TLBaseKeyboard

@property (nonatomic, strong) NSMutableArray *emojiGroupData;

@property (nonatomic, assign) id<TLEmojiKeyboardDelegate> delegate;

@property (nonatomic, strong) TLExpressionGroupModel *curGroup;

@property (nonatomic, strong) TLEmojiGroupDisplayView *displayView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) TLEmojiGroupControl *groupControl;

+ (TLEmojiKeyboard *)keyboard;

@end
