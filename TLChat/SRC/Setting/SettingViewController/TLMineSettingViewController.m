//
//  TLMineSettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMineSettingViewController.h"
#import "TLSettingHelper.h"

@interface TLMineSettingViewController ()

@property (nonatomic, strong) TLSettingHelper *helper;

@end

@implementation TLMineSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"设置"];
    
    self.helper = [[TLSettingHelper alloc] init];
    self.data = self.helper.mineSettingData;
}

@end
