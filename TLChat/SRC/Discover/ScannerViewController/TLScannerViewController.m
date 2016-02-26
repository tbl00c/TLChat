//
//  TLScannerViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/24.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLScannerViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface TLScannerViewController () <AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UILabel *introudctionLabel;
@property (nonatomic, strong) UIView *scannerView;
@property (nonatomic, strong) UIImageView *scannerLine;

@property (nonatomic, strong) UIView *bgTopView;
@property (nonatomic, strong) UIView *bgBtmView;
@property (nonatomic, strong) UIView *bgLeftView;
@property (nonatomic, strong) UIView *bgRightView;

@property (nonatomic, strong) AVCaptureSession *scannerSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@property (nonatomic, strong) NSTimer *lineTimer;

@end

@implementation TLScannerViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:self.bgTopView];
    [self.view addSubview:self.bgLeftView];
    [self.view addSubview:self.bgRightView];
    [self.view addSubview:self.bgBtmView];
    
    [self.view addSubview:self.introudctionLabel];
    [self.view addSubview:self.scannerView];
    [self.scannerView addSubview:self.scannerLine];
    [self.view.layer insertSublayer:self.videoPreviewLayer atIndex:0];
    
    [self p_addMasonry];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.scannerSession) {
        if (_delegate && [_delegate respondsToSelector:@selector(scannerViewControllerInitSuccess:)]) {
            [_delegate scannerViewControllerInitSuccess:self];
        }
    }
    else {
        if (_delegate && [_delegate respondsToSelector:@selector(scannerViewController:initFailed:)]) {
            [_delegate scannerViewController:self initFailed:@"相机初始化失败"];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self.scannerSession isRunning]) {
        [self stopCodeReading];
    }
}

#pragma mark - Public Methods -
- (void)setScannerType:(TLScannerType)scannerType
{
    if (_scannerType == scannerType) {
        return;
    }
    [self stopCodeReading];
    _scannerType = scannerType;
    
    CGFloat width = 0;
    CGFloat height = 0;
    if (scannerType == TLScannerTypeQR) {
        [self.introudctionLabel setText:@"将二维码/条码放入框内，即可自动扫描"];
        width = height = WIDTH_SCREEN * 0.7;
    }
    else if (scannerType == TLScannerTypeCover) {
        [self.introudctionLabel setText:@"将书、CD、电影海报放入框内，即可自动扫描"];
        width = height = WIDTH_SCREEN * 0.85;
    }
    else if (scannerType == TLScannerTypeStreet) {
        [self.introudctionLabel setText:@"扫一下周围环境，寻找附近街景"];
        width = height = WIDTH_SCREEN * 0.85;
    }
    else if (scannerType == TLScannerTypeTranslate) {
        width = WIDTH_SCREEN * 0.7;
        height = 55;
        [self.introudctionLabel setText:@"将英文单词放入框内"];
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self.scannerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
        [self.view layoutIfNeeded];
    }];
    
    // rect值范围0-1，基准点在右上角
    CGRect rect = CGRectMake(self.scannerView.y / HEIGHT_SCREEN, self.scannerView.x / WIDTH_SCREEN, self.scannerView.height / HEIGHT_SCREEN, self.scannerView.width / WIDTH_SCREEN);
    [self.scannerSession.outputs[0] setRectOfInterest:rect];
    if (!self.isRunning) {
        [self startCodeReading];
    }
}

- (void)startCodeReading
{
    if ([self.lineTimer isValid]) {
        [self.lineTimer invalidate];
    }
    
    self.lineTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 / 60 target:self selector:@selector(updateScannerLineStatus) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.lineTimer forMode:NSRunLoopCommonModes];
    
    [self.scannerSession startRunning];
}

- (void)stopCodeReading
{
    if (self.lineTimer) {
        [self.lineTimer invalidate];
        self.lineTimer = nil;
    }
    self.scannerLine.y = 0;
    [self.scannerSession stopRunning];
}

- (BOOL)isRunning
{
    return [self.scannerSession isRunning];
}

#pragma mark - Delegate -
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        [self stopCodeReading];
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        if (_delegate && [_delegate respondsToSelector:@selector(scannerViewController:scanAnswer:)]) {
            [_delegate scannerViewController:self scanAnswer:obj.stringValue];
        }
    }
}

#pragma mark - Event Response -
- (void)updateScannerLineStatus
{
    if (self.scannerLine.y + self.scannerLine.height >= self.scannerView.height) {
        self.scannerLine.y = 0;
    }
    else {
        self.scannerLine.y ++;
    }
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.scannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).mas_offset(-55);
        make.width.and.height.mas_equalTo(0);
    }];
    [self.bgTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.scannerView.mas_top);
    }];
    [self.bgBtmView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.scannerView.mas_bottom);
    }];
    [self.bgLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.scannerView.mas_left);
        make.top.mas_equalTo(self.bgTopView.mas_bottom);
        make.bottom.mas_equalTo(self.bgBtmView.mas_top);
    }];
    [self.bgRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.scannerView.mas_right);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.bgTopView.mas_bottom);
        make.bottom.mas_equalTo(self.bgBtmView.mas_top);
    }];
    
    [self.introudctionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.width.mas_equalTo(self.view);
        make.top.mas_equalTo(self.scannerView.mas_bottom).mas_offset(30);
    }];
    
    [self.scannerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.mas_equalTo(self.scannerView);
        make.top.mas_equalTo(self.scannerView);
    }];
    
    UIImageView *topLeftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanner_top_left"]];
    [self.view addSubview:topLeftView];
    [topLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.mas_equalTo(_scannerView);
        make.width.and.height.mas_lessThanOrEqualTo(_scannerView);
    }];
    UIImageView *topRightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanner_top_right"]];
    [self.view addSubview:topRightView];
    [topRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.top.mas_equalTo(_scannerView);
        make.width.and.height.mas_lessThanOrEqualTo(_scannerView);
    }];
    UIImageView *btmLeftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanner_bottom_left"]];
    [self.view addSubview:btmLeftView];
    [btmLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.mas_equalTo(_scannerView);
        make.width.and.height.mas_lessThanOrEqualTo(_scannerView);
    }];
    UIImageView *btmRightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanner_bottom_right"]];
    [self.view addSubview:btmRightView];
    [btmRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.bottom.mas_equalTo(_scannerView);
        make.width.and.height.mas_lessThanOrEqualTo(_scannerView);
    }];
}

#pragma mark - Getter -
- (AVCaptureSession *)scannerSession
{
    if (_scannerSession == nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
        if (error) {    // 没有摄像头
            return nil;
        }

        AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

        AVCaptureSession *session = [[AVCaptureSession alloc] init];
        if ([session canSetSessionPreset:AVCaptureSessionPreset1920x1080]) {
            [session setSessionPreset:AVCaptureSessionPreset1920x1080];
        }
        else if ([session canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
            [session setSessionPreset:AVCaptureSessionPreset1280x720];
        }
        else {
            [session setSessionPreset:AVCaptureSessionPresetPhoto];
        }
        
        if ([session canAddInput:input]) {
            [session addInput:input];
        }
        if ([session canAddOutput:output]) {
            [session addOutput:output];
        }
        [output setMetadataObjectTypes:@[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode]];
        
        _scannerSession = session;
    }
    return _scannerSession;
}

- (AVCaptureVideoPreviewLayer *)videoPreviewLayer
{
    if (_videoPreviewLayer == nil) {
        _videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.scannerSession];
        [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        [_videoPreviewLayer setFrame:self.view.layer.bounds];
    }
    return _videoPreviewLayer;
}

- (UILabel *)introudctionLabel
{
    if (_introudctionLabel == nil) {
        _introudctionLabel = [[UILabel alloc] init];
        [_introudctionLabel setBackgroundColor:[UIColor clearColor]];
        [_introudctionLabel setTextAlignment:NSTextAlignmentCenter];
        [_introudctionLabel setFont:[UIFont systemFontOfSize:12.0]];
        [_introudctionLabel setTextColor:[UIColor whiteColor]];
    }
    return _introudctionLabel;
}

- (UIImageView *)scannerLine
{
    if (_scannerLine == nil) {
        _scannerLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanner_line"]];
    }
    return _scannerLine;
}

- (UIView *)scannerView
{
    if (_scannerView == nil) {
        _scannerView = [[UIView alloc] init];
        [_scannerView.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_scannerView.layer setBorderWidth:0.5f];
    }
    return _scannerView;
}

- (UIView *)bgTopView
{
    if (_bgTopView == nil) {
        _bgTopView = [[UIView alloc] init];
        [_bgTopView setBackgroundColor:[UIColor blackColor]];
        [_bgTopView setAlpha:0.5];
    }
    return _bgTopView;
}

- (UIView *)bgBtmView
{
    if (_bgBtmView == nil) {
        _bgBtmView = [[UIView alloc] init];
        [_bgBtmView setBackgroundColor:[UIColor blackColor]];
        [_bgBtmView setAlpha:0.5];
    }
    return _bgBtmView;
}

- (UIView *)bgLeftView
{
    if (_bgLeftView == nil) {
        _bgLeftView = [[UIView alloc] init];
        [_bgLeftView setBackgroundColor:[UIColor blackColor]];
        [_bgLeftView setAlpha:0.5];
    }
    return _bgLeftView;
}

- (UIView *)bgRightView
{
    if (_bgRightView == nil) {
        _bgRightView = [[UIView alloc] init];
        [_bgRightView setBackgroundColor:[UIColor blackColor]];
        [_bgRightView setAlpha:0.5];
    }
    return _bgRightView;
}

@end
