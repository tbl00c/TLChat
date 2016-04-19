//
//  TLExpressionDetailCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/11.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionDetailCell.h"

@interface TLExpressionDetailCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *downloadButton;

@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation TLExpressionDetailCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.downloadButton];
        [self.contentView addSubview:self.detailLabel];
        
        [self p_addMasonry];
    }
    return self;
}

- (void)setGroup:(TLEmojiGroup *)group
{
    _group = group;
    [self.titleLabel setText:group.groupName];
    [self.detailLabel setText:group.groupDetailInfo];
    if (group.status == TLEmojiGroupStatusDownloaded) {
        [self.downloadButton setTitle:@"已下载" forState:UIControlStateNormal];
        [self.downloadButton setBackgroundColor:[UIColor grayColor]];
    }
    else if (group.status == TLEmojiGroupStatusDownloading) {
        [self.downloadButton setTitle:@"下载中" forState:UIControlStateNormal];
        [self.downloadButton setBackgroundColor:[UIColor colorDefaultGreen]];
    }
    else {
        [self.downloadButton setTitle:@"下载" forState:UIControlStateNormal];
        [self.downloadButton setBackgroundColor:[UIColor colorDefaultGreen]];
    }
}

#pragma mark - # Private Methods -
- (void)p_addMasonry
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).mas_offset(25.0f) ;
        make.left.mas_equalTo(self.contentView).mas_offset(15.0f);
        make.right.mas_lessThanOrEqualTo(self.downloadButton.mas_right).mas_offset(-15);
    }];
    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel).mas_offset(-2);
        make.right.mas_equalTo(self.contentView).mas_offset(-15.0f);
        make.size.mas_equalTo(CGSizeMake(75, 26));
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self.contentView).mas_offset(-20);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(20);
    }];
    
    UIView *line1 = [[UIView alloc] init];
    [line1 setBackgroundColor:[UIColor colorCellLine]];
    [self.contentView addSubview:line1];
    UIView *line2 = [[UIView alloc] init];
    [line2 setBackgroundColor:[UIColor colorCellLine]];
    [self.contentView addSubview:line2];
    UILabel *label = [[UILabel alloc] init];
    [label setTextColor:[UIColor colorCellLine]];
    [label setFont:[UIFont systemFontOfSize:12.0f]];
    [label setText:@"长按表情可预览"];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.left.mas_equalTo(line1.mas_right).mas_offset(5.0f);
        make.right.mas_equalTo(line2.mas_left).mas_offset(-5.0f);
    }];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(BORDER_WIDTH_1PX);
        make.left.mas_equalTo(15.0f);
        make.centerY.mas_equalTo(label);
        make.width.mas_equalTo(line2);
    }];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(BORDER_WIDTH_1PX);
        make.right.mas_equalTo(-15.0f);
        make.centerY.mas_equalTo(label);
    }];
}

#pragma mark - # Event Response -
- (void)downloadButtonDown:(UIButton *)sender
{
    [sender setTitle:@"下载中" forState:UIControlStateNormal];
    if (_delegate && [_delegate respondsToSelector:@selector(expressionDetailCellDownloadButtonDown:)]) {
        [_delegate expressionDetailCellDownloadButtonDown:self.group];
    }
}

#pragma mark - # Getter -
- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (UIButton *)downloadButton
{
    if (_downloadButton == nil) {
        _downloadButton = [[UIButton alloc] init];
        [_downloadButton setTitle:@"下载" forState:UIControlStateNormal];
        [_downloadButton setBackgroundColor:[UIColor colorDefaultGreen]];
        [_downloadButton.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [_downloadButton.layer setMasksToBounds:YES];
        [_downloadButton.layer setCornerRadius:3.0f];
        [_downloadButton.layer setBorderWidth:BORDER_WIDTH_1PX];
        [_downloadButton.layer setBorderColor:[UIColor colorCellLine].CGColor];
        [_downloadButton addTarget:self action:@selector(downloadButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadButton;
}

- (UILabel *)detailLabel
{
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        [_detailLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [_detailLabel setTextColor:[UIColor grayColor]];
        [_detailLabel setNumberOfLines:0];
    }
    return _detailLabel;
}

@end
