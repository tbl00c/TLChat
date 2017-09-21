//
//  TLMyExpressionCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/12.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMyExpressionCell.h"
#import "UIImage+Color.h"

@interface TLMyExpressionCell()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *delButton;

@end

@implementation TLMyExpressionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.titleLabel];
        [self setAccessoryView:self.delButton];
        
        [self p_addMasonry];
    }
    return self;
}

- (void)setGroup:(TLEmojiGroup *)group
{
    _group = group;
    [self.iconView setImage:[UIImage imageNamed:group.groupIconPath]];
    [self.titleLabel setText:group.groupName];
}

#pragma mark - Event Response -
- (void)delButtonDown
{
    if (_delegate && [_delegate respondsToSelector:@selector(myExpressionCellDeleteButtonDown:)]) {
        [_delegate myExpressionCellDeleteButtonDown:self.group];
    }
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(15.0f);
        make.centerY.mas_equalTo(self.contentView);
        make.width.and.height.mas_equalTo(35);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconView);
        make.left.mas_equalTo(self.iconView.mas_right).mas_offset(10.0f);
        make.right.mas_lessThanOrEqualTo(self.contentView).mas_offset(-15.0f);
    }];
}

#pragma mark - Getter -
- (UIImageView *)iconView
{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (UIButton *)delButton
{
    if (_delButton == nil) {
        _delButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        [_delButton setTitle:@"移除" forState:UIControlStateNormal];
        [_delButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_delButton setBackgroundColor:[UIColor colorGrayBG]];
        [_delButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorGrayLine]] forState:UIControlStateHighlighted];
        [_delButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [_delButton addTarget:self action:@selector(delButtonDown) forControlEvents:UIControlEventTouchUpInside];
        [_delButton.layer setMasksToBounds:YES];
        [_delButton.layer setCornerRadius:3.0f];
        [_delButton.layer setBorderWidth:BORDER_WIDTH_1PX];
        [_delButton.layer setBorderColor:[UIColor colorGrayLine].CGColor];
    }
    return _delButton;
}

@end
