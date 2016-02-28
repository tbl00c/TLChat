//
//  TLInfoCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLInfoCell.h"

#define     LEFT_SUBTITLE_SPACE     (WIDTH_SCREEN * 0.3)

@interface TLInfoCell ()

@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation TLInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.textLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [self.contentView addSubview:self.subTitleLabel];
        [self p_addMasonry];
    }
    return self;
}

- (void)setInfo:(TLInfo *)info
{
    _info = info;
    [self.textLabel setText:info.title];
    [self.subTitleLabel setText:info.subTitle];
    [self setAccessoryType:info.showDisclosureIndicator ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone];
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).mas_offset(LEFT_SUBTITLE_SPACE);
        make.right.mas_lessThanOrEqualTo(self.contentView);
    }];
}

#pragma mark - Getter -
- (UILabel *)subTitleLabel
{
    if (_subTitleLabel == nil) {
        _subTitleLabel = [[UILabel alloc] init];
        [_subTitleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    }
    return _subTitleLabel;
}

@end
