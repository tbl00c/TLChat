//
//  TLDiscoverViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDiscoverViewController.h"
#import "TLDiscoverHelper.h"

@interface TLDiscoverViewController ()

@property (nonatomic, strong) TLDiscoverHelper *discoverHelper;

@end

@implementation TLDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"发现"];
    
    self.discoverHelper = [[TLDiscoverHelper alloc] init];
    self.data = self.discoverHelper.discoverMenuData;
}

@end
