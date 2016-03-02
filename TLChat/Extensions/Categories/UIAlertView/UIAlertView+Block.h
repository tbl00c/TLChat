//
//  UIAlertView+Blocks.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/24.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIAlertViewCallBackBlock)(NSInteger buttonIndex);

@interface UIAlertView (Block)<UIAlertViewDelegate>

@property (nonatomic, copy) UIAlertViewCallBackBlock alertViewCallBackBlock;

+ (void)alertWithCallBackBlock:(UIAlertViewCallBackBlock)alertViewCallBackBlock
                         title:(NSString *)title message:(NSString *)message
              cancelButtonName:(NSString *)cancelButtonName
             otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message;

@end
