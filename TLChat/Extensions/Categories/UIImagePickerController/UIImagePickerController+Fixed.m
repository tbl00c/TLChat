//
//  UIImagePickerController+Fixed.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/3.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "UIImagePickerController+Fixed.h"

@implementation UIImagePickerController (Fixed)

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationBar setBarTintColor:[UIColor colorNavBarBarTint]];
    [self.navigationBar setTintColor:[UIColor colorNavBarTint]];
    [self.view setBackgroundColor:[UIColor colorTableViewBG]];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                           NSFontAttributeName:[UIFont fontNavBarTitle]}];
}

@end
