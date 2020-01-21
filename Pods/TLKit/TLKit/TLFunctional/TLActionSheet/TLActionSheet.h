//
//  TLActionSheet.h
//  TLChat
//
//  Created by 李伯坤 on 16/5/1.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLActionSheetItem : NSObject

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, copy) void (^selectAction)(TLActionSheetItem *item);

@end


@interface TLActionSheet : UIView

@property (nonatomic, strong) NSMutableArray *otherButtonTitles;

/// 按钮个数
@property (nonatomic, assign, readonly) NSInteger numberOfButtons;

/// 取消按钮index
@property (nonatomic, assign, readonly) NSInteger cancelButtonIndex;

/// 高亮按钮index
@property (nonatomic, assign, readonly) NSInteger destructiveButtonIndex;

/// 点击事件响应block
@property (nonatomic, copy) void (^clickAction)(NSInteger buttonIndex);

- (id)initWithTitle:(NSString *)title
        clickAction:(void (^)(NSInteger buttonIndex))clickAction
  cancelButtonTitle:(NSString *)cancelButtonTitle
destructiveButtonTitle:(NSString *)destructiveButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...;

@property (nonatomic, strong) UIView *customHeaderView;
@property (nonatomic, copy) void (^cellConfigAction)(UITableViewCell *cell, id title);

/**
 *  显示ActionSheet
 */
- (void)show;

/**
 *  隐藏ActionSheet
 */
- (void)dismiss;

/**
 *  根据index获取按钮标题
 *
 *  @param  buttonIndex     按钮index
 */
- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;

@end
