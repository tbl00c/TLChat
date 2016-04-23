//
//  TLFriendHeaderView.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendHeaderView.h"

@interface TLFriendHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLFriendHeaderView

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        UIView *bgView = [UIView new];
        [bgView setBackgroundColor:[UIColor colorGrayBG]];
        [self setBackgroundView:bgView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self.titleLabel setFrame:CGRectMake(10, 0, self.width - 15, self.height)];
}

- (void) setTitle:(NSString *)title
{
    _title = title;
    [_titleLabel setText:title];
}

- (UILabel *) titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:14.5f]];
        [_titleLabel setTextColor:[UIColor grayColor]];
    }
    return _titleLabel;
}

@end
