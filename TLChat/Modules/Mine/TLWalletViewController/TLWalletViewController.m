//
//  TLWalletViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/9/28.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLWalletViewController.h"
#import "TLMineEventStatistics.h"

@interface TLWalletViewController () <TLActionSheetDelegate>

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TLWalletViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:LOCSTR(@"钱包")];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - NAVBAR_HEIGHT - STATUSBAR_HEIGHT + 0.5)];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.label = ({
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:[UIColor grayColor]];
        [label setFont:[UIFont systemFontOfSize:15]];
        [label setNumberOfLines:0];
        label;
    });
    [scrollView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(0);
        make.width.mas_lessThanOrEqualTo(self.view).mas_offset(-30);
    }];
    
    self.imageView = ({
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView setUserInteractionEnabled:YES];
        UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressQRCodeImage:)];
        [imageView addGestureRecognizer:longPressGR];
        imageView;
    });
    [scrollView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.label.mas_bottom).mas_offset(30);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(375 * 0.7, 422 * 0.7));
    }];
    
    UILabel *infoLabel = ({
        UILabel *label = [[UILabel alloc] init];
        [label setTextColor:[UIColor grayColor]];
        [label setFont:[UIFont systemFontOfSize:14]];
        [label setText:@"(长按保存)"];
        label;
    });
    [scrollView addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(0);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [MobClick event:EVENT_WALLET_DONATE];
    [self.label setText:@"如果此份源码对您有足够大帮助，您可以小额赞助我，以激励我继续维护，做得更好。"];
    [self.imageView setImage:[UIImage imageNamed:@"wallet_9_9"]];
}

#pragma mark - # Delegate
//MARK: TLActionSheetDelegate
- (void)actionSheet:(TLActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        UIImage *image = self.imageView.image;
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [TLUIUtility showAlertWithTitle:@"保存失败" message:[NSString stringWithFormat:@"%@", [error description]]];
    }
    else {
        [TLUIUtility showAlertWithTitle:@"保存成功" message:@"谢谢" cancelButtonTitle:@"确定" otherButtonTitles:nil actionHandler:^(NSInteger buttonIndex) {
            [MobClick event:EVENT_WALLET_QR_SAVE];
        }];
    }
}


#pragma mark - # Event Response
- (void)longPressQRCodeImage:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存二维码到相册" otherButtonTitles:nil];
        [actionSheet show];
    }
}

@end
