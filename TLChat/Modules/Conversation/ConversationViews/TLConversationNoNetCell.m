//
//  TLConversationNoNetCell.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/17.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLConversationNoNetCell.h"

@interface TLConversationNoNetCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation TLConversationNoNetCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 45.0f;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.contentView setBackgroundColor:RGBAColor(255, 223, 224, 1)];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.iconView];
        
        [self p_addMasonry];
        
        [self.iconView setImage:[UIImage imageNamed:@"conv_exclamation_mark"]];
        [self.titleLabel setText:LOCSTR(@"当前网络不可用，请检查你的网络设置")];
    }
    return self;
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(40);
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_right).mas_offset(10);
        make.right.mas_lessThanOrEqualTo(-15);
        make.centerY.mas_equalTo(0);
    }];
}

#pragma mark - # Getters
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setTextColor:[UIColor grayColor]];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

@end
