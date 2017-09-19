//
//  UIBarButtonItem+Back.m
//  TLChat
//
//  Created by 李伯坤 on 2017/9/13.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "UIBarButtonItem+Back.h"

@implementation UIBarButtonItem (Back)

- (id)initWithBackTitle:(NSString *)title target:(id)target action:(SEL)action
{
    UIButton *view = [[UIButton alloc] init];
    [view addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_back"]];
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] init];
    [label setText:title];
    [label setTextColor:[UIColor whiteColor]];
    [view addSubview:label];
    
    if (self = [self initWithCustomView:view]) {
        [imageView setFrame:CGRectMake(0, 0, 17, 34)];
        CGSize size = [label sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        [label setFrame:CGRectMake(17, 0, size.width, 34)];
        [view setFrame:CGRectMake(0, 0, label.frame.origin.x + label.frame.size.width, 34)];
    }
    return self;
}

@end
