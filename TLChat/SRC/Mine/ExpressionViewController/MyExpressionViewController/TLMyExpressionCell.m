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

@property (nonatomic, strong) UIButton *delButton;

@end

@implementation TLMyExpressionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setAccessoryView:self.delButton];
    }
    return self;
}

- (void)setGroup:(TLEmojiGroup *)group
{
    _group = group;
    [self.imageView setImage:[UIImage imageNamed:group.groupIconPath]];
    [self.textLabel setText:group.groupName];
}

#pragma mark - Event Response -
- (void)delButtonDown
{
    if (_delegate && [_delegate respondsToSelector:@selector(myExpressionCellDeleteButtonDown:)]) {
        [_delegate myExpressionCellDeleteButtonDown:self.group];
    }
}

#pragma mark - Getter -
- (UIButton *)delButton
{
    if (_delButton == nil) {
        _delButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        [_delButton setTitle:@"移除" forState:UIControlStateNormal];
        [_delButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_delButton setBackgroundColor:[UIColor colorSearchBarTint]];
        [_delButton setBackgroundImage:[UIImage imageWithColor:[UIColor colorCellLine]] forState:UIControlStateHighlighted];
        [_delButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [_delButton addTarget:self action:@selector(delButtonDown) forControlEvents:UIControlEventTouchUpInside];
        [_delButton.layer setMasksToBounds:YES];
        [_delButton.layer setCornerRadius:3.0f];
        [_delButton.layer setBorderWidth:0.5f];
        [_delButton.layer setBorderColor:[UIColor colorCellLine].CGColor];
    }
    return _delButton;
}

@end
