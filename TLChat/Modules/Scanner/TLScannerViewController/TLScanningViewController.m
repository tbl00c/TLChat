//
//  TLScanningViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/25.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLScanningViewController.h"
#import "TLScannerViewController.h"
#import "TLWebViewController.h"
#import "TLScannerButton.h"
#import "TLMyQRCodeViewController.h"

#define     HEIGHT_BOTTOM_VIEW      82

@interface TLScanningViewController () <TLScannerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign) TLScannerType curType;

@property (nonatomic, strong) TLScannerViewController *scanVC;
@property (nonatomic, strong) UIBarButtonItem *albumBarButton;
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
    
    [self.bottomView addSubview:self.qrButton];
    [self.bottomView addSubview:self.coverButton];
    [self.bottomView addSubview:self.streetButton];
    [self.bottomView addSubview:self.translateButton];
    
    [self p_addMasonry];
}

- (void)setDisableFunctionBar:(BOOL)disableFunctionBar
{
    _disableFunctionBar = disableFunctionBar;
    [self.bottomView setHidden:disableFunctionBar];
}

#pragma mark - # Delegate
- (void)scannerViewControllerInitSuccess:(TLScannerViewController *)scannerVC
{
    [self scannerButtonDown:self.qrButton];    // 初始化
}

- (void)scannerViewController:(TLScannerViewController *)scannerVC initFailed:(NSString *)errorString
{
    [TLUIUtility showAlertWithTitle:@"错误" message:errorString cancelButtonTitle:@"确定" otherButtonTitles:nil actionHandler:^(NSInteger buttonIndex) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)scannerViewController:(TLScannerViewController *)scannerVC scanAnswer:(NSString *)ansStr
{
    [self p_analysisQRAnswer:ansStr];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [TLUIUtility showLoading:@"扫描中，请稍候"];
    [TLScannerViewController scannerQRCodeFromImage:image ans:^(NSString *ansStr) {
        [TLUIUtility hiddenLoading];
        if (ansStr == nil) {
            [TLUIUtility showAlertWithTitle:@"扫描失败" message:@"请换张图片，或换个设备重试~" cancelButtonTitle:@"确定" otherButtonTitles:nil actionHandler:^(NSInteger buttonIndex) {
                [self.scanVC startCodeReading];
            }];
        }
        else {
            [self p_analysisQRAnswer:ansStr];
        }
    }];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - # Event Response
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
        [self.navigationItem setRightBarButtonItem:self.albumBarButton];
        [self.myQRButton setHidden:NO];
        [self.navigationItem setTitle:LOCSTR(@"二维码/条码")];
    }
    else {
        [self.navigationItem setRightBarButtonItem:nil];
        [self.myQRButton setHidden:YES];
        if (sender.type == TLScannerTypeCover) {
            [self.navigationItem setTitle:LOCSTR(@"封面")];
        }
        else if (sender.type == TLScannerTypeStreet) {
            [self.navigationItem setTitle:LOCSTR(@"街景")];
        }
        else if (sender.type == TLScannerTypeTranslate) {
            [self.navigationItem setTitle:LOCSTR(@"翻译")];
        }
    }
    [self.scanVC setScannerType:sender.type];
}

- (void)albumBarButtonDown:(UIBarButtonItem *)sender
{
    [self.scanVC stopCodeReading];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    [imagePickerController setDelegate:self];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)myQRButtonDown
{
    TLMyQRCodeViewController *myQRCodeVC = [[TLMyQRCodeViewController alloc] init];
    PushVC(myQRCodeVC);
}

#pragma mark - # Private Methods
- (void)p_analysisQRAnswer:(NSString *)ansStr
{
    if ([ansStr hasPrefix:@"http"]) {
        TLWebViewController *webVC = [[TLWebViewController alloc] init];
        [webVC setUrl:ansStr];
        __block id vc = self.navigationController.rootViewController;
        [self.navigationController popViewControllerAnimated:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [webVC setHidesBottomBarWhenPushed:YES];
            [[vc navigationController] pushViewController:webVC animated:YES];
        });
    }
    else {
        [TLUIUtility showAlertWithTitle:@"扫描结果" message:ansStr cancelButtonTitle:@"确定" otherButtonTitles:nil actionHandler:^(NSInteger buttonIndex) {
            [self.scanVC startCodeReading];
        }];
    }
}

- (void)p_addMasonry
{
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_BOTTOM_VIEW);
    }];
    
    // bottom
    CGFloat widthButton = 35;
    CGFloat hightButton = 55;
    CGFloat space = (SCREEN_WIDTH - widthButton * 4) / 5;
    [self.qrButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomView);
        make.left.mas_equalTo(self.bottomView).mas_offset(space);
        make.width.mas_equalTo(widthButton);
        make.height.mas_equalTo(hightButton);
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

#pragma mark - # Getters
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
        UIView *blackView = [[UIView alloc] init];
        [blackView setBackgroundColor:[UIColor blackColor]];
        [blackView setAlpha:0.5f];
        _bottomView = [[UIView alloc] init];
        [_bottomView addSubview:blackView];
        [blackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(_bottomView);
        }];
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

- (UIBarButtonItem *)albumBarButton
{
    if (_albumBarButton == nil) {
        _albumBarButton = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(albumBarButtonDown:)];
    }
    return _albumBarButton;
}

- (UIButton *)myQRButton
{
    if (_myQRButton == nil) {
        _myQRButton = [[UIButton alloc] init];
        [_myQRButton setTitle:LOCSTR(@"我的二维码") forState:UIControlStateNormal];
        [_myQRButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_myQRButton setTitleColor:[UIColor colorGreenDefault] forState:UIControlStateNormal];
        [_myQRButton addTarget:self action:@selector(myQRButtonDown) forControlEvents:UIControlEventTouchUpInside];
        [_myQRButton setHidden:YES];
    }
    return _myQRButton;
}

@end
