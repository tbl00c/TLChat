
//
//  TLUIUtility.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLUIUtility.h"

static UILabel *hLabel = nil;

@implementation TLUIUtility

#pragma mark - # Alert
+ (void)showAlertWithTitle:(NSString *)title
{
    [self showAlertWithTitle:title message:nil];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message
{
    [self showAlertWithTitle:title message:message cancelButtonTitle:nil];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle
{
    [self showAlertWithTitle:title message:message cancelButtonTitle:cancelButtonTitle actionHandler:nil];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle actionHandler:(void (^)(NSInteger buttonIndex))actionHandler
{
    [self showAlertWithTitle:title message:message cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil actionHandler:actionHandler];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles actionHandler:(void (^)(NSInteger buttonIndex))actionHandler
{
    cancelButtonTitle = cancelButtonTitle ? cancelButtonTitle : LOCSTR(@"取消");
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        TLWeakSelf(alertController);
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSInteger index = [weakalertController.actions indexOfObject:action];
            if (actionHandler) {
                actionHandler(index);
            }
        }];
        [alertController addAction:cancelAction];
        
        for (NSString *title in otherButtonTitles) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (actionHandler) {
                    NSInteger index = [weakalertController.actions indexOfObject:action];
                    actionHandler(index);
                }
            }];
            [alertController addAction:action];
        }
        
        UIViewController *curVC = [UIApplication sharedApplication].keyWindow.visibleViewController;
        [curVC presentViewController:alertController animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message actionBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (actionHandler) {
                actionHandler(buttonIndex);
            }
        } cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    
        for (NSString *title in otherButtonTitles) {
            [alertView addButtonWithTitle:title];
        }
        [alertView show];
    }
}

@end
