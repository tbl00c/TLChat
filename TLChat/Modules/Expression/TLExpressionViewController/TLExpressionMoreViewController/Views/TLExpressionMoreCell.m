//
//  TLExpressionMoreCell.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/21.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLExpressionMoreCell.h"

@interface TLExpressionMoreCell ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLExpressionMoreCell

#pragma mark - # Protocol
+ (CGSize)viewSizeByDataModel:(id)dataModel
{
    return CGSizeMake(WIDTH_EXPRESSION_MORE_CELL, WIDTH_EXPRESSION_MORE_CELL + 40);
}

- (void)setViewDataModel:(id)dataModel
{
    [self setGroupModel:dataModel];
}

#pragma mark - # Public Methods
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        [self p_addMasonry];
    }
    return self;
}

- (void)setGroupModel:(TLExpressionGroupModel *)groupModel
{
    if (_groupModel == groupModel) {
        return;
    }
    _groupModel = groupModel;
    [self.titleLabel setText:groupModel.name];
    UIImage *image = [UIImage imageWithContentsOfFile:groupModel.iconPath];
    if (image) {
        [self.imageView setImage:image];
    }
    else {
        [self.imageView tt_setImageWithURL:TLURL(groupModel.iconURL) placeholderImage:[UIImage imageWithColor:[UIColor colorGrayBG]]];
    }
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.imageView.mas_width);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(7.0f);
        make.width.mas_lessThanOrEqualTo(self.contentView);
    }];
}

#pragma mark - # Getters
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        [_imageView setBackgroundColor:[UIColor whiteColor]];
        [_imageView.layer setMasksToBounds:YES];
        [_imageView.layer setCornerRadius:10.0f];
        [_imageView.layer setBorderWidth:BORDER_WIDTH_1PX];
        [_imageView.layer setBorderColor:[UIColor colorGrayLine].CGColor];
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_titleLabel setBackgroundColor:[UIColor whiteColor]];
        [_titleLabel setClipsToBounds:YES];
    }
    return _titleLabel;
}

@end
