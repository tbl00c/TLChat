//
//  UIAlertView+ActionBlocks.h
//  TLKit
//
//  Created by 李伯坤 on 2017/9/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (ActionBlocks)

@property (nonatomic, copy) void (^tt_actionBlock)(UIAlertView *alertView, NSInteger buttonIndex);

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
        actionBlock:(void (^)(UIAlertView *alertView, NSInteger buttonIndex))actionBlock
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

@end
