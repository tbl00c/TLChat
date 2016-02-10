//
//  TLSettingCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLSettingCell.h"
#import <UIImageView+WebCache.h>

@interface TLSettingCell ()

@property (nonatomic, strong) UILabel *rightLabel;

@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation TLSettingCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.rightLabel];
        [self.contentView addSubview:self.rightImageView];
        [self p_addMasonry];
    }
    return self;
}

- (void) setItem:(TLSettingItem *)item
{
    _item = item;
    [self.textLabel setText:item.title];
    [self.rightLabel setText:item.subTitle];
    if (item.rightImagePath) {
        [self.rightImageView setImage: [UIImage imageNamed:item.rightImagePath]];
    }
    else if (item.rightImageURL){
        [self.rightImageView sd_setImageWithURL:TLURL(item.rightImageURL) placeholderImage:[UIImage imageNamed:DEFAULT_AVATAR_PATH]];
    }
    else {
        [self.rightImageView setImage:nil];
    }
    
    if (item.showDisclosureIndicator == NO) {
        [self setAccessoryType: UITableViewCellAccessoryNone];
        [self.rightLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView).mas_offset(-15.0f);
        }];
    }
    else {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [self.rightLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView);
        }];
    }
}

#pragma mark - Private Methods
- (void) p_addMasonry
{
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView);
        make.centerY.mas_equalTo(self.contentView);
    }];

    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rightLabel.mas_left).mas_offset(-2);
        make.centerY.mas_equalTo(self.contentView);
    }];
}

#pragma mark - Getter
- (UILabel *) rightLabel
{
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc] init];
        [_rightLabel setTextColor:[UIColor grayColor]];
        [_rightLabel setFont:[UIFont systemFontOfSize:15.0f]];
    }
    return _rightLabel;
}

- (UIImageView *) rightImageView
{
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] init];
    }
    return _rightImageView;
}

@end
