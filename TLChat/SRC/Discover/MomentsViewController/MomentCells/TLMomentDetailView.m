//
//  TLMomentDetailView.m
//  TLChat
//
//  Created by libokun on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentDetailView.h"

@interface TLMomentDetailView ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation TLMomentDetailView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.textLabel];
        
        [self p_addMasonry];
        
        [self.textLabel setText:@"Hello world!"];
    }
    return self;
}

#pragma mark - # Private Methods -
- (void)p_addMasonry
{
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

#pragma mark - # Getter -
- (UILabel *)textLabel
{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc] init];
        [_textLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_textLabel setNumberOfLines:0];
    }
    return _textLabel;
}

@end
