//
//  TLChatToolBar.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatToolBar.h"

@interface TLChatToolBar ()

@property (nonatomic, strong) UIButton *modeButton;

@property (nonatomic, strong) UIButton *voiceButton;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIButton *emojiButton;

@property (nonatomic, strong) UIButton *moreButton;

@end

@implementation TLChatToolBar

- (id) init
{
    if (self = [super init]) {
        [self addSubview:self.modeButton];
        [self addSubview:self.voiceButton];
        [self addSubview:self.textView];
        [self addSubview:self.emojiButton];
        [self addSubview:self.moreButton];
        
        [self p_addMasonry];
    }
    return self;
}

- (void) p_addMasonry
{
    [self.modeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
    [self.voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).mas_offset(-7);
        make.left.mas_equalTo(self);
        make.width.mas_equalTo(38);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(7);
        make.bottom.mas_equalTo(self).mas_offset(-7);
        make.left.mas_equalTo(self.voiceButton.mas_right).mas_offset(4);
        make.right.mas_equalTo(self.emojiButton.mas_left).mas_offset(-4);
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.mas_equalTo(self.voiceButton);
        make.right.mas_equalTo(self);
    }];
    
    [self.emojiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.mas_equalTo(self.voiceButton);
        make.right.mas_equalTo(self.moreButton.mas_left);
    }];
}

#pragma mark - Event Response
- (void) modeButtonDown
{
    [self.textView resignFirstResponder];
}

- (void) voiceButtonDown
{
    [self.textView resignFirstResponder];
}

- (void) emojiButtonDown
{
    [self.textView resignFirstResponder];
}

- (void) moreButtonDown
{
    [self.textView resignFirstResponder];
}


#pragma mark - Getter
- (UIButton *) modeButton
{
    if (_modeButton == nil) {
        _modeButton = [[UIButton alloc] init];
        [_modeButton addTarget:self action:@selector(modeButtonDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _modeButton;
}

- (UIButton *) voiceButton
{
    if (_voiceButton == nil) {
        _voiceButton = [[UIButton alloc] init];
        [_voiceButton setImage:[UIImage imageNamed:@"chat_toolbar_voice"] forState:UIControlStateNormal];
        [_voiceButton setImage:[UIImage imageNamed:@"chat_toolbar_voice_HL"] forState:UIControlStateHighlighted];
        [_voiceButton addTarget:self action:@selector(voiceButtonDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voiceButton;
}

- (UITextView *) textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        [_textView.layer setMasksToBounds:YES];
        [_textView.layer setBorderWidth:0.5f];
        [_textView.layer setBorderColor:[UIColor grayColor].CGColor];
        [_textView.layer setCornerRadius:4.0f];
    }
    return _textView;
}

- (UIButton *) emojiButton
{
    if (_emojiButton == nil) {
        _emojiButton = [[UIButton alloc] init];
        [_emojiButton setImage:[UIImage imageNamed:@"chat_toolbar_emotion"] forState:UIControlStateNormal];
        [_emojiButton setImage:[UIImage imageNamed:@"chat_toolbar_emotion_HL"] forState:UIControlStateHighlighted];
        [_emojiButton addTarget:self action:@selector(emojiButtonDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emojiButton;
}

- (UIButton *) moreButton
{
    if (_moreButton == nil) {
        _moreButton = [[UIButton alloc] init];
        [_moreButton setImage:[UIImage imageNamed:@"chat_toolbar_more"] forState:UIControlStateNormal];
        [_moreButton setImage:[UIImage imageNamed:@"chat_toolbar_more_HL"] forState:UIControlStateHighlighted];
        [_moreButton addTarget:self action:@selector(moreButtonDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

@end
