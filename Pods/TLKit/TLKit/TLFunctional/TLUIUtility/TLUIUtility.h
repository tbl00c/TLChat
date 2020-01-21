//
//  TLUIUtility.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLUIUtility : NSObject

#pragma mark - # HUD
+ (void)showLoading:(NSString *)title;
+ (void)hiddenLoading;
+ (void)hiddenLoadingWithDelay:(NSTimeInterval)delay;
+ (void)hiddenLoadingWithCompletion:(void (^)())completion;
+ (void)hiddenLoadingWithDelay:(NSTimeInterval)delay completion:(void (^)())completion;

+ (void)showSuccessHint:(NSString *)hintText;
+ (void)showErrorHint:(NSString *)hintText;
+ (void)showInfoHint:(NSString *)hintText;

+ (BOOL)isShowLoading;

#pragma mark - # Alert
+ (void)showAlertWithTitle:(NSString *)title;
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle;
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle actionHandler:(void (^)(NSInteger buttonIndex))actionHandler;
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles actionHandler:(void (^)(NSInteger buttonIndex))actionHandler;

@end
