//
//  TLInfo.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLInfo.h"

@implementation TLInfo

+ (TLInfo *)createInfoWithTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    TLInfo *info = [[TLInfo alloc] init];
    info.title = title;
    info.subTitle = subTitle;
    return info;
}

- (id)init
{
    if (self = [super init]) {
        self.showDisclosureIndicator = YES;
    }
    return self;
}

- (UIColor *)buttonColor
{
    if (_buttonColor == nil) {
        return [UIColor colorGreenDefault];
    }
    return _buttonColor;
}

- (UIColor *)buttonHLColor
{
    if (_buttonHLColor == nil) {
        return [self buttonColor];
    }
    return _buttonHLColor;
}

- (UIColor *)titleColor
{
    if (_titleColor == nil) {
        return [UIColor blackColor];
    }
    return _titleColor;
}

- (UIColor *)buttonBorderColor
{
    if (_buttonBorderColor == nil) {
        return [UIColor colorGrayLine];
    }
    return _buttonBorderColor;
}

@end
