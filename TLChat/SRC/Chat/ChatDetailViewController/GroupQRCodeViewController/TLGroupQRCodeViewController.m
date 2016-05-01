
//
//  TLGroupQRCodeViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLGroupQRCodeViewController.h"
#import "TLQRCodeViewController.h"
#import "NSDate+Utilities.h"

@interface TLGroupQRCodeViewController () <TLActionSheetDelegate>

@property (nonatomic, strong) TLQRCodeViewController *qrCodeVC;

@end

@implementation TLGroupQRCodeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorBlackBG]];
    [self.navigationItem setTitle:@"群二维码名片"];
    
    [self.view addSubview:self.qrCodeVC.view];
    [self addChildViewController:self.qrCodeVC];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_more"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonDown:)];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
}

- (void)setGroup:(TLGroup *)group
{
    _group = group;
    self.qrCodeVC.avatarPath = group.groupAvatarPath;
    self.qrCodeVC.username = group.groupName;
    self.qrCodeVC.qrCode = group.groupID;
    NSDate *date = [NSDate dateWithDaysFromNow:7];
    self.qrCodeVC.introduction = [NSString stringWithFormat:@"该二维码7天内(%lu月%lu日前)有效，重新进入将更新", (long)date.month, (long)date.day];
}

#pragma mark - TLActionSheetDelegate -
- (void)actionSheet:(TLActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.qrCodeVC saveQRCodeToSystemAlbum];
    }
}

#pragma mark - Event Response -
- (void)rightBarButtonDown:(UIBarButtonItem *)sender
{
    TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"用邮件发送", @"保存图片", nil];
    [actionSheet show];
}

#pragma mark - Getter -
- (TLQRCodeViewController *)qrCodeVC
{
    if (_qrCodeVC == nil) {
        _qrCodeVC = [[TLQRCodeViewController alloc] init];
    }
    return _qrCodeVC;
}

@end
