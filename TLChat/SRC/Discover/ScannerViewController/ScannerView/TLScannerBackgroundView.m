//
//  TLScannerBackgroundView.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLScannerBackgroundView.h"

@interface TLScannerBackgroundView ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *btmView;
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;

@end

@implementation TLScannerBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.topView];
        [self addSubview:self.btmView];
        [self addSubview:self.leftView];
        [self addSubview:self.rightView];
    }
    return self;
}

#pragma mark - Public Methods -
- (void)addMasonryWithContainView:(UIView *)containView
{
    UIView *scannerView = containView;
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(self);
        make.bottom.mas_equalTo(scannerView.mas_top);
    }];
    [self.btmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(self);
        make.top.mas_equalTo(scannerView.mas_bottom);
    }];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(scannerView.mas_left);
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.bottom.mas_equalTo(self.btmView.mas_top);
    }];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scannerView.mas_right);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.bottom.mas_equalTo(self.btmView.mas_top);
    }];
}

#pragma mark - Getter -
- (UIView *)topView
{
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        [_topView setBackgroundColor:[UIColor colorBlackAlphaScannerBG]];
    }
    return _topView;
}

- (UIView *)btmView
{
    if (_btmView == nil) {
        _btmView = [[UIView alloc] init];
        [_btmView setBackgroundColor:[UIColor colorBlackAlphaScannerBG]];
    }
    return _btmView;
}

- (UIView *)leftView
{
    if (_leftView == nil) {
        _leftView = [[UIView alloc] init];
        [_leftView setBackgroundColor:[UIColor colorBlackAlphaScannerBG]];
    }
    return _leftView;
}

- (UIView *)rightView
{
    if (_rightView == nil) {
        _rightView = [[UIView alloc] init];
        [_rightView setBackgroundColor:[UIColor colorBlackAlphaScannerBG]];
    }
    return _rightView;
}

@end
