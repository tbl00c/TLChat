//
//  UICollectionViewCell+Extensions.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/17.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "UICollectionViewCell+Extensions.h"

@implementation UICollectionViewCell (Extensions)

- (void)setSelectedBackgrounColor:(UIColor *)selectedBackgrounColor
{
    UIView *selectedBGView = [[UIView alloc] init];
    [selectedBGView setBackgroundColor:selectedBackgrounColor];
    [self setSelectedBackgroundView:selectedBGView];
}
- (UIColor *)selectedBackgrounColor
{
    return self.selectedBackgroundView.backgroundColor;
}

@end
