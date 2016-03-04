//
//  TLShoppingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLShoppingViewController.h"

@implementation TLShoppingViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_shopping_menu"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDown:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
//    [self setUrl:@"http://wq.jd.com/"];
    [self setUrl:@"http://m.zhuanzhuan.com"];
}

#pragma mark - Event Response
- (void) rightBarButtonDown:(UIBarButtonItem *)sender
{

}

@end
