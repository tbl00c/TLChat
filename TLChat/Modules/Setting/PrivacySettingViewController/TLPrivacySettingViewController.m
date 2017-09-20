//
//  TLPrivacySettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLPrivacySettingViewController.h"
#import "TLPrivacySettingHelper.h"

@interface TLPrivacySettingViewController ()

@property (nonatomic, strong) TLPrivacySettingHelper *helper;

@end

@implementation TLPrivacySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"隐私"];
    
    self.helper = [[TLPrivacySettingHelper alloc] init];
    self.data = self.helper.minePrivacySettingData;
}

@end
