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

#define     WIDTH_EXPRESSION_SEGMENT    WIDTH_SCREEN * 0.55

@interface TLExpressionViewController ()

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) TLExpressionChosenViewController *expChosenVC;

@property (nonatomic, strong) TLExpressionPublicViewController *expPublicVC;

@end

@implementation TLExpressionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self.navigationItem setTitleView:self.segmentedControl];
    [self.view addSubview:self.expChosenVC.view];
    [self addChildViewController:self.expChosenVC];
    [self addChildViewController:self.expPublicVC];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_setting"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDown)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    if (self.navigationController.rootViewController == self) {
        UIBarButtonItem *dismissBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain actionBlick:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [self.navigationItem setLeftBarButtonItem:dismissBarButton];
    }
}

#pragma mark - # Event Response
- (void)rightBarButtonDown
{
    TLMyExpressionViewController *myExpressionVC = [[TLMyExpressionViewController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:myExpressionVC animated:YES];
}

- (void)segmentedControlChanged:(UISegmentedControl *)segmentedControl
{
    if (segmentedControl.selectedSegmentIndex == 0) {
        [self transitionFromViewController:self.expPublicVC toViewController:self.expChosenVC duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
        } completion:^(BOOL finished) {
            
        }];
    }
    else {
        [self transitionFromViewController:self.expChosenVC toViewController:self.expPublicVC duration:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
        } completion:^(BOOL finished) {
            
        }];
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

- (TLExpressionChosenViewController *)expChosenVC
{
    if (_expChosenVC == nil) {
        _expChosenVC = [[TLExpressionChosenViewController alloc] init];
    }
    return _expChosenVC;
}

- (TLExpressionPublicViewController *)expPublicVC
{
    if (_expPublicVC == nil) {
        _expPublicVC = [[TLExpressionPublicViewController alloc] init];
    }
    return _expPublicVC;
}

@end
