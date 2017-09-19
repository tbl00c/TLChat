//
//  TLActionSheet.h
//  TLChat
//
//  Created by 李伯坤 on 16/5/1.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLActionSheet;
@protocol TLActionSheetDelegate <NSObject>

@optional;
- (void)actionSheet:(TLActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end


@interface TLActionSheet : UIView

/// 按钮个数
@property (nonatomic, assign, readonly) NSInteger numberOfButtons;

/// 取消按钮index
@property (nonatomic, assign, readonly) NSInteger cancelButtonIndex;

/// 高亮按钮index
@property (nonatomic, assign, readonly) NSInteger destructiveButtonIndex;

@property (nonatomic, weak) id<TLActionSheetDelegate> delegate;

/// 点击事件响应block
@property (nonatomic, copy) void (^clickAction)(NSInteger buttonIndex);

- (id)initWithTitle:(NSString *)title
           delegate:(id<TLActionSheetDelegate>)delegate
  cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...;


- (id)initWithTitle:(NSString *)title
        clickAction:(void (^)(NSInteger buttonIndex))clickAction
  cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...;

/**
 *  显示ActionSheet
 */
- (void)show;

/**
 *  根据index获取按钮标题
 *
 *  @param  buttonIndex     按钮index
 */
- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;

@end
