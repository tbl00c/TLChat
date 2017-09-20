//
//  TLTagCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTagCell.h"

@interface TLTagCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLTagCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftSeparatorSpace = 15;
        [self.contentView addSubview:self.titleLabel];
        
        [self p_addMasonry];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.titleLabel setText:title];
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftSeparatorSpace);
        make.right.mas_lessThanOrEqualTo(-self.leftSeparatorSpace);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

#pragma mark - # Getter
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    }
    return _titleLabel;
}

@end
