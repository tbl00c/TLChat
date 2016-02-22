//
//  TLCommonSettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/21.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLCommonSettingViewController.h"
#import "TLCommonSettingHelper.h"

@interface TLCommonSettingViewController ()

@property (nonatomic, strong) TLCommonSettingHelper *helper;

@end

@implementation TLCommonSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"通用"];
    
    self.helper = [[TLCommonSettingHelper alloc] init];
    self.data = self.helper.commonSettingData;
}

@end
