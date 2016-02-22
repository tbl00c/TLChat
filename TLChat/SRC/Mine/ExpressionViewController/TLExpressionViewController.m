//
//  TLExpressionViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/21.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionViewController.h"

@interface TLExpressionViewController ()

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIBarButtonItem *rightBarButtonItem;

@end

@implementation TLExpressionViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationItem setTitleView:self.segmentedControl];
    [self.navigationItem setRightBarButtonItem:self.rightBarButtonItem];
}

#pragma mark - Event Response
- (void) rightBarButtonDown
{
    
}

- (void) segmentedControlChanged:(UISegmentedControl *)segmentedControl
{
    
}

#pragma mark - Getter and Setter
- (UISegmentedControl *) segmentedControl
{
    if (_segmentedControl == nil) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"精选表情", @"投稿表情"]];
        [_segmentedControl setWidth:WIDTH_SCREEN * 0.6];
        [_segmentedControl setSelectedSegmentIndex:0];
        [_segmentedControl addTarget:self action:@selector(segmentedControlChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _segmentedControl;
}

- (UIBarButtonItem *)rightBarButtonItem
{
    if (_rightBarButtonItem == nil) {
        _rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_setting"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDown)];
    }
    return _rightBarButtonItem;
}

@end
