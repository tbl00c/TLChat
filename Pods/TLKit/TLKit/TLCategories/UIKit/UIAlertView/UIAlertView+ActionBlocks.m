//
//  UIAlertView+ActionBlocks.m
//  TLKit
//
//  Created by 李伯坤 on 2017/9/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "UIAlertView+ActionBlocks.h"
#import <objc/runtime.h>

static char *__tt_alertview_action_block = "__tt_alertview_action_block";

@implementation UIAlertView (ActionBlocks)

- (id)initWithTitle:(NSString *)title message:(NSString *)message actionBlock:(void (^)(UIAlertView *alertView, NSInteger buttonIndex))actionBlock cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION
{
    if (self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil]) {
        [self setTt_actionBlock:actionBlock];
        if (otherButtonTitles) {
            NSString *otherTitle;
            va_list args;
            va_start(args, otherButtonTitles);
            while ((otherTitle = va_arg(args, NSString *))) {
                [self addButtonWithTitle:otherTitle];
            }
            va_end(args);
        }
    }
    return self;
}

- (void)setTt_actionBlock:(void (^)(UIAlertView *alertView, NSInteger buttonIndex))actionBlock
{
    objc_setAssociatedObject(self, &__tt_alertview_action_block, actionBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UIAlertView *alertView, NSInteger buttonIndex))tt_actionBlock
{
    return objc_getAssociatedObject(self, &__tt_alertview_action_block);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.tt_actionBlock) {
        self.tt_actionBlock(self, buttonIndex);
    }
}

@end
