
//
//  TLShakeViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLShakeViewController.h"
#import "TLShakeSettingViewController.h"
#import "TLShakeButton.h"
#import "NSFileManager+TLChat.h"

#define     SHAKE_HEIGHT    90

@interface TLShakeViewController ()

@property (nonatomic, assign) TLShakeButtonType curType;

@property (nonatomic, strong) UIImageView *topLogoView;

@property (nonatomic, strong) UIImageView *bottomLogoView;

@property (nonatomic, strong) UIImageView *centerLogoView;

@property (nonatomic, strong) UIImageView *topLineView;

@property (nonatomic, strong) UIImageView *bottomLineView;

@property (nonatomic, strong) TLShakeButton *peopleButton;

@property (nonatomic, strong) TLShakeButton *songButton;

@property (nonatomic, strong) TLShakeButton *tvButton;

@end

@implementation TLShakeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:LOCSTR(@"摇一摇")];
    [self.view setBackgroundColor:[UIColor colorBlackBG]];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_setting"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDown:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    [self.view addSubview:self.centerLogoView];
    [self.view addSubview:self.topLogoView];
    [self.view addSubview:self.bottomLogoView];
    [self.view addSubview:self.topLineView];
    [self.view addSubview:self.bottomLineView];
    [self.view addSubview:self.peopleButton];
    [self.view addSubview:self.songButton];
    [self.view addSubview:self.tvButton];
    [self p_addMasonry];
    
    self.curType = TLShakeButtonTypePeople;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *centreImageName = [[NSUserDefaults standardUserDefaults] objectForKey:@"Shake_Image_Path"];
    if (centreImageName) {
        NSString *path = [NSFileManager pathUserSettingImage:centreImageName];
        [self.centerLogoView setImage:[UIImage imageNamed:path]];
    }
    else {
        [self.centerLogoView setImage:[UIImage imageNamed:@"shake_logo_center"]];
    }
}

#pragma mark - Event Response
- (void)controlButtonDown:(TLShakeButton *)sender
{
    if (sender.isSelected) {
        return;
    }
    self.curType = sender.type;
    [self.peopleButton setSelected:self.peopleButton.type == sender.type];
    [self.songButton setSelected:self.songButton.type == sender.type];
    [self.tvButton setSelected:self.tvButton.type == sender.type];
}

- (void)rightBarButtonDown:(UIBarButtonItem *)sender
{
    TLShakeSettingViewController *shakeSettingVC = [[TLShakeSettingViewController alloc] init];
    PushVC(shakeSettingVC);
}

// 摇动手机
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ([self.topLineView isHidden]) {
        [self.topLineView setHidden:NO];
        [self.bottomLineView setHidden:NO];
        [UIView animateWithDuration:0.5 animations:^{
            [self.topLogoView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.view.mas_centerY).mas_offset(-10 - SHAKE_HEIGHT);
            }];
            [self.bottomLogoView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.view.mas_centerY).mas_offset(-10 + SHAKE_HEIGHT);
            }];
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.5 animations:^{
                    [self.topLogoView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.bottom.mas_equalTo(self.view.mas_centerY).mas_offset(-10);
                    }];
                    [self.bottomLogoView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(self.view.mas_centerY).mas_offset(-10);
                    }];
                    [self.view layoutIfNeeded];
                } completion:^(BOOL finished) {
                    [self.topLineView setHidden:YES];
                    [self.bottomLineView setHidden:YES];
                }];
            });
        }];
    }
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.centerLogoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    [self.topLogoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_centerY).mas_offset(-10);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(150);
    }];
    [self.bottomLogoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_centerY).mas_offset(-10);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(150);
    }];
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.top.mas_equalTo(self.topLogoView.mas_bottom);
    }];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomLogoView.mas_top);
    }];
    
    // bottom
    CGFloat widthButton = 40;
    CGFloat space = (SCREEN_WIDTH - widthButton * 3) / 4 * 1.2;
    [self.songButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-15);
    }];
    [self.peopleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.songButton);
        make.right.mas_equalTo(self.songButton.mas_left).mas_offset(-space);
    }];
    [self.tvButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.songButton);
        make.left.mas_equalTo(self.songButton.mas_right).mas_offset(space);
    }];
}

#pragma mark - Getter -
- (UIImageView *)topLogoView
{
    if (_topLogoView == nil) {
        _topLogoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shake_logo_top"]];
        [_topLogoView setBackgroundColor:[UIColor colorBlackBG]];
        [_topLogoView setContentMode:UIViewContentModeBottom];
    }
    return _topLogoView;
}

- (UIImageView *)bottomLogoView
{
    if (_bottomLogoView == nil) {
        _bottomLogoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shake_logo_bottom"]];
        [_bottomLogoView setBackgroundColor:[UIColor colorBlackBG]];
        [_bottomLogoView setContentMode:UIViewContentModeTop];
    }
    return _bottomLogoView;
}

- (UIImageView *)centerLogoView
{
    if (_centerLogoView == nil) {
        _centerLogoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shake_logo_center"]];
        [_centerLogoView setContentMode:UIViewContentModeScaleAspectFill];
        [_centerLogoView setClipsToBounds:YES];
    }
    return _centerLogoView;
}

- (UIImageView *)topLineView
{
    if (_topLineView == nil) {
        _topLineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shake_line_top"]];
        [_topLineView setHidden:YES];
    }
    return _topLineView;
}

- (UIImageView *)bottomLineView
{
    if (_bottomLineView == nil) {
        _bottomLineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shake_line_bottom"]];
        [_bottomLineView setHidden:YES];
    }
    return _bottomLineView;
}

- (TLShakeButton *)peopleButton
{
    if (_peopleButton == nil) {
        _peopleButton = [[TLShakeButton alloc] initWithType:TLShakeButtonTypePeople title:@"人" iconPath:@"shake_button_people" iconHLPath:@"shake_button_peopleHL"];
        [_peopleButton setSelected:YES];
        [_peopleButton addTarget:self action:@selector(controlButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _peopleButton;
}

- (TLShakeButton *)songButton
{
    if (_songButton == nil) {
        _songButton = [[TLShakeButton alloc] initWithType:TLShakeButtonTypeSong title:@"歌曲" iconPath:@"shake_button_music" iconHLPath:@"shake_button_musicHL"];
        [_songButton addTarget:self action:@selector(controlButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _songButton;
}

- (TLShakeButton *)tvButton
{
    if (_tvButton == nil) {
        _tvButton = [[TLShakeButton alloc] initWithType:TLShakeButtonTypeTV title:@"电视" iconPath:@"shake_button_tv" iconHLPath:@"shake_button_tvHL"];
        [_tvButton addTarget:self action:@selector(controlButtonDown:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tvButton;
}

@end
