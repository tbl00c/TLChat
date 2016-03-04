//
//  TLMyQRCodeViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMyQRCodeViewController.h"
#import "TLScannerViewController.h"
#import <UIImageView+WebCache.h>
#import "TLScanningViewController.h"

#define         SPACE_EDGE                  20
#define         WIDTH_AVATAR                68

#define         ACTIONTAG_SHOW_SCANNER      101

@interface TLMyQRCodeViewController () <UIActionSheetDelegate>

@property (nonatomic, strong) UIView *whiteBGView;

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UILabel *usernameLabel;

@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) UIImageView *qrCodeImageView;

@property (nonatomic, strong) UILabel *introductionLabel;

@end

@implementation TLMyQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorDefaultGray]];
    [self.navigationItem setTitle:@"我的二维码"];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_more"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonDown:)];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
    
    [self.view addSubview:self.whiteBGView];
    [self.whiteBGView addSubview:self.avatarImageView];
    [self.whiteBGView addSubview:self.usernameLabel];
    [self.whiteBGView addSubview:self.locationLabel];
    [self.whiteBGView addSubview:self.qrCodeImageView];
    [self.whiteBGView addSubview:self.introductionLabel];
    
    [self p_addMasonry];
    
    [self setUser:[TLUserHelper sharedHelper].user];
}

- (void)setUser:(TLUser *)user
{
    _user = user;
    [self.avatarImageView sd_setImageWithURL:TLURL(user.avatarURL) placeholderImage:[UIImage imageNamed:DEFAULT_AVATAR_PATH]];
    [self.usernameLabel setText:user.showName];
    [self.locationLabel setText:user.location];
    [TLScannerViewController createQRCodeImageForString:user.userID ans:^(UIImage *ansImage) {
        [self.qrCodeImageView setImage:ansImage];
    }];
}

#pragma mark - UIActionSheetDelegate -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == ACTIONTAG_SHOW_SCANNER && buttonIndex == 2) {
        TLScanningViewController *scannerVC = [[TLScanningViewController alloc] init];
        [scannerVC setDisableFunctionBar:YES];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:scannerVC animated:YES];
    }
}

#pragma mark - Event Response -
- (void)rightBarButtonDown:(UIBarButtonItem *)sender
{
    UIActionSheet *actionSheet;
    if ([self.navigationController findViewController:@"TLScanningViewController"]) {
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"换个样式", @"保存图片", nil];
    }
    else {
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"换个样式", @"保存图片", @"扫描二维码", nil];
        actionSheet.tag = ACTIONTAG_SHOW_SCANNER;
    }
    [actionSheet showInView:self.view];
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.whiteBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).mas_offset(HEIGHT_NAVBAR / 2);
        make.width.mas_equalTo(self.view).multipliedBy(0.85);
        make.bottom.mas_equalTo(self.introductionLabel.mas_bottom).mas_offset(15);
    }];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(self.whiteBGView).mas_offset(SPACE_EDGE);
        make.width.and.height.mas_equalTo(WIDTH_AVATAR);
    }];
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarImageView).mas_offset(8);
        make.left.mas_equalTo(self.avatarImageView.mas_right).mas_offset(10);
    }];
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.usernameLabel);
        make.top.mas_equalTo(self.usernameLabel.mas_bottom).mas_offset(10);
    }];
    [self.qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.avatarImageView.mas_bottom).mas_offset(15);
        make.left.mas_equalTo(self.avatarImageView);
        make.right.mas_equalTo(self.whiteBGView).mas_offset(-SPACE_EDGE);
        make.height.mas_equalTo(self.qrCodeImageView.mas_width);
    }];
    [self.introductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.whiteBGView);
        make.top.mas_equalTo(self.qrCodeImageView.mas_bottom).mas_offset(15);
    }];
}

#pragma mark - Getter -
- (UIView *)whiteBGView
{
    if (_whiteBGView == nil) {
        _whiteBGView = [[UIView alloc] init];
        [_whiteBGView setBackgroundColor:[UIColor whiteColor]];
        [_whiteBGView.layer setMasksToBounds:YES];
        [_whiteBGView.layer setCornerRadius:2.0f];
        [_whiteBGView.layer setBorderWidth:0.5f];
        [_whiteBGView.layer setBorderColor:[UIColor blackColor].CGColor];
    }
    return _whiteBGView;
}

- (UIImageView *)avatarImageView
{
    if (_avatarImageView == nil) {
        _avatarImageView = [[UIImageView alloc] init];
        [_avatarImageView.layer setMasksToBounds:YES];
        [_avatarImageView.layer setCornerRadius:3.0f];
        [_avatarImageView.layer setBorderWidth:0.5f];
        [_avatarImageView.layer setBorderColor:[UIColor colorCellLine].CGColor];
    }
    return _avatarImageView;
}

- (UILabel *)usernameLabel
{
    if (_usernameLabel == nil) {
        _usernameLabel = [[UILabel alloc] init];
        [_usernameLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
    }
    return _usernameLabel;
}

- (UILabel *)locationLabel
{
    if (_locationLabel == nil) {
        _locationLabel = [[UILabel alloc] init];
        [_locationLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_locationLabel setTextColor:[UIColor grayColor]];
    }
    return _locationLabel;
}

- (UIImageView *)qrCodeImageView
{
    if (_qrCodeImageView == nil) {
        _qrCodeImageView = [[UIImageView alloc] init];
        [_qrCodeImageView setBackgroundColor:[UIColor colorWithWhite:0.1 alpha:0.1]];
    }
    return _qrCodeImageView;
}

- (UILabel *)introductionLabel
{
    if (_introductionLabel == nil) {
        _introductionLabel = [[UILabel alloc] init];
        [_introductionLabel setTextColor:[UIColor grayColor]];
        [_introductionLabel setText:@"扫一扫上面的二维码图案，加我微信"];
        [_introductionLabel setFont:[UIFont systemFontOfSize:11.0f]];
    }
    return _introductionLabel;
}

@end
