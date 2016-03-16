//
//  TLTextDisplayView.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/16.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTextDisplayView.h"

#define     WIDTH_TEXTVIEW          self.width * 0.94

@interface TLTextDisplayView ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation TLTextDisplayView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];
        
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)showInView:(UIView *)view withAttrText:(NSAttributedString *)attrText animation:(BOOL)animation
{
    [view addSubview:self];
    [self setFrame:view.bounds];
    [self setAttrString:attrText];
    [self setAlpha:0];
    [UIView animateWithDuration:0.1 animations:^{
        [self setAlpha:1.0];
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    }];
}

- (void)setAttrString:(NSAttributedString *)attrString
{
    _attrString = attrString;
    NSMutableAttributedString *mutableAttrString = [[NSMutableAttributedString alloc] initWithAttributedString:attrString];
    [mutableAttrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25.0f] range:NSMakeRange(0, attrString.length)];
    [self.textView setAttributedText:mutableAttrString];
    CGSize size = [self.textView sizeThatFits:CGSizeMake(WIDTH_TEXTVIEW, MAXFLOAT)];
    size.height = size.height > HEIGHT_SCREEN ? HEIGHT_SCREEN : size.height;
    [self.textView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(size);
    }];
}

- (void)dismiss
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Getter -
- (UITextView *)textView
{
    if (_textView == nil) {
        _textView = [[UITextView alloc] init];
        [_textView setBackgroundColor:[UIColor clearColor]];
        [_textView setTextAlignment:NSTextAlignmentCenter];
        [_textView setEditable:NO];
    }
    return _textView;
}

@end
