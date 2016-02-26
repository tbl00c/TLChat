//
//  TLScanningViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/25.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLScanningViewController.h"
#import "TLScannerViewController.h"
#import "TLScannerButton.h"

#define     HEIGHT_BOTTOM_VIEW      80

@interface TLScanningViewController () <TLScannerDelegate>

@property (nonatomic, assign) TLScannerType curType;

@property (nonatomic, strong) TLScannerViewController *scanVC;
@property (nonatomic, strong) UIBarButtonItem *rightBarButton;
@property (nonatomic, strong) UIButton *myQRButton;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) TLScannerButton *qrButton;
@property (nonatomic, strong) TLScannerButton *coverButton;
@property (nonatomic, strong) TLScannerButton *streetButton;
@property (nonatomic, strong) TLScannerButton *translateButton;

@end

@implementation TLScanningViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:self.scanVC.view];
    [self addChildViewController:self.scanVC];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.myQRButton];
    
    [self.view addSubview:self.qrButton];
    [self.view addSubview:self.coverButton];
    [self.view addSubview:self.streetButton];
    [self.view addSubview:self.translateButton];
    
    [self p_addMasonry];
}

#pragma mark - TLScannerDelegate -
- (void)scannerViewControllerInitSuccess:(TLScannerViewController *)scannerVC
{
    [self scannerButtonDown:self.qrButton];    // 初始化
}

- (void)scannerViewController:(TLScannerViewController *)scannerVC initFailed:(NSString *)errorString
{
    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
        [self.navigationController popViewControllerAnimated:YES];
    } title:@"错误" message:errorString cancelButtonName:@"确定" otherButtonTitles:nil];
}

- (void)scannerViewController:(TLScannerViewController *)scannerVC scanAnswer:(NSString *)ansStr
{
    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
        [scannerVC startCodeReading];
    } title:@"扫描结果" message:ansStr cancelButtonName:@"确定" otherButtonTitles:nil];
}

#pragma mark - Event Response -
- (void)scannerButtonDown:(TLScannerButton *)sender
{
    if (sender.isSelected) {
        if (![self.scanVC isRunning]) {
            [self.scanVC startCodeReading];
        }
        return;
    }
    self.curType = sender.type;
    [self.qrButton setSelected:self.qrButton.type == sender.type];
    [self.coverButton setSelected:self.coverButton.type == sender.type];
    [self.streetButton setSelected:self.streetButton.type == sender.type];
    [self.translateButton setSelected:self.translateButton.type == sender.type];

    if (sender.type == TLScannerTypeQR) {
        [self.navigationItem setRightBarButtonItem:self.rightBarButton];
        [self.myQRButton setHidden:NO];
        [self.navigationItem  setTitle:@"二维码/条码"];
    }
    else {
        [self.navigationItem setRightBarButtonItem:nil];
        [self.myQRButton setHidden:YES];
        if (sender.type == TLScannerTypeCover) {
            [self.navigationItem  setTitle:@"封面"];
        }
        else if (sender.type == TLScannerTypeStreet) {
            [self.navigationItem  setTitle:@"街景"];
        }
        else if (sender.type == TLScannerTypeTranslate) {
            [self.navigationItem  setTitle:@"翻译"];
        }
    }
    [self.scanVC setScannerType:sender.type];
}

- (void)rightBarButtonDown:(UIBarButtonItem *)sender
{

}

- (void)myQRButtonDown
{

}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_BOTTOM_VIEW);
    }];
    
    // bottom
    CGFloat widthButton = 35;
    CGFloat space = (WIDTH_SCREEN - widthButton * 4) / 5;
    [self.qrButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bottomView).mas_offset(13);
        make.bottom.mas_equalTo(self.bottomView).mas_offset(-13);
        make.left.mas_equalTo(self.bottomView).mas_offset(space);
        make.width.mas_equalTo(widthButton);
    }];
    [self.coverButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.width.mas_equalTo(self.qrButton);
        make.left.mas_equalTo(self.qrButton.mas_right).mas_offset(space);
    }];
    [self.streetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.width.mas_equalTo(self.qrButton);
        make.left.mas_equalTo(self.coverButton.mas_right).mas_offset(space);
    }];
    [self.translateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.and.width.mas_equalTo(self.qrButton);
        make.left.mas_equalTo(self.streetButton.mas_right).mas_offset(space);
    }];
    [self.myQRButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomView.mas_top).mas_offset(-40);
    }];
}

#pragma mark - Getter -
- (TLScannerViewController *)scanVC
{
    if (_scanVC == nil) {
        _scanVC = [[TLScannerViewController alloc] init];
        [_scanVC setDelegate:self];
    }
    return _scanVC;
}

- (UIView *)bottomView
{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] init];
        [_bottomView setBackgroundColor:[UIColor blackColor]];
        [_bottomView setAlpha:0.5f];
    }
    return _bottomView;
}

- (TLScannerButton *)qrButton
{
    if (_qrButton == nil) {
        _qrButton = [[TLScannerButton alloc] initWithType:TLScannerTypeQR title:@"扫码" iconPath:@"scan_QR" iconHLPath:@"scan_QR_HL"];
        [_qrButton addTarget:self action:@selector(scannerButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qrButton;
}

- (TLScannerButton *)coverButton
{
    if (_coverButton == nil) {
        _coverButton = [[TLScannerButton alloc] initWithType:TLScannerTypeCover title:@"封面" iconPath:@"scan_book" iconHLPath:@"scan_book_HL"];
        [_coverButton addTarget:self action:@selector(scannerButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _coverButton;
}

- (TLScannerButton *)streetButton
{
    if (_streetButton == nil) {
        _streetButton = [[TLScannerButton alloc] initWithType:TLScannerTypeStreet title:@"街景" iconPath:@"scan_street" iconHLPath:@"scan_street_HL"];
        [_streetButton addTarget:self action:@selector(scannerButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _streetButton;
}

- (TLScannerButton *)translateButton
{
    if (_translateButton == nil) {
        _translateButton = [[TLScannerButton alloc] initWithType:TLScannerTypeTranslate title:@"翻译" iconPath:@"scan_word" iconHLPath:@"scan_word_HL"];
        [_translateButton addTarget:self action:@selector(scannerButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _translateButton;
}

- (UIBarButtonItem *)rightBarButton
{
    if (_rightBarButton == nil) {
        _rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonDown:)];
    }
    return _rightBarButton;
}

- (UIButton *)myQRButton
{
    if (_myQRButton == nil) {
        _myQRButton = [[UIButton alloc] init];
        [_myQRButton setTitle:@"我的二维码" forState:UIControlStateNormal];
        [_myQRButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_myQRButton setTitleColor:[UIColor colorDefaultGreen] forState:UIControlStateNormal];
        [_myQRButton addTarget:self action:@selector(myQRButtonDown) forControlEvents:UIControlEventTouchUpInside];
        [_myQRButton setHidden:YES];
    }
    return _myQRButton;
}

@end
