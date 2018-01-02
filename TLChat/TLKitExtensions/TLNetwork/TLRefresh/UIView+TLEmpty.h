//
//  UIView+TLEmpty.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/23.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TLEmpty)

- (void)showEmptyViewWithTitle:(NSString *)title;
- (void)showEmptyViewWithTitle:(NSString *)title atView:(UIView *)superView;
- (void)showEmptyViewWithTitle:(NSString *)title rect:(CGRect)rect atView:(UIView *)superView;
- (void)removeEmptyView;

- (void)showErrorViewWithTitle:(NSString *)title;
- (void)removeErrorView;

@end

@interface UIViewController (TLEmpty)

- (void)showEmptyViewWithTitle:(NSString *)title;
- (void)showEmptyViewWithTitle:(NSString *)title atView:(UIView *)superView;
- (void)showEmptyViewWithTitle:(NSString *)title rect:(CGRect)rect atView:(UIView *)superView;
- (void)removeEmptyView;

- (void)showErrorViewWithTitle:(NSString *)title;
- (void)removeErrorView;

- (void)requestRetry:(UIButton *)sender;

@end
