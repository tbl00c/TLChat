
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

@end
