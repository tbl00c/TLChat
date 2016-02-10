//
//  TLAccountAndSafetySettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLAccountAndSafetySettingViewController.h"
#import "TLAccountAndSafetyHelper.h"

@interface TLAccountAndSafetySettingViewController ()

@property (nonatomic, strong) TLAccountAndSafetyHelper *helper;

@end

@implementation TLAccountAndSafetySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"账号与安全"];
    
    self.helper = [[TLAccountAndSafetyHelper alloc] init];
    self.data = self.helper.mineAccountAndSafetySettingData;
}

@end
