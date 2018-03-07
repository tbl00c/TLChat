
//
//  TLGroupQRCodeViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLGroupQRCodeViewController.h"
#import "TLQRCodeViewController.h"

@interface TLGroupQRCodeViewController () <TLActionSheetDelegate>

@property (nonatomic, strong) TLQRCodeViewController *qrCodeVC;

@end

@implementation TLGroupQRCodeViewController

- (instancetype)initWithGroupModel:(TLGroup *)groupModel
{
    if (self = [super init]) {
        _group = groupModel;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor colorBlackBG]];
    [self setTitle:LOCSTR(@"群二维码名片")];
    
    [self.view addSubview:self.qrCodeVC.view];
    [self addChildViewController:self.qrCodeVC];
    
    @weakify(self);
    [self addRightBarButtonWithImage:TLImage(@"nav_more") actionBlick:^{
        TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:nil clickAction:^(NSInteger buttonIndex) {
            @strongify(self);
            if (buttonIndex == 1) {
                [self.qrCodeVC saveQRCodeToSystemAlbum];
            }
        } cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"用邮件发送", @"保存图片", nil];
        [actionSheet show];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.qrCodeVC.avatarPath = self.group.groupAvatarPath;
    self.qrCodeVC.username = self.group.groupName;
    self.qrCodeVC.qrCode = self.group.groupID;
    NSDate *date = [NSDate dateWithDaysFromNow:7];
    self.qrCodeVC.introduction = [NSString stringWithFormat:@"该二维码7天内(%lu月%lu日前)有效，重新进入将更新", (long)date.month, (long)date.day];
}

#pragma mark - # Getter
- (TLQRCodeViewController *)qrCodeVC
{
    if (_qrCodeVC == nil) {
        _qrCodeVC = [[TLQRCodeViewController alloc] init];
    }
    return _qrCodeVC;
}

@end
