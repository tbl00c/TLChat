//
//  UIBarButtonItem+Action.h
//  TLKit
//
//  Created by 李伯坤 on 2017/8/28.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TLBarButtonActionBlock)();

@interface UIBarButtonItem (Action)

+ (id)fixItemSpace:(CGFloat)space;

- (id)initWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style actionBlick:(TLBarButtonActionBlock)actionBlock;

- (id)initWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style actionBlick:(TLBarButtonActionBlock)actionBlock;

- (void)setActionBlock:(TLBarButtonActionBlock)actionBlock;

@end
