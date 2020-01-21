//
//  TLMineHeaderCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMineHeaderCell.h"

#define     MINE_SPACE_X        14.0f
#define     MINE_SPACE_Y        12.0f

@interface TLMineHeaderCell ()

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UILabel *nikenameLabel;

@property (nonatomic, strong) UILabel *wechatIDLabel;

@property (nonatomic, strong) UIImageView *QRImageView;

/// 右箭头
@property (nonatomic, strong) UIImageView *arrowView;

@end

@implementation TLMineHeaderCell

#pragma mark - # Protocol
+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 90;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setUser:dataModel];
}

- (void)viewIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count
{
    if (indexPath.row == 0) {
        self.addSeparator(ZZSeparatorPositionTop);
    }
    else {
        self.removeSeparator(ZZSeparatorPositionTop);
    }
    if (indexPath.row == count - 1) {
        self.addSeparator(ZZSeparatorPositionBottom);
    }
    else {
        self.addSeparator(ZZSeparatorPositionBottom).beginAt(15);
    }
}

#pragma mark - # Public Methods
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setSelectedBackgrounColor:[UIColor colorGrayLine]];
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.nikenameLabel];
        [self.contentView addSubview:self.wechatIDLabel];
        [self.contentView addSubview:self.QRImageView];
        [self.contentView addSubview:self.arrowView];
        
        [self p_addMasonry];
    }
    return self;
}

- (void)setUser:(TLUser *)user
{
    _user = user;
    if (user.avatarPath) {
        [self.avatarImageView setImage:[UIImage imageNamed:user.avatarPath]];
    }
    else{
        [self.avatarImageView tt_setImageWithURL:TLURL(user.avatarURL) placeholderImage:[UIImage imageNamed:DEFAULT_AVATAR_PATH]];
    }
    [self.nikenameLabel setText:user.nikeName];
    [self.wechatIDLabel setText:user.username ? [NSString stringWithFormat:@"%@：%@", LOCSTR(@"微信号"), user.username] : @""];
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MINE_SPACE_X);
        make.top.mas_equalTo(MINE_SPACE_Y);
        make.bottom.mas_equalTo(- MINE_SPACE_Y);
        make.width.mas_equalTo(self.avatarImageView.mas_height);
    }];
    
    [self.nikenameLabel setContentCompressionResistancePriority:100 forAxis:UILayoutConstraintAxisHorizontal];
    [self.nikenameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_right).mas_offset(MINE_SPACE_Y);
        make.bottom.mas_equalTo(self.avatarImageView.mas_centerY).mas_offset(-3.5);
    }];
    
    [self.wechatIDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nikenameLabel);
        make.top.mas_equalTo(self.avatarImageView.mas_centerY).mas_offset(5.0);
    }];
    
    [self.QRImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(-0.5);
        make.right.mas_equalTo(self.arrowView.mas_left).mas_offset(-10);
        make.height.and.width.mas_equalTo(18);
    }];
    
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(8, 13));
        make.right.mas_equalTo(-15);
    }];
}

#pragma mark - # Getters
- (UIImageView *)avatarImageView
{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] init];
//        [_avatarImageView setImage:DEFAULT_HEAD];
        [_avatarImageView.layer setMasksToBounds:YES];
        [_avatarImageView.layer setCornerRadius:5.0f];
        [_avatarImageView.layer setBorderWidth:BORDER_WIDTH_1PX];
        [_avatarImageView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    }
    return _avatarImageView;
}

- (UILabel *)nikenameLabel
{
    if (_nikenameLabel == nil) {
        _nikenameLabel = [[UILabel alloc] init];
        [_nikenameLabel setText:@"用户昵称"];
        [_nikenameLabel setFont:[UIFont systemFontOfSize:17]];
    }
    return _nikenameLabel;
}

- (UILabel *)wechatIDLabel
{
    if (_wechatIDLabel == nil) {
        _wechatIDLabel = [[UILabel alloc] init];
        [_wechatIDLabel setText:LOCSTR(@"微信号")];
        [_wechatIDLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return _wechatIDLabel;
}

- (UIImageView *)QRImageView
{
    if (_QRImageView == nil) {
        _QRImageView = [[UIImageView alloc] init];
        [_QRImageView setImage:[UIImage imageNamed:@"mine_cell_myQR"]];
    }
    return _QRImageView;
}

- (UIImageView *)arrowView
{
    if (!_arrowView) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow"]];
    }
    return _arrowView;
}

@end
