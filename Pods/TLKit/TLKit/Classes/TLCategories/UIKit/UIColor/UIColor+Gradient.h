//
//  UIColor+Gradient.h
//  TLKit
//
//  Created by 李伯坤 on 2017/8/28.
//  Copyright © 2017年 libokun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Gradient)

/**
 *  渐变颜色
 *
 *  @param fromColor    开始颜色
 *  @param toColor      结束颜色
 *  @param height       渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor*)gradientColorFromColor:(UIColor*)fromColor toColor:(UIColor*)toColor withHeight:(int)height;

@end
