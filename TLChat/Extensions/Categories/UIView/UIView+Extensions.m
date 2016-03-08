//
//  UIView+Extensions.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "UIView+Extensions.h"

@implementation UIView (Extensions)

- (void)removeAllSubViews
{
    for (id view in self.subviews) {
        [view removeFromSuperview];
    }
}

@end
