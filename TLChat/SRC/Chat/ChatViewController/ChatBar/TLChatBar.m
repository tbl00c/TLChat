//
//  TLChatBar.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatBar.h"
#import "TLChatMacros.h"
#import "UIImage+Color.h"

@interface TLChatBar () <UITextViewDelegate>
{
    UIImage *kVoiceImage;
    UIImage *kVoiceImageHL;
    UIImage *kEmojiImage;
    UIImage *kEmojiImageHL;
    UIImage *kMoreImage;
    UIImage *kMoreImageHL;
    UIImage *kKeyboardImage;
    UIImage *kKeyboardImageHL;
}

@property (nonatomic, strong) UIButton *modeButton;

@property (nonatomic, strong) UIButton *voiceButton;

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UIButton *talkButton;

@property (nonatomic, strong) UIButton *emojiButton;

@property (nonatomic, strong) UIButton *moreButton;

@end

@implementation TLChatBar

- (id)init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor colorChatBar]];
        [self p_initImage];
        
        [self addSubview:self.modeButton];
        [self addSubview:self.voiceButton];
        [self addSubview:self.textView];
        [self addSubview:self.talkButton];
        [self addSubview:self.emojiButton];
        [self addSubview:self.moreButton];
        
        [self p_addMasonry];
        
        self.status = TLChatBarStatusInit;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

#pragma mark - Public Methods
- (void)sendCurrentText
{
    if (self.textView.text.length > 0) {     // send Text
        if (_dataDelegate && [_dataDelegate respondsToSelector:@selector(chatBar:sendText:)]) {
            [_dataDelegate chatBar:self sendText:self.textView.text];
        }
    }
    [self.textView setText:@""];
    [self textViewDidChange:self.textView];
}

- (void)addEmojiString:(NSString *)emojiString
{
    NSString *str = [NSString stringWithFormat:@"%@%@", self.textView.text, emojiString];
    [self.textView setText:str];
    [self textViewDidChange:self.textView];
}

- (void)setActivity:(BOOL)activity
{
    _activity = activity;
    if (activity) {
        [self.textView setTextColor:[UIColor blackColor]];
    }
    else {
        [self.textView setTextColor:[UIColor grayColor]];
    }
}

- (BOOL)isFirstResponder
{
    if (self.status == TLChatBarStatusEmoji || self.status == TLChatBarStatusKeyboard || self.status == TLChatBarStatusMore) {
        return YES;
    }
    return NO;
}

- (BOOL)resignFirstResponder
{
    if (self.status == TLChatBarStatusEmoji || self.status == TLChatBarStatusKeyboard || self.status == TLChatBarStatusMore) {
        if (_delegate && [_delegate respondsToSelector:@selector(chatBar:changeStatusFrom:to:)]) {
            [_delegate chatBar:self changeStatusFrom:self.status to:TLChatBarStatusInit];
        }
        [self.textView resignFirstResponder];
        self.status = TLChatBarStatusInit;
        [_moreButton setImage:kMoreImage imageHL:kMoreImageHL];
        [_emojiButton setImage:kEmojiImage imageHL:kEmojiImageHL];
    }
    return [super resignFirstResponder];
}

#pragma mark - Delegate -
//MARK: UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self setActivity:YES];
    if (self.status != TLChatBarStatusKeyboard) {
        if (_delegate && [_delegate respondsToSelector:@selector(chatBar:changeStatusFrom:to:)]) {
            [_delegate chatBar:self changeStatusFrom:self.status to:TLChatBarStatusKeyboard];
        }
        if (self.status == TLChatBarStatusEmoji) {
            [self.emojiButton setImage:kEmojiImage imageHL:kEmojiImageHL];
        }
        else if (self.status == TLChatBarStatusMore) {
            [self.moreButton setImage:kMoreImage imageHL:kMoreImageHL];
        }
        self.status = TLChatBarStatusKeyboard;
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]){
        [self sendCurrentText];
        return NO;
    }
    else if (textView.text.length > 0 && [text isEqualToString:@""]) {       // delete
        if ([textView.text characterAtIndex:range.location] == ']') {
            NSUInteger location = range.location;
            NSUInteger length = range.length;
            while (location != 0) {
                location --;
                length ++ ;
                char c = [textView.text characterAtIndex:location];
                if (c == '[') {
                    textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
                    return NO;
                }
                else if (c == ']') {
                    return YES;
                }
            }
        }
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat height = [textView sizeThatFits:CGSizeMake(self.textView.width, MAXFLOAT)].height;
    height = height > HEIGHT_CHATBAR_TEXTVIEW ? height : HEIGHT_CHATBAR_TEXTVIEW;
    height = (height <= HEIGHT_MAX_CHATBAR_TEXTVIEW ? height : textView.height);
    if (height != textView.height) {
        [UIView animateWithDuration:0.2 animations:^{
            [textView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height);
            }];
            [self.superview layoutIfNeeded];
            if (_delegate && [_delegate respondsToSelector:@selector(chatBar:didChangeTextViewHeight:)]) {
                [_delegate chatBar:self didChangeTextViewHeight:textView.height];
            }
        } completion:^(BOOL finished) {
            if (_delegate && [_delegate respondsToSelector:@selector(chatBar:didChangeTextViewHeight:)]) {
                [_delegate chatBar:self didChangeTextViewHeight:textView.height];
            }
        }];
    }
}

#pragma mark - Event Response
- (void)modeButtonDown
{
    if (self.status == TLChatBarStatusEmoji) {
        if (_delegate && [_delegate respondsToSelector:@selector(chatBar:changeStatusFrom:to:)]) {
            [_delegate chatBar:self changeStatusFrom:self.status to:TLChatBarStatusInit];
        }
        [self.emojiButton setImage:kEmojiImage imageHL:kEmojiImageHL];
        self.status = TLChatBarStatusInit;

    }
    else if (self.status == TLChatBarStatusMore) {
        if (_delegate && [_delegate respondsToSelector:@selector(chatBar:changeStatusFrom:to:)]) {
            [_delegate chatBar:self changeStatusFrom:self.status to:TLChatBarStatusInit];
        }
        [self.moreButton setImage:kMoreImage imageHL:kMoreImageHL];
        self.status = TLChatBarStatusInit;
    }
}

- (void)voiceButtonDown
{
    [self.textView resignFirstResponder];
    
    // 开始文字输入
    if (self.status == TLChatBarStatusVoice) {
        if (_delegate && [_delegate respondsToSelector:@selector(chatBar:changeStatusFrom:to:)]) {
            [_delegate chatBar:self changeStatusFrom:self.status to:TLChatBarStatusKeyboard];
        }
        [self.voiceButton setImage:kVoiceImage imageHL:kVoiceImageHL];
        [self.textView becomeFirstResponder];
        [self.textView setHidden:NO];
        [self.talkButton setHidden:YES];
        self.status = TLChatBarStatusKeyboard;
    }
    else {          // 开始语音
        if (_delegate && [_delegate respondsToSelector:@selector(chatBar:changeStatusFrom:to:)]) {
            [_delegate chatBar:self changeStatusFrom:self.status to:TLChatBarStatusVoice];
        }
        if (self.status == TLChatBarStatusKeyboard) {
            [self.textView resignFirstResponder];
        }
        else if (self.status == TLChatBarStatusEmoji) {
            [self.emojiButton setImage:kEmojiImage imageHL:kEmojiImageHL];
        }
        else if (self.status == TLChatBarStatusMore) {
            [self.moreButton setImage:kMoreImage imageHL:kMoreImageHL];
        }
        [self.talkButton setHidden:NO];
        [self.textView setHidden:YES];
        [self.voiceButton setImage:kKeyboardImage imageHL:kKeyboardImageHL];
        self.status = TLChatBarStatusVoice;
    }
}

- (void)emojiButtonDown
{
    // 开始文字输入
    if (self.status == TLChatBarStatusEmoji) {
        if (_delegate && [_delegate respondsToSelector:@selector(chatBar:changeStatusFrom:to:)]) {
            [_delegate chatBar:self changeStatusFrom:self.status to:TLChatBarStatusKeyboard];
        }
        [self.emojiButton setImage:kEmojiImage imageHL:kEmojiImageHL];
        [self.textView becomeFirstResponder];
        self.status = TLChatBarStatusKeyboard;
    }
    else {      // 打开表情键盘
        if (_delegate && [_delegate respondsToSelector:@selector(chatBar:changeStatusFrom:to:)]) {
            [_delegate chatBar:self changeStatusFrom:self.status to:TLChatBarStatusEmoji];
        }
        if (self.status == TLChatBarStatusVoice) {
            [self.voiceButton setImage:kVoiceImage imageHL:kVoiceImageHL];
            [self.talkButton setHidden:YES];
            [self.textView setHidden:NO];
        }
        else if (self.status == TLChatBarStatusMore) {
            [self.moreButton setImage:kMoreImage imageHL:kMoreImageHL];
        }
        [self.emojiButton setImage:kKeyboardImage imageHL:kKeyboardImageHL];
        [self.textView resignFirstResponder];
        self.status = TLChatBarStatusEmoji;
    }
}

- (void)moreButtonDown
{
    // 开始文字输入
    if (self.status == TLChatBarStatusMore) {
        if (_delegate && [_delegate respondsToSelector:@selector(chatBar:changeStatusFrom:to:)]) {
            [_delegate chatBar:self changeStatusFrom:self.status to:TLChatBarStatusKeyboard];
        }
        [self.moreButton setImage:kMoreImage imageHL:kMoreImageHL];
        [self.textView becomeFirstResponder];
        self.status = TLChatBarStatusKeyboard;
    }
    else {      // 打开更多键盘
        if (_delegate && [_delegate respondsToSelector:@selector(chatBar:changeStatusFrom:to:)]) {
            [_delegate chatBar:self changeStatusFrom:self.status to:TLChatBarStatusMore];
        }
        if (self.status == TLChatBarStatusVoice) {
            [self.voiceButton setImage:kVoiceImage imageHL:kVoiceImageHL];
            [self.talkButton setHidden:YES];
            [self.textView setHidden:NO];
        }
        else if (self.status == TLChatBarStatusEmoji) {
            [self.emojiButton setImage:kEmojiImage imageHL:kEmojiImageHL];
        }
        [self.moreButton setImage:kKeyboardImage imageHL:kKeyboardImageHL];
        [self.textView resignFirstResponder];
        self.status = TLChatBarStatusMore;
    }
}

- (void)talkButtonTouchDown:(UIButton *)sender
{
    if (_dataDelegate && [_dataDelegate respondsToSelector:@selector(chatBarRecording:)]) {
        [_dataDelegate chatBarRecording:self];
    }
}

- (void)talkButtonTouchUpInside:(UIButton *)sender
{
    if (_dataDelegate && [_dataDelegate respondsToSelector:@selector(chatBarFinishedRecoding:)]) {
        [_dataDelegate chatBarFinishedRecoding:self];
    }
}

- (void)talkButtonTouchCancel:(UIButton *)sender
{
    if (_dataDelegate && [_dataDelegate respondsToSelector:@selector(chatBarDidCancelRecording:)]) {
        [_dataDelegate chatBarDidCancelRecording:self];
    }
}

#pragma mark - Private Methods
- (void)p_addMasonry
{
    [self.modeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self).mas_offset(-4);
        make.width.mas_equalTo(0);
    }];
    
    [self.voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).mas_offset(-7);
        make.left.mas_equalTo(self.modeButton.mas_right).mas_offset(1);
        make.width.mas_equalTo(38);
    }];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(7);
        make.bottom.mas_equalTo(self).mas_offset(-7);
        make.left.mas_equalTo(self.voiceButton.mas_right).mas_offset(4);
        make.right.mas_equalTo(self.emojiButton.mas_left).mas_offset(-4);
        make.height.mas_equalTo(HEIGHT_CHATBAR_TEXTVIEW);
    }];
    
    [self.talkButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.textView);
        make.size.mas_equalTo(self.textView);
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.mas_equalTo(self.voiceButton);
        make.right.mas_equalTo(self).mas_offset(-1);
    }];
    
    [self.emojiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.width.mas_equalTo(self.voiceButton);
        make.right.mas_equalTo(self.moreButton.mas_left);
    }];
}

- (void)p_initImage
{
    kVoiceImage = [UIImage imageNamed:@"chat_toolbar_voice"];
    kVoiceImageHL = [UIImage imageNamed:@"chat_toolbar_voice_HL"];
    kEmojiImage = [UIImage imageNamed:@"chat_toolbar_emotion"];
    kEmojiImageHL = [UIImage imageNamed:@"chat_toolbar_emotion_HL"];
    kMoreImage = [UIImage imageNamed:@"chat_toolbar_more"];
    kMoreImageHL = [UIImage imageNamed:@"chat_toolbar_more_HL"];
    kKeyboardImage = [UIImage imageNamed:@"chat_toolbar_keyboard"];
    kKeyboardImageHL = [UIImage imageNamed:@"chat_toolbar_keyboard_HL"];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, WIDTH_SCREEN, 0);
    CGContextStrokePath(context);
}

#pragma mark - Getter
- (UIButton *)modeButton
{
    if (_modeButton == nil) {
        _modeButton = [[UIButton alloc] init];
        [_modeButton setImage:[UIImage imageNamed:@"chat_toolbar_texttolist"] imageHL:[UIImage imageNamed:@"chat_toolbar_texttolist_HL"]];
        [_modeButton addTarget:self action:@selector(modeButtonDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _modeButton;
}

- (UIButton *)voiceButton
{
    if (_voiceButton == nil) {
        _voiceButton = [[UIButton alloc] init];
        [_voiceButton setImage:kVoiceImage imageHL:kVoiceImageHL];
        [_voiceButton addTarget:self action:@selector(voiceButtonDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _voiceButton;
}

- (UITextView *)textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        [_textView setFont:[UIFont systemFontOfSize:16.0f]];
        [_textView setReturnKeyType:UIReturnKeySend];
        [_textView.layer setMasksToBounds:YES];
        [_textView.layer setBorderWidth:BORDER_WIDTH_1PX];
        [_textView.layer setBorderColor:[UIColor grayColor].CGColor];
        [_textView.layer setCornerRadius:4.0f];
        [_textView setDelegate:self];
        [_textView setScrollsToTop:NO];
    }
    return _textView;
}

- (UIButton *)talkButton
{
    if (_talkButton == nil) {
        _talkButton = [[UIButton alloc] init];
        [_talkButton setTitle:@"按住 说话" forState:UIControlStateNormal];
        [_talkButton setTitle:@"松开 结束" forState:UIControlStateHighlighted];
        [_talkButton setTitleColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0] forState:UIControlStateNormal];
        [_talkButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.5]] forState:UIControlStateHighlighted];
        [_talkButton.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
        [_talkButton.layer setMasksToBounds:YES];
        [_talkButton.layer setCornerRadius:4.0f];
        [_talkButton.layer setBorderWidth:BORDER_WIDTH_1PX];
        [_talkButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [_talkButton setHidden:YES];
        [_talkButton addTarget:self action:@selector(talkButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
        [_talkButton addTarget:self action:@selector(talkButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [_talkButton addTarget:self action:@selector(talkButtonTouchCancel:) forControlEvents:UIControlEventTouchUpOutside];
        [_talkButton addTarget:self action:@selector(talkButtonTouchCancel:) forControlEvents:UIControlEventTouchCancel];
    }
    return _talkButton;
}

- (UIButton *)emojiButton
{
    if (_emojiButton == nil) {
        _emojiButton = [[UIButton alloc] init];
        [_emojiButton setImage:kEmojiImage imageHL:kEmojiImageHL];
        [_emojiButton addTarget:self action:@selector(emojiButtonDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emojiButton;
}

- (UIButton *)moreButton
{
    if (_moreButton == nil) {
        _moreButton = [[UIButton alloc] init];
        [_moreButton setImage:kMoreImage imageHL:kMoreImageHL];
        [_moreButton addTarget:self action:@selector(moreButtonDown) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

- (NSString *)curText
{
    return self.textView.text;
}

@end
