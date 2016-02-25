//
//  TLScanerViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/25.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLScanerViewController.h"
#import "TLScanViewController.h"

#define     HEIGHT_BOTTOM_VIEW      100

@interface TLScanerViewController ()

@property (nonatomic, strong) TLScanViewController *scanVC;

@property (nonatomic, strong) UIView *bottomView;

@end

@implementation TLScanerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"二维码/条码"];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:self.scanVC.view];
    [self.view addSubview:self.bottomView];
    [self addChildViewController:self.scanVC];
    
    [self p_addMasonry];
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(HEIGHT_BOTTOM_VIEW);
    }];
}

#pragma mark - Getter -
- (TLScanViewController *)scanVC
{
    if (_scanVC == nil) {
        _scanVC = [[TLScanViewController alloc] init];
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

@end
