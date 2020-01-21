//
//  TLEmojiGroupDisplayViewDelegate.h
//  TLChat
//
//  Created by 李伯坤 on 16/9/27.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TLExpressionModel;
@class TLEmojiGroupDisplayView;
@protocol TLEmojiGroupDisplayViewDelegate <NSObject>

/**
 *  发送按钮点击事件
 */
- (void)emojiGroupDisplayViewDeleteButtonPressed:(TLEmojiGroupDisplayView *)displayView;

/**
 *  选中表情
 */
- (void)emojiGroupDisplayView:(TLEmojiGroupDisplayView *)displayView didClickedEmoji:(TLExpressionModel *)emoji;

/**
 *  翻页
 */
- (void)emojiGroupDisplayView:(TLEmojiGroupDisplayView *)displayView didScrollToPageIndex:(NSInteger)pageIndex forGroupIndex:(NSInteger)groupIndex;

/**
 *  表情长按
 */
- (void)emojiGroupDisplayView:(TLEmojiGroupDisplayView *)displayView didLongPressEmoji:(TLExpressionModel *)emoji atRect:(CGRect)rect;

/**
 *  停止表情长按
 */
- (void)emojiGroupDisplayViewDidStopLongPressEmoji:(TLEmojiGroupDisplayView *)displayView;

@end
