//
//  TLNewMessageSettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLNewMessageSettingViewController.h"
#import "TLNewMessageSettingHelper.h"

@interface TLNewMessageSettingViewController ()

@property (nonatomic, strong) TLNewMessageSettingHelper *helper;

@end

@implementation TLNewMessageSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"新消息通知"];
    
    self.helper = [[TLNewMessageSettingHelper alloc] init];
    self.data = self.helper.mineNewMessageSettingData;
}

@end
