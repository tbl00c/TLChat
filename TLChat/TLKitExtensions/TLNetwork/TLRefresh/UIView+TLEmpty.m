//
//  UIView+TLEmpty.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/23.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#define     TAG_VIEW_EMPTY          -10241001
#define     TAG_VIEW_ERROR          -10241002

#import "UIView+TLEmpty.h"
#import "UIView+Extensions.h"

@implementation UIView (TLEmpty)

- (void)showEmptyViewWithTitle:(NSString *)title
{
    [self showEmptyViewWithTitle:title atView:self];
}

- (void)showEmptyViewWithTitle:(NSString *)title atView:(UIView *)superView
{
    [self showEmptyViewWithTitle:title rect:self.bounds atView:superView];
}

- (void)showEmptyViewWithTitle:(NSString *)title rect:(CGRect)rect atView:(UIView *)superView
{
    UILabel *label = [self viewWithTag:TAG_VIEW_EMPTY];
    if (!label) {
        label = [[UILabel alloc] initWithFrame:rect];
        [label setTag:TAG_VIEW_EMPTY];
        [label setNumberOfLines:0];
        [label setFont:[UIFont systemFontOfSize:16]];
        [label setTextColor:[UIColor grayColor]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [superView addSubview:label];
    }
    if (title.length == 0) {
        title = @"没有请求到相应数据";
    }
    [label setText:title];
}

- (void)removeEmptyView
{
    UILabel *label = [self viewWithTag:TAG_VIEW_EMPTY];
    if (label) {
        [label removeFromSuperview];
    }
}

- (void)showErrorViewWithTitle:(NSString *)title
{
    UIButton *errorView = [self viewWithTag:TAG_VIEW_ERROR];
    if (!errorView) {
        errorView = [[UIButton alloc] initWithFrame:self.bounds];
        [errorView setTag:TAG_VIEW_ERROR];
        [errorView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [errorView setBackgroundColor:[UIColor colorGrayBG]];
        [errorView.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [errorView.titleLabel setNumberOfLines:0];
        [errorView addTarget:self action:@selector(errorViewDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:errorView];
    }
    if (title.length == 0) {
        title = @"网络请求失败，请点击重试";
    }
    [errorView setTitle:title forState:UIControlStateNormal];
}

- (void)removeErrorView
{
    UIButton *errorView = [self viewWithTag:TAG_VIEW_ERROR];
    if (errorView) {
        [errorView removeFromSuperview];
    }
}

- (void)errorViewDidClick:(UIButton *)sender
{
    [self removeEmptyView];
    if ([self.viewController respondsToSelector:@selector(requestRetry:)]) {
        [self.viewController requestRetry:sender];
    }
}

@end

@implementation  UIViewController (TLEmpty)

- (void)showEmptyViewWithTitle:(NSString *)title
{
    [self.view showEmptyViewWithTitle:title];
}

- (void)showEmptyViewWithTitle:(NSString *)title atView:(UIView *)superView
{
    [self.view showEmptyViewWithTitle:title atView:superView];
}

- (void)showEmptyViewWithTitle:(NSString *)title rect:(CGRect)rect atView:(UIView *)superView
{
    [self.view showEmptyViewWithTitle:title rect:rect atView:superView];
}

- (void)removeEmptyView
{
    [self.view removeEmptyView];
}

- (void)showErrorViewWithTitle:(NSString *)title
{
    [self.view showErrorViewWithTitle:title];
}

- (void)removeErrorView;
{
    [self.view removeErrorView];
}

- (void)requestRetry:(UIButton *)sender
{
    [self removeEmptyView];
    [self removeErrorView];
}

@end
