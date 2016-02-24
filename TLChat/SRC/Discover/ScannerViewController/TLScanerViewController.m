//
//  TLScanerViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/24.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLScanerViewController.h"
#import <AVFoundation/AVFoundation.h>

static const float kLineMinY = 185;
static const float kLineMaxY = 385;
static const float kReaderViewWidth = 200;
static const float kReaderViewHeight = 200;

@interface TLScanerViewController () <AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UILabel *introudctionLabel;

@property (nonatomic, strong) AVCaptureSession *scannerSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, strong) UIImageView *line;
@property (nonatomic, strong) NSTimer *lineTimer;


@end

@implementation TLScanerViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"二维码/条码"];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    [self.view.layer insertSublayer:self.videoPreviewLayer atIndex:0];
    [self setOverlayPickerView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.scannerSession == nil) {
        [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
            [self.navigationController popViewControllerAnimated:YES];
        } title:@"错误" message:@"相机初始化失败" cancelButtonName:@"确定" otherButtonTitles: nil];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self p_startCodeReading];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self.scannerSession isRunning]) {
        [self p_stopCodeReading];
    }
    if ([self.lineTimer isValid]) {
        [self.lineTimer invalidate];
    }
}

- (CGRect)getReaderViewBoundsWithSize:(CGSize)asize
{
    return CGRectMake(kLineMinY / HEIGHT_SCREEN, ((WIDTH_SCREEN - asize.width) / 2.0) / WIDTH_SCREEN, asize.height / HEIGHT_SCREEN, asize.width / WIDTH_SCREEN);
}

- (void)setOverlayPickerView
{
    //画中间的基准线
    _line = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH_SCREEN - 300) / 2.0, kLineMinY, 300, 12 * 300 / 320.0)];
    [_line setImage:[UIImage imageNamed:@"scanner_line"]];
    [self.view addSubview:_line];
    
    //最上部view
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, kLineMinY)];//80
    upView.alpha = 0.3;
    upView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:upView];
    
    //左侧的view
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, kLineMinY, (WIDTH_SCREEN - kReaderViewWidth) / 2.0, kReaderViewHeight)];
    leftView.alpha = 0.3;
    leftView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:leftView];
    
    //右侧的view
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_SCREEN - CGRectGetMaxX(leftView.frame), kLineMinY, CGRectGetMaxX(leftView.frame), kReaderViewHeight)];
    rightView.alpha = 0.3;
    rightView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:rightView];
    
    CGFloat space_h = HEIGHT_SCREEN - kLineMaxY;
    
    //底部view
    UIView *downView = [[UIView alloc] initWithFrame:CGRectMake(0, kLineMaxY, WIDTH_SCREEN, space_h)];
    downView.alpha = 0.3;
    downView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:downView];
    
    //四个边角
    UIImage *cornerImage = [UIImage imageNamed:@"scanner_top_left"];
    
    //左侧的view
    UIImageView *leftView_image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame) - cornerImage.size.width / 2.0, CGRectGetMaxY(upView.frame) - cornerImage.size.height / 2.0, cornerImage.size.width, cornerImage.size.height)];
    leftView_image.image = cornerImage;
    [self.view addSubview:leftView_image];
    
    cornerImage = [UIImage imageNamed:@"scanner_top_right"];
    
    //右侧的view
    UIImageView *rightView_image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(rightView.frame) - cornerImage.size.width / 2.0, CGRectGetMaxY(upView.frame) - cornerImage.size.height / 2.0, cornerImage.size.width, cornerImage.size.height)];
    rightView_image.image = cornerImage;
    [self.view addSubview:rightView_image];
    
    cornerImage = [UIImage imageNamed:@"scanner_bottom_left"];
    
    //底部view
    UIImageView *downView_image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame) - cornerImage.size.width / 2.0, CGRectGetMinY(downView.frame) - cornerImage.size.height / 2.0, cornerImage.size.width, cornerImage.size.height)];
    downView_image.image = cornerImage;
    [self.view addSubview:downView_image];
    
    cornerImage = [UIImage imageNamed:@"scanner_bottom_right"];
    
    UIImageView *downViewRight_image = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(rightView.frame) - cornerImage.size.width / 2.0, CGRectGetMinY(downView.frame) - cornerImage.size.height / 2.0, cornerImage.size.width, cornerImage.size.height)];
    downViewRight_image.image = cornerImage;
    [self.view addSubview:downViewRight_image];
    
    //说明label
    [self.introudctionLabel setFrame:CGRectMake(CGRectGetMaxX(leftView.frame), CGRectGetMinY(downView.frame) + 25, kReaderViewWidth, 20)];
    [self.introudctionLabel setText:@"将二维码/条码放入框内,即可自动扫描"];
    [self.view addSubview:self.introudctionLabel];
    
    UIView *scanCropView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame) - 1,kLineMinY,self.view.frame.size.width - 2 * CGRectGetMaxX(leftView.frame) + 2, kReaderViewHeight + 2)];
    scanCropView.layer.borderColor = [UIColor greenColor].CGColor;
    scanCropView.layer.borderWidth = 2.0;
    [self.view addSubview:scanCropView];
}


#pragma mark - Delegate -
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0) {
        [self p_stopCodeReading];
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        if (self.SYQRCodeSuncessBlock) {
            self.SYQRCodeSuncessBlock(self, obj.stringValue);
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫描结果" message:obj.stringValue delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    else {
        if (self.SYQRCodeFailBlock) {
            self.SYQRCodeFailBlock(self);
        }
    }
}

#pragma mark - Event Response -
- (void)updateScannerLineStatus
{
    __block CGRect frame = _line.frame;
    static BOOL flag = YES;
    if (flag) {
        frame.origin.y = kLineMinY;
        flag = NO;
        
        [UIView animateWithDuration:1.0 / 20 animations:^{
            frame.origin.y += 2.5;
            _line.frame = frame;
        } completion:nil];
    }
    else {
        if (_line.frame.origin.y >= kLineMinY) {
            if (_line.frame.origin.y >= kLineMaxY - 12) {
                frame.origin.y = kLineMinY;
                _line.frame = frame;
                
                flag = YES;
            }
            else {
                [UIView animateWithDuration:1.0 / 40 animations:^{
                    frame.origin.y += 2.5;
                    _line.frame = frame;
                } completion:nil];
            }
        }
        else {
            flag = !flag;
        }
    }
}

#pragma mark - Private Methods -
- (void)p_startCodeReading
{
    if ([_lineTimer isValid]) {
        [_lineTimer invalidate];
    }
    _lineTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 / 40 target:self selector:@selector(updateScannerLineStatus) userInfo:nil repeats:YES];
    [self.scannerSession startRunning];
}

- (void)p_stopCodeReading
{
    if (_lineTimer) {
        [_lineTimer invalidate];
        _lineTimer = nil;
    }
    [self.scannerSession stopRunning];
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
        [output setRectOfInterest:[self getReaderViewBoundsWithSize:CGSizeMake(kReaderViewWidth, kReaderViewHeight)]];

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
        [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
        
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
        [_introudctionLabel setFont:[UIFont boldSystemFontOfSize:13.0]];
        [_introudctionLabel setTextColor:[UIColor whiteColor]];
    }
    return _introudctionLabel;
}

@end
