//
//  UIButton+TLChat.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "UIButton+TLChat.h"

@implementation UIButton (TLChat)

+ (UIButton *)defaultButton
{
    UIButton *button = [[UIButton alloc] init];
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:4.0f];
    [button.layer setBorderWidth:BORDER_WIDTH_1PX];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [button setBackgroundColor:[UIColor colorGreenDefault]];
    return button;
}

- (void)setImage:(UIImage *)image imageHL:(UIImage *)imageHL
{
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:imageHL forState:UIControlStateHighlighted];
}

@end
