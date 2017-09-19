//
//  TLAccountViewController.m
//  TLChat
//
//  Created by 李伯坤 on 2017/1/6.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLAccountViewController.h"
#import "TLLoginViewController.h"
#import "TLRegisterViewController.h"

#define     HEIGHT_BUTTON       50
#define     EDGE_BUTTON         35

typedef NS_ENUM(NSInteger, TLAccountButtonType) {
    TLAccountButtonTypeRegister,
    TLAccountButtonTypeLogin,
    TLAccountButtonTypeTest,
};

@interface TLAccountViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TLAccountViewController

- (void)loadView {
    [super loadView];
    
    CGSize viewSize = CGSizeMake(WIDTH_SCREEN, HEIGHT_SCREEN);
    NSString *viewOrientation = @"Portrait";    //横屏请设置成 @"Landscape"
    NSArray *launchImages = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    NSString *launchImageName = nil;
    for (NSDictionary *dict in launchImages){
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImageName = dict[@"UILaunchImageName"];
        }
    }
    [self.imageView setImage:[UIImage imageNamed:launchImageName]];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
   
    UIButton *(^createButton)(NSString *title, UIColor *bgColor, NSInteger tag) = ^UIButton *(NSString *title, UIColor *bgColor, NSInteger tag) {
        UIButton *button = [[UIButton alloc] init];
        [button setTag:tag];
        [button setTitle:title forState:UIControlStateNormal];
        [button setBackgroundColor:bgColor];
        [button.titleLabel setFont:[UIFont systemFontOfSize:19]];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button.layer setMasksToBounds:YES];
        [button.layer setCornerRadius:5.0f];
        return button;
    };
    
    // 注册按钮
    UIButton *registerButton = createButton(@"注 册", [UIColor redColor], TLAccountButtonTypeRegister);
    [self.view addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(EDGE_BUTTON);
        make.bottom.mas_equalTo(-EDGE_BUTTON * 2);
        make.width.mas_equalTo((WIDTH_SCREEN - EDGE_BUTTON * 3) / 2);
        make.height.mas_equalTo(HEIGHT_BUTTON);
    }];
    
    // 登录按钮
    UIButton *loginButton = createButton(@"登 录", [UIColor colorGreenDefault], TLAccountButtonTypeLogin);
    [self.view addSubview:loginButton];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-EDGE_BUTTON);
        make.size.and.bottom.mas_equalTo(registerButton);
    }];
    
    
    // 测试按钮
    UIButton *testButton = createButton(@"使用测试账号登录", [UIColor clearColor], TLAccountButtonTypeTest);
    [testButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [self.view addSubview:testButton];
    [testButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.left.mas_equalTo(EDGE_BUTTON);
        make.right.mas_equalTo(-EDGE_BUTTON);
        make.height.mas_equalTo(HEIGHT_BUTTON);
    }];
}


#pragma mark - # Event Response
- (void)buttonClicked:(UIButton *)sender
{
    if (sender.tag == TLAccountButtonTypeRegister) {
        TLRegisterViewController *registerVC = [[TLRegisterViewController alloc] init];
        TLWeakSelf(registerVC);
        TLWeakSelf(self);
        [registerVC setRegisterSuccess:^{
            [weakregisterVC dismissViewControllerAnimated:NO completion:nil];
            if (weakself.loginSuccess) {
                weakself.loginSuccess();
            }
        }];
        [self presentViewController:registerVC animated:YES completion:nil];
    }
    else if (sender.tag == TLAccountButtonTypeLogin) {
        TLLoginViewController *loginVC = [[TLLoginViewController alloc] init];
        TLWeakSelf(self);
        TLWeakSelf(loginVC);
        [loginVC setLoginSuccess:^{
            [weakloginVC dismissViewControllerAnimated:NO completion:nil];
            if (weakself.loginSuccess) {
                weakself.loginSuccess();
            }
        }];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
    else if (sender.tag == TLAccountButtonTypeTest) {
        [[TLUserHelper sharedHelper] loginTestAccount];
        if (self.loginSuccess) {
            self.loginSuccess();
        }
    }
}


#pragma mark - # Getter
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}



@end
