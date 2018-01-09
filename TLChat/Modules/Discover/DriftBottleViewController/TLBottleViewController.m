//
//  TLBottleViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLBottleViewController.h"
#import "TLBottleButton.h"

@interface TLBottleViewController ()
{
    NSTimer *timer;
    UITapGestureRecognizer *tapGes;
}

@property (nonatomic, strong) UIImageView *backgroundView;

@property (nonatomic, strong) UIImageView *bottomBoard;

@property (nonatomic, strong) TLBottleButton *throwButton;

@property (nonatomic, strong) TLBottleButton *pickUpButton;

@property (nonatomic, strong) TLBottleButton *mineButton;

@end

@implementation TLBottleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:LOCSTR(@"漂流瓶")];
    [self setDisablePopGesture:YES];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_setting"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDown:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.bottomBoard];
    [self.view addSubview:self.throwButton];
    [self.view addSubview:self.pickUpButton];
    [self.view addSubview:self.mineButton];
    [self p_addMasonry];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [timer invalidate];
    timer = [NSTimer scheduledTimerWithTimeInterval:2.0 block:^(NSTimer *tm) {
        [self p_setNavBarHidden:YES];
    } repeats:NO];
    tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView)];
    [self.view addGestureRecognizer:tapGes];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self p_setNavBarHidden:NO];
    [timer invalidate];
    [self.view removeGestureRecognizer:tapGes];
}

#pragma mark - Event Response
- (void)boardButtonDown:(TLBottleButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:sender.title message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

- (void)didTapView
{
    [timer invalidate];
    [self p_setNavBarHidden:![self.navigationController.navigationBar isHidden]];
}

- (void)rightBarButtonDown:(UIBarButtonItem *)sender
{

}

#pragma mark - Private Methods
- (void)p_setNavBarHidden:(BOOL)hidden
{
    if (hidden) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        [UIView animateWithDuration:0.5 animations:^{
            [self.navigationController.navigationBar setY: -NAVBAR_HEIGHT - STATUSBAR_HEIGHT];
        } completion:^(BOOL finished) {
            [self.navigationController.navigationBar setHidden:YES];
        }];
    }
    else {
        [self.navigationController.navigationBar setHidden:NO];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        [UIView animateWithDuration:0.2 animations:^{
            [self.navigationController.navigationBar setY:STATUSBAR_HEIGHT];
        }];
    }
}

- (void)p_addMasonry
{
    [self.bottomBoard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(self.view);
    }];
    
    CGFloat widthButton = 75;
    CGFloat space = (SCREEN_WIDTH - widthButton * 3) / 4;
    [self.pickUpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.bottom.mas_equalTo(self.view);
        make.width.mas_equalTo(widthButton);
    }];
    [self.throwButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.bottom.mas_equalTo(self.pickUpButton);
        make.right.mas_equalTo(self.pickUpButton.mas_left).mas_offset(-space);
    }];
    [self.mineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.bottom.mas_equalTo(self.pickUpButton);
        make.left.mas_equalTo(self.pickUpButton.mas_right).mas_offset(space);
    }];
}

#pragma mark - Getter -
- (UIImageView *)backgroundView
{
    if (_backgroundView == nil) {
        _backgroundView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH"];
        int hour = [dateFormatter stringFromDate:[NSDate date]].intValue;
        if (hour >= 6 && hour <= 18) {
            [_backgroundView setImage:[UIImage imageNamed:@"bottle_backgroud_day"]];
        }
        else {
            [_backgroundView setImage:[UIImage imageNamed:@"bottle_backgroud_night"]];
        }
    }
    return _backgroundView;
}

- (UIImageView *)bottomBoard
{
    if (_bottomBoard == nil) {
        _bottomBoard = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottle_board"]];
    }
    return _bottomBoard;
}

- (TLBottleButton *)throwButton
{
    if (_throwButton == nil) {
        _throwButton = [[TLBottleButton alloc] initWithType:TLBottleButtonTypeThrow title:@"扔一个" iconPath:@"bottle_button_throw"];
        [_throwButton addTarget:self action:@selector(boardButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _throwButton;
}

- (TLBottleButton *)pickUpButton
{
    if (_pickUpButton == nil) {
        _pickUpButton = [[TLBottleButton alloc] initWithType:TLBottleButtonTypePickUp title:@"捡一个" iconPath:@"bottle_button_pickup"];
        [_pickUpButton addTarget:self action:@selector(boardButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pickUpButton;
}

- (TLBottleButton *)mineButton
{
    if (_mineButton == nil) {
        _mineButton = [[TLBottleButton alloc] initWithType:TLBottleButtonTypeMine title:@"我的瓶子" iconPath:@"bottle_button_mine"];
        [_mineButton addTarget:self action:@selector(boardButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mineButton;
}

@end
