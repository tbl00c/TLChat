//
//  UIScrollView+iOS11Fixed.m
//  TLChat
//
//  Created by 李伯坤 on 2017/11/9.
//  Copyright © 2017年 lbk. All rights reserved.
//

#import "UIScrollView+iOS11Fixed.h"

@implementation UIScrollView (iOS11Fixed)

- (void)setNeverAdjustmentContentInset:(BOOL)neverAdjustmentContentInset
{
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
}
- (BOOL)neverAdjustmentContentInset
{
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        return self.contentInsetAdjustmentBehavior;
    }
#endif
    return NO;
}

@end
