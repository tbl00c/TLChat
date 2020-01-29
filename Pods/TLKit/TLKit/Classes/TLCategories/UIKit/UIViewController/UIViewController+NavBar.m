//
//  UIViewController+NavBar.m
//  TLKit
//
//  Created by 李伯坤 on 2017/9/12.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "UIViewController+NavBar.h"

@implementation UIViewController (NavBar)

- (UIBarButtonItem *)addDismissBarButtonWithTitle:(NSString *)title
{
    __weak typeof(self) weakSelf = self;
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain actionBlick:^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.navigationItem setLeftBarButtonItem:barButton];
    return barButton;
}

- (UIBarButtonItem *)addLeftBarButtonWithTitle:(NSString *)title actionBlick:(TLBarButtonActionBlock)actionBlock
{
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain actionBlick:actionBlock];
    [self.navigationItem setLeftBarButtonItem:barButton];
    return barButton;
}

- (UIBarButtonItem *)addLeftBarButtonWithImage:(UIImage *)image actionBlick:(TLBarButtonActionBlock)actionBlock
{
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain actionBlick:actionBlock];
    [self.navigationItem setLeftBarButtonItem:barButton];
    return barButton;
}

- (UIBarButtonItem *)addRightBarButtonWithTitle:(NSString *)title actionBlick:(TLBarButtonActionBlock)actionBlock
{
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain actionBlick:actionBlock];
    [self.navigationItem setRightBarButtonItem:barButton];
    return barButton;
}

- (UIBarButtonItem *)addRightBarButtonWithImage:(UIImage *)image actionBlick:(TLBarButtonActionBlock)actionBlock
{
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain actionBlick:actionBlock];
    [self.navigationItem setRightBarButtonItem:barButton];
    return barButton;
}


@end
