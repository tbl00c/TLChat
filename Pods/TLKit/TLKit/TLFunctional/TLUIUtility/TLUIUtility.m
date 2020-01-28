
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
#import "TLAlertView.h"

static UILabel *hLabel = nil;

@implementation TLUIUtility
+ (void)initialize
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumSize:CGSizeMake(110, 110)];
    [SVProgressHUD setMinimumDismissTimeInterval:1.0f];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
}

#pragma mark - # HUD
+ (void)showLoading:(NSString *)hintText
{
    [SVProgressHUD showWithStatus:hintText];
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
    [self showAlertWithTitle:title message:message cancelButtonTitle:@"确定"];
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
    TLAlertViewItemClickAction clickAction = ^(TLAlertView *actionSheet, TLAlertViewItem *item, NSInteger index) {
        if (actionHandler) {
            actionHandler(index);
        }
    };
    TLAlertView *alertView = [[TLAlertView alloc] initWithTitle:title message:message];
    if (cancelButtonTitle.length > 0) {
        if (otherButtonTitles.count == 0) {
            [alertView addItemWithTitle:cancelButtonTitle clickAction:nil];
        }
        else {
            [alertView addCancelItemTitle:cancelButtonTitle clickAction:clickAction];
        }
    }
    for (NSString *title in otherButtonTitles) {
        [alertView addItemWithTitle:title clickAction:clickAction];
    }
    [alertView show];
}

@end
