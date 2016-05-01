//
//  TLExpressionCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionCell.h"
#import <UIImageView+WebCache.h>

#define         EDGE_TOP        10.0f
#define         EDGE_LEFT       15.0f
#define         ROW_SPCAE       10.0f

@interface TLExpressionCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UIImageView *tagView;

@property (nonatomic, strong) UIButton *downloadButton;

@end

@implementation TLExpressionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.tagView];
        [self.contentView addSubview:self.downloadButton];
        
        [self p_addMasonry];
    }
    return self;
}

- (void)setGroup:(TLEmojiGroup *)group
{
    _group = group;
    UIImage *image = [UIImage imageNamed:group.groupIconPath];
    if (image) {
        [self.iconImageView setImage:image];
    }
    else {
        [self.iconImageView sd_setImageWithURL:TLURL(group.groupIconURL)];
    }
    [self.titleLabel setText:group.groupName];
    [self.detailLabel setText:group.groupDetailInfo];
    
    if (group.status == TLEmojiGroupStatusDownloaded) {
        [self.downloadButton setTitle:@"已下载" forState:UIControlStateNormal];
        [self.downloadButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.downloadButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    else if (group.status == TLEmojiGroupStatusDownloading) {
        [self.downloadButton setTitle:@"下载中" forState:UIControlStateNormal];
        [self.downloadButton.layer setBorderColor:[UIColor colorGreenDefault].CGColor];
        [self.downloadButton setTitleColor:[UIColor colorGreenDefault] forState:UIControlStateNormal];
    }
    else {
        [self.downloadButton setTitle:@"下载" forState:UIControlStateNormal];
        [self.downloadButton.layer setBorderColor:[UIColor colorGreenDefault].CGColor];
        [self.downloadButton setTitleColor:[UIColor colorGreenDefault] forState:UIControlStateNormal];
    }
}

#pragma mark - # Event Response
- (void)downloadButtonDown:(UIButton *)sender
{
    if (self.group.status == TLEmojiGroupStatusUnDownload) {
        self.group.status = TLEmojiGroupStatusDownloading;
        [self setGroup:self.group];
        if (_delegate && [_delegate respondsToSelector:@selector(expressionCellDownloadButtonDown:)]) {
            [_delegate expressionCellDownloadButtonDown:self.group];
        }
    }
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(EDGE_LEFT);
        make.top.mas_equalTo(self.contentView).mas_offset(EDGE_TOP);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-EDGE_TOP);
        make.width.mas_equalTo(self.iconImageView.mas_height);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.iconImageView.mas_centerY).mas_offset(-2.0f);
        make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(13.0f);
        make.right.mas_lessThanOrEqualTo(self.downloadButton.mas_left).mas_offset(-EDGE_LEFT);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_centerY).mas_offset(5.0);
        make.left.mas_equalTo(self.titleLabel);
        make.right.mas_lessThanOrEqualTo(self.downloadButton.mas_left).mas_offset(-EDGE_LEFT);
    }];
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(self.contentView);
    }];
    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-EDGE_LEFT);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(60, 26));
    }];
}

#pragma mark - # Getter
- (UIImageView *)iconImageView
{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
        [_iconImageView setBackgroundColor:[UIColor clearColor]];
        [_iconImageView.layer setMasksToBounds:YES];
        [_iconImageView.layer setCornerRadius:5.0f];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        [_detailLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [_detailLabel setTextColor:[UIColor grayColor]];
    }
    return _detailLabel;
}

- (UIImageView *)tagView
{
    if (_tagView == nil) {
        _tagView = [[UIImageView alloc] init];
        [_tagView setImage:[UIImage imageNamed:@"icon_corner_new"]];
        [_tagView setHidden:YES];
    }
    return _tagView;
}

- (UIButton *)downloadButton
{
    if (_downloadButton == nil) {
        _downloadButton = [[UIButton alloc] init];
        [_downloadButton setTitle:@"下载" forState:UIControlStateNormal];
        [_downloadButton.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_downloadButton setTitleColor:[UIColor colorGreenDefault] forState:UIControlStateNormal];
        [_downloadButton.layer setMasksToBounds:YES];
        [_downloadButton.layer setCornerRadius:3.0f];
        [_downloadButton.layer setBorderWidth:1.0f];
        [_downloadButton.layer setBorderColor:[UIColor colorGreenDefault].CGColor];
        [_downloadButton addTarget:self action:@selector(downloadButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadButton;
}

@end
