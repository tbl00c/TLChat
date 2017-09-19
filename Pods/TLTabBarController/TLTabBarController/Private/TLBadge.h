//
//  TLBadge.h
//  TLKit
//
//  Created by 李伯坤 on 2017/7/7.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLBadge : UIView

/// 标题（空字符串显示点，nil隐藏）
@property (nonatomic, strong) NSString *badgeValue;

/// 标题字体 （默认12）
@property (nonatomic, strong) UIFont *titleFont;

/// 标题颜色 （默认白色）
@property (nonatomic, strong) UIColor *titleColor;

/// 气泡显示文字是时的高度（一行，默认18）
@property (nonatomic, assign) CGFloat maxHeight;

/// 气泡显示为点时的高度（默认10）
@property (nonatomic, assign) CGFloat minHeight;

/**
 *  根据标题获取气泡大小
 */
+ (CGSize)badgeSizeWithValue:(NSString *)value;

/**
 *  根据标题和字体获取气泡大小
 */
+ (CGSize)badgeSizeWithValue:(NSString *)value font:(UIFont *)font;

/**
 *  根据标题、字体、最大最小高度获取气泡大小
 */
+ (CGSize)badgeSizeWithValue:(NSString *)value font:(UIFont *)font maxHeight:(CGFloat)maxHeight minHeight:(CGFloat)minHeight;

@end
