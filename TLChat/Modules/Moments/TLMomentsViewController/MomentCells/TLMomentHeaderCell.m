//
//  TLMomentHeaderCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentHeaderCell.h"
#import "TLMacros.h"

#define         WIDTH_AVATAR        65

@interface TLMomentHeaderCell ()

@property (nonatomic, strong) UIButton *backgroundWall;

@property (nonatomic, strong) UIButton *avatarView;

@property (nonatomic, strong) UILabel *usernameLabel;

@property (nonatomic, strong) UILabel *mottoLabel;

@end

@implementation TLMomentHeaderCell

#pragma mark - # Protocol
+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 260.0f;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setUser:dataModel];
}

#pragma mark - # Cell
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.backgroundWall];
        [self.contentView addSubview:self.avatarView];
        [self.contentView addSubview:self.usernameLabel];
        [self.contentView addSubview:self.mottoLabel];
        
        [self p_addMasonry];
    }
    return self;
}

- (void)setUser:(TLUser *)user
{
    _user = user;
    [self.backgroundWall tt_setImageWithURL:TLURL(user.detailInfo.momentsWallURL) forState:UIControlStateNormal];
    [self.backgroundWall tt_setImageWithURL:TLURL(user.detailInfo.momentsWallURL) forState:UIControlStateHighlighted];
    [self.avatarView tt_setImageWithURL:TLURL(user.avatarURL) forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:DEFAULT_AVATAR_PATH]];
    [self.usernameLabel setText:user.nikeName];
    [self.mottoLabel setText:user.detailInfo.motto];
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.backgroundWall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.mottoLabel.mas_top).mas_offset(- WIDTH_AVATAR / 3.0f - 8.0f);
        make.top.mas_equalTo(-60);
    }];
    
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).mas_offset(-20.0f);
        make.centerY.mas_equalTo(self.backgroundWall.mas_bottom).mas_offset(- WIDTH_AVATAR / 6.0f);
        make.size.mas_equalTo(CGSizeMake(WIDTH_AVATAR, WIDTH_AVATAR));
    }];
    
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.backgroundWall).mas_offset(-8.0f);
        make.right.mas_equalTo(self.avatarView.mas_left).mas_offset(-15.0f);
    }];
    
    [self.mottoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView).mas_offset(-8.0f);
        make.right.mas_equalTo(self.avatarView);
        make.width.mas_lessThanOrEqualTo(SCREEN_WIDTH * 0.4);
    }];
}

#pragma mark - # Getter
- (UIButton *)backgroundWall
{
    if (_backgroundWall == nil) {
        _backgroundWall = [[UIButton alloc] init];
        [_backgroundWall setBackgroundColor:[UIColor colorGrayLine]];
        [_backgroundWall setContentMode:UIViewContentModeScaleAspectFill];
        [_backgroundWall setClipsToBounds:YES];
    }
    return _backgroundWall;
}

- (UIButton *)avatarView
{
    if (_avatarView == nil) {
        _avatarView = [[UIButton alloc] init];
        [_avatarView.layer setMasksToBounds:YES];
        [_avatarView.layer setBorderWidth:2.0f];
        [_avatarView.layer setBorderColor:[UIColor whiteColor].CGColor];
    }
    return _avatarView;
}

- (UILabel *)usernameLabel
{
    if (_usernameLabel == nil) {
        _usernameLabel = [[UILabel alloc] init];
        [_usernameLabel setTextColor:[UIColor whiteColor]];
    }
    return _usernameLabel;
}

- (UILabel *)mottoLabel
{
    if (_mottoLabel == nil) {
        _mottoLabel = [[UILabel alloc] init];
        [_mottoLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_mottoLabel setTextColor:[UIColor grayColor]];
        [_mottoLabel setTextAlignment:NSTextAlignmentRight];
    }
    return _mottoLabel;
}


@end
