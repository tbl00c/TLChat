//
//  TLQRCodeViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLQRCodeViewController.h"
#import "TLMacros.h"

#define         SPACE_EDGE                  20
#define         WIDTH_AVATAR                68

@interface TLQRCodeViewController ()

@property (nonatomic, strong) UIView *whiteBGView;

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UILabel *usernameLabel;

@property (nonatomic, strong) UILabel *subTitleLabel;

@property (nonatomic, strong) UIImageView *qrCodeImageView;

@property (nonatomic, strong) UILabel *introductionLabel;

@end

@implementation TLQRCodeViewController

+ (void)createQRCodeImageForString:(NSString *)str ans:(void (^)(UIImage *))ans
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *stringData = [str dataUsingEncoding:NSUTF8StringEncoding];
        CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
        [qrFilter setValue:stringData forKey:@"inputMessage"];
        [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
        CIImage *image = qrFilter.outputImage;
        CGFloat size = 300.0f;
        
        CGRect extent = CGRectIntegral(image.extent);
        CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
        
        size_t width = CGRectGetWidth(extent) * scale;
        size_t height = CGRectGetHeight(extent) * scale;
        
        CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
        CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
        CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
        CGContextScaleCTM(bitmapRef, scale, scale);
        CGContextDrawImage(bitmapRef, extent, bitmapImage);
        
        CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
        CGContextRelease(bitmapRef);
        CGImageRelease(bitmapImage);
        
        UIImage *ansImage = [UIImage imageWithCGImage:scaledImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            ans(ansImage);
        });
    });
}

- (void)viewDidLoad
{
    [self.view addSubview:self.whiteBGView];
    [self.whiteBGView addSubview:self.avatarImageView];
    [self.whiteBGView addSubview:self.usernameLabel];
    [self.whiteBGView addSubview:self.subTitleLabel];
    [self.whiteBGView addSubview:self.qrCodeImageView];
    [self.whiteBGView addSubview:self.introductionLabel];
    
    [self p_addMasonry];
}

#pragma mark - Public Methods -
- (void)saveQRCodeToSystemAlbum
{
    UIImage *image = [self.whiteBGView captureImage];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [TLUIUtility showAlertWithTitle:@"错误" message:[NSString stringWithFormat:@"保存图片到系统相册失败\n%@", [error description]]];
    }
    else {
        [TLUIUtility showSuccessHint:@"已保存到系统相册"];
    }
}

#pragma mark - Public Methdos -
- (void)setAvatarURL:(NSString *)avatarURL
{
    _avatarURL = avatarURL;
    [self.avatarImageView tt_setImageWithURL:TLURL(avatarURL) placeholderImage:[UIImage imageNamed:DEFAULT_AVATAR_PATH]];
}

- (void)setAvatarPath:(NSString *)avatarPath
{
    _avatarPath = avatarPath;
    [self.avatarImageView setImage:avatarPath.length > 0 ? [UIImage imageNamed:avatarPath] : nil];
}

- (void)setUsername:(NSString *)username
{
    _username = username;
    [self.usernameLabel setText:username];
}

- (void)setSubTitle:(NSString *)subTitle
{
    _subTitle = subTitle;
    [self.subTitleLabel setText:subTitle];
    if (subTitle) {
        [self.usernameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.avatarImageView).mas_offset(8);
            make.left.mas_equalTo(self.avatarImageView.mas_right).mas_offset(10);
            make.right.mas_lessThanOrEqualTo(self.whiteBGView).mas_offset(-SPACE_EDGE);
        }];
    }
}

- (void)setIntroduction:(NSString *)introduction
{
    _introduction = introduction;
    [self.introductionLabel setText:introduction];
}

- (void)setQrCode:(NSString *)qrCode
{
    _qrCode = qrCode;
    [TLQRCodeViewController createQRCodeImageForString:qrCode ans:^(UIImage *ansImage) {
        [self.qrCodeImageView setImage:ansImage];
    }];
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.whiteBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).mas_offset(NAVBAR_HEIGHT / 2);
        make.width.mas_equalTo(self.view).multipliedBy(0.85);
        make.bottom.mas_equalTo(self.introductionLabel.mas_bottom).mas_offset(15);
    }];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(self.whiteBGView).mas_offset(SPACE_EDGE);
        make.width.and.height.mas_equalTo(WIDTH_AVATAR);
    }];
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatarImageView.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self.avatarImageView);
        make.right.mas_lessThanOrEqualTo(self.whiteBGView).mas_offset(-SPACE_EDGE);
    }];
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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
        [_whiteBGView.layer setBorderWidth:BORDER_WIDTH_1PX];
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
        [_avatarImageView.layer setBorderWidth:BORDER_WIDTH_1PX];
        [_avatarImageView.layer setBorderColor:[UIColor colorGrayLine].CGColor];
    }
    return _avatarImageView;
}

- (UILabel *)usernameLabel
{
    if (_usernameLabel == nil) {
        _usernameLabel = [[UILabel alloc] init];
        [_usernameLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [_usernameLabel setNumberOfLines:3];
    }
    return _usernameLabel;
}

- (UILabel *)subTitleLabel
{
    if (_subTitleLabel == nil) {
        _subTitleLabel = [[UILabel alloc] init];
        [_subTitleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_subTitleLabel setTextColor:[UIColor grayColor]];
    }
    return _subTitleLabel;
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
        [_introductionLabel setFont:[UIFont systemFontOfSize:11.0f]];
    }
    return _introductionLabel;
}

@end
