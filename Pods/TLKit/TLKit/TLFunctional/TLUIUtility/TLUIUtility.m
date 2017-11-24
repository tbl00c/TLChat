
//
//  TLUIUtility.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLUIUtility.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UIWindow+Extensions.h"
#import "UIAlertView+ActionBlocks.h"

static UILabel *hLabel = nil;

@implementation TLUIUtility
+ (void)load
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumSize:CGSizeMake(110, 110)];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
}

#pragma mark - # HUD
+ (void)showLoading:(NSString *)hintText
{
    [SVProgressHUD showWithStatus:nil];
}

+ (void)hiddenLoading
{
    [self hiddenLoadingWithCompletion:nil];
}

+ (void)hiddenLoadingWithDelay:(NSTimeInterval)delay
{
    [self hiddenLoadingWithDelay:delay completion:nil];
}

+ (void)hiddenLoadingWithCompletion:(void (^)())completion
{
    [SVProgressHUD dismissWithCompletion:completion];
}

+ (void)hiddenLoadingWithDelay:(NSTimeInterval)delay completion:(void (^)())completion
{
    [SVProgressHUD dismissWithDelay:delay completion:completion];
}

+ (void)showSuccessHint:(NSString *)hintText
{
    [SVProgressHUD showSuccessWithStatus:hintText];
}

+ (void)showErrorHint:(NSString *)hintText
{
    [SVProgressHUD showErrorWithStatus:hintText];
}

+ (void)showInfoHint:(NSString *)hintText
{
    [SVProgressHUD showInfoWithStatus:hintText];
}

+ (BOOL)isShowLoading
{
    return [SVProgressHUD isVisible];
}

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
    cancelButtonTitle = cancelButtonTitle ? cancelButtonTitle : @"取消";
    if (([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending)) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        __weak typeof(alertController) weakController = alertController;
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSInteger index = [weakController.actions indexOfObject:action];
            if (actionHandler) {
                actionHandler(index);
            }
        }];
        [alertController addAction:cancelAction];
        
        for (NSString *title in otherButtonTitles) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (actionHandler) {
                    NSInteger index = [weakController.actions indexOfObject:action];
                    actionHandler(index);
                }
            }];
            [alertController addAction:action];
        }
        
        UIViewController *curVC = [(UIWindow *)[UIApplication sharedApplication].keyWindow visibleViewController];
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
