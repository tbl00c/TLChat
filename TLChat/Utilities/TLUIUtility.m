
//
//  TLUIUtility.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLUIUtility.h"

static UILabel *hLabel = nil;

@implementation TLUIUtility

+ (CGFloat) getTextHeightOfText:(NSString *)text
                           font:(UIFont *)font
                          width:(CGFloat)width
{
    if (hLabel == nil) {
        hLabel = [[UILabel alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [hLabel setNumberOfLines:0];
    }
    [hLabel setWidth:width];
    [hLabel setFont:font];
    [hLabel setText:text];
    return [hLabel sizeThatFits:CGSizeMake(width, MAXFLOAT)].height;
}

@end
