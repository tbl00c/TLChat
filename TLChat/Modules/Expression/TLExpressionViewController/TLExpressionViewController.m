//
//  TLExpressionViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/21.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionViewController.h"
#import "TLExpressionChosenViewController.h"
#import "TLExpressionPublicViewController.h"
#import "TLMyExpressionViewController.h"

#define     WIDTH_EXPRESSION_SEGMENT    SCREEN_WIDTH * 0.55

@interface TLExpressionViewController ()

/// navBar分段控制器
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

/// 精选表情
@property (nonatomic, strong) TLExpressionChosenViewController *expChosenVC;

/// 更多表情
@property (nonatomic, strong) TLExpressionPublicViewController *expPublicVC;

@end

@implementation TLExpressionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    // navBar分段控制器
    [self.navigationItem setTitleView:self.segmentedControl];
    
    // 精选表情
    self.expChosenVC = [[TLExpressionChosenViewController alloc] init];
    [self.view addSubview:self.expChosenVC.view];
    [self addChildViewController:self.expChosenVC];
    
    // 推荐表情
    self.expPublicVC = [[TLExpressionPublicViewController alloc] init];
    [self addChildViewController:self.expPublicVC];
    
    @weakify(self);
    [self addRightBarButtonWithImage:[UIImage imageNamed:@"nav_setting"] actionBlick:^{
        @strongify(self);
        TLMyExpressionViewController *myExpressionVC = [[TLMyExpressionViewController alloc] init];
        PushVC(myExpressionVC);
    }];
    
    if (self.navigationController.rootViewController == self) {
        [self addLeftBarButtonWithTitle:LOCSTR(@"取消") actionBlick:^{
            @strongify(self);
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
}

#pragma mark - # Event Response
- (void)segmentedControlChanged:(UISegmentedControl *)segmentedControl
{
    if (segmentedControl.selectedSegmentIndex == 0) {
        [self transitionFromViewController:self.expPublicVC toViewController:self.expChosenVC duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:nil];
    }
    else {
        [self transitionFromViewController:self.expChosenVC toViewController:self.expPublicVC duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:nil];
    }
}

#pragma mark - # Getter
- (UISegmentedControl *)segmentedControl
{
    if (_segmentedControl == nil) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"精选表情", @"网络表情"]];
        [_segmentedControl setWidth:WIDTH_EXPRESSION_SEGMENT];
        [_segmentedControl setSelectedSegmentIndex:0];
        [_segmentedControl addTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _segmentedControl;
}

@end
