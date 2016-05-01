//
//  TLImageBrowserController.m
//  TLChat
//
//  Created by 李伯坤 on 16/5/1.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLImageBrowserController.h"

@implementation TLImageBrowserController

- (id)initWithImages:(NSArray *)images curImageIndex:(NSInteger)index curImageRect:(CGRect)rect
{
    if (self = [super init]) {
        self.images = images;
        self.curIndex = index;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}

@end
