//
//  TLAddMenuCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/11.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLAddMenuCell.h"

@interface TLAddMenuCell()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLAddMenuCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor colorBlackForAddMenu]];
        UIView *selectedView = [[UIView alloc] init];
        [selectedView setBackgroundColor:[UIColor colorBlackForAddMenuHL]];
        [self setSelectedBackgroundView:selectedView];
    
        [self p_initUI];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.addSeparator(ZZSeparatorPositionBottom).beginAt(15).endAt(-15).color([UIColor colorGrayLine]);
}

- (void)setItem:(TLAddMenuItem *)item
{
    _item = item;
    [self.iconView setImage:[UIImage imageNamed:item.iconPath]];
    [self.titleLabel setText:item.title];
}

#pragma mark - Private Methods
- (void)p_initUI
{
    self.iconView = self.contentView.addImageView(1)
    .masonry(^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(15.0f);
        make.centerY.mas_equalTo(self);
        make.height.and.width.mas_equalTo(32);
    })
    .view;
    
    self.titleLabel = self.contentView.addLabel(2)
    .font([UIFont systemFontOfSize:16.0f])
    .textColor([UIColor whiteColor])
    .masonry(^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconView.mas_right).mas_offset(10.0f);
        make.centerY.mas_equalTo(self.iconView);
    })
    .view;
}

@end
