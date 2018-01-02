//
//  TLExpressionCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionCell.h"
#import "TLExpressionGroupModel.h"

@interface TLExpressionCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UIImageView *tagView;

@property (nonatomic, strong) UIButton *downloadButton;

@property (nonatomic, copy) id (^eventAction)(NSInteger eventType, id data);

@end

@implementation TLExpressionCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 80;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setgroupModel:dataModel];
}

- (void)setViewEventAction:(id (^)(NSInteger, id))eventAction
{
    [self setEventAction:eventAction];
}

- (void)viewIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
{
    self.addSeparator(TLSeparatorPositionBottom).beginAt(15);
}

#pragma mark - # Public Methods
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.tagView];
        [self.contentView addSubview:self.downloadButton];
        
        [self p_addMasonry];
    }
    return self;
}

- (void)setgroupModel:(TLExpressionGroupModel *)groupModel
{
    _groupModel = groupModel;
    UIImage *image = [UIImage imageNamed:groupModel.path];
    if (image) {
        [self.iconView setImage:image];
    }
    else {
        [self.iconView tt_setImageWithURL:TLURL(groupModel.iconURL)];
    }
    [self.titleLabel setText:groupModel.name];
    [self.detailLabel setText:groupModel.detail];
    
    if (groupModel.status == TLExpressionGroupStatusLocal) {
        [self.downloadButton setTitle:@"已下载" forState:UIControlStateNormal];
        [self.downloadButton.layer setBorderColor:[UIColor grayColor].CGColor];
        [self.downloadButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    else if (groupModel.status == TLExpressionGroupStatusDownloading) {
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
    if (self.groupModel.status == TLExpressionGroupStatusNet) {
        self.groupModel.status = TLExpressionGroupStatusLocal;
        [self setGroupModel:self.groupModel];
        if (self.eventAction) {
            self.eventAction(0, self.groupModel);
        }
    }
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(15);
        make.top.mas_equalTo(self.contentView).mas_offset(10);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-10);
        make.width.mas_equalTo(self.iconView.mas_height);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.iconView.mas_centerY).mas_offset(-2.0f);
        make.left.mas_equalTo(self.iconView.mas_right).mas_offset(13.0f);
        make.right.mas_lessThanOrEqualTo(self.downloadButton.mas_left).mas_offset(-15);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconView.mas_centerY).mas_offset(5.0);
        make.left.mas_equalTo(self.titleLabel);
        make.right.mas_lessThanOrEqualTo(self.downloadButton.mas_left).mas_offset(-15);
    }];
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(self.contentView);
    }];
    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-15);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(60, 26));
    }];
}

#pragma mark - # Getter
- (UIImageView *)iconView
{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        [_iconView setBackgroundColor:[UIColor clearColor]];
        [_iconView.layer setMasksToBounds:YES];
        [_iconView.layer setCornerRadius:5.0f];
    }
    return _iconView;
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
