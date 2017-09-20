//
//  TLChatFontSettingView.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatFontSettingView.h"

@interface TLChatFontSettingView ()

@property (nonatomic, strong) UILabel *miniFontLabel;

@property (nonatomic, strong) UILabel *maxFontLabel;

@property (nonatomic, strong) UILabel *standardFontLabel;

@property (nonatomic, strong) UISlider *slider;

@end

@implementation TLChatFontSettingView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.miniFontLabel];
        [self addSubview:self.maxFontLabel];
        [self addSubview:self.standardFontLabel];
        [self addSubview:self.slider];
        [self p_addMasonry];
    }
    return self;
}

- (void)setCurFontSize:(CGFloat)curFontSize
{
    _curFontSize = curFontSize;
    [self.slider setValue:curFontSize];
}

#pragma mark - Event Response -
- (void)sliderValueChanged:(UISlider *)sender
{
    NSInteger value = (NSInteger)sender.value;
    value = ((sender.value - value) > 0.5 ? value + 1 : value);
    if (value == (NSInteger)_curFontSize) {
        return;
    }
    _curFontSize = value;
    if (self.fontSizeChangeTo) {
        self.fontSizeChangeTo(value);
    }
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.miniFontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.slider.mas_left);
        make.bottom.mas_equalTo(self.slider.mas_top).mas_offset(-6);
    }];
    
    [self.maxFontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.slider.mas_right);
        make.bottom.mas_equalTo(self.miniFontLabel);
    }];
    
    [self.standardFontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.miniFontLabel);
        make.left.mas_equalTo(self.miniFontLabel.mas_right).mas_equalTo(40);
    }];
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-35);
        make.width.mas_equalTo(self).multipliedBy(0.8);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark - Getter -
- (UILabel *)miniFontLabel
{
    if (_miniFontLabel == nil) {
        _miniFontLabel = [[UILabel alloc] init];
        [_miniFontLabel setFont:[UIFont systemFontOfSize:MIN_FONT_SIZE]];
        [_miniFontLabel setText:@"A"];
    }
    return _miniFontLabel;
}

- (UILabel *)maxFontLabel
{
    if (_maxFontLabel == nil) {
        _maxFontLabel = [[UILabel alloc] init];
        [_maxFontLabel setFont:[UIFont systemFontOfSize:MAX_FONT_SZIE]];
        [_maxFontLabel setText:@"A"];
    }
    return _maxFontLabel;
}

- (UILabel *)standardFontLabel
{
    if (_standardFontLabel == nil) {
        _standardFontLabel = [[UILabel alloc] init];
        [_standardFontLabel setFont:[UIFont systemFontOfSize:STANDARD_FONT_SZIE]];
        [_standardFontLabel setText:@"标准"];
    }
    return _standardFontLabel;
}

- (UISlider *)slider
{
    if (_slider == nil) {
        _slider = [[UISlider alloc] init];
        [_slider setMinimumValue:MIN_FONT_SIZE];
        [_slider setMaximumValue:MAX_FONT_SZIE];
        [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

@end
