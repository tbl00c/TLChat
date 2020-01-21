//
//  TLShortcutMethod.m
//  Pods
//
//  Created by 李伯坤 on 2017/9/7.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLShortcutMethod.h"

UILabel *createLabel(UIFont *textFont, UIColor *textColor)
{
    UILabel *label = [[UILabel alloc] init];
    [label setFont:textFont];
    [label setTextColor:textColor];
    return label;
}

UIButton *createButton(UIFont *titleFont, UIColor *titleColor, id target, SEL touchUpInsideAction)
{
    UIButton *button = [[UIButton alloc] init];
    !titleFont ? : [button.titleLabel setFont:titleFont];
    !titleFont ? : [button setTitleColor:titleColor forState:UIControlStateNormal];
    if (target && touchUpInsideAction) {
        [button addTarget:target action:touchUpInsideAction forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}
