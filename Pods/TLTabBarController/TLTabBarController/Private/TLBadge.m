//
//  TLBadge.m
//  TLKit
//
//  Created by 李伯坤 on 2017/7/7.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLBadge.h"

#define     FONT_TITLE          [UIFont systemFontOfSize:12]
#define     EDGE_TITLE          self.frame.size.height * 0.3
#define     MAX_HEIGHT          18.0f
#define     MIN_HEIGHT          10.0f

@interface TLBadge ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TLBadge

#pragma mark - # Class Methods
+ (CGSize)badgeSizeWithValue:(NSString *)value
{
    return [self badgeSizeWithValue:value font:FONT_TITLE];
}

+ (CGSize)badgeSizeWithValue:(NSString *)value font:(UIFont *)font
{
    return [self badgeSizeWithValue:value font:font maxHeight:MAX_HEIGHT minHeight:MIN_HEIGHT];
}

+ (CGSize)badgeSizeWithValue:(NSString *)value font:(UIFont *)font maxHeight:(CGFloat)maxHeight minHeight:(CGFloat)minHeight
{
    if (!value) {
        return CGSizeZero;
    }
    if ([value isEqualToString:@""]) {
        return CGSizeMake(minHeight, minHeight);
    }
    CGSize size = [value sizeWithAttributes:@{NSFontAttributeName : font}];
    CGFloat width = MAX(size.width + maxHeight * 0.6, maxHeight);
    return CGSizeMake(width, maxHeight);
}

#pragma mark - # Init
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.layer setMasksToBounds:YES];
        [self addSubview:self.titleLabel];
        
        // 默认属性设置
        [self setBackgroundColor:[UIColor redColor]];
        [self setTitleColor:[UIColor whiteColor]];
        [self setTitleFont:FONT_TITLE];
        [self setMaxHeight:MAX_HEIGHT];
        [self setMinHeight:MIN_HEIGHT];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 更新圆角大小
    [self.layer setCornerRadius:self.frame.size.height / 2.0];
    // 更新titleLabel坐标和大小
    if ([self.badgeValue isEqualToString:@""]) {
        [self.titleLabel setFrame:CGRectMake(0, 0, self.minHeight, self.minHeight)];
    }
    else {
        CGFloat height = [self.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)].height;
        [self.titleLabel setFrame:CGRectMake(0, 0, self.frame.size.width - EDGE_TITLE * 2, height)];
    }
    
    [self.titleLabel setCenter:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0)];
}

#pragma mark - # Public Methods
- (void)setBadgeValue:(id)badgeValue
{
    _badgeValue = badgeValue;
    [self.titleLabel setText:badgeValue];
    [self.titleLabel sizeToFit];
    
    [self p_resetFrame];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    [self.titleLabel setFont:titleFont];
    
    [self p_resetFrame];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [self.titleLabel setTextColor:titleColor];
}

- (void)setMaxHeight:(CGFloat)maxHeight
{
    _maxHeight = maxHeight;
    
    [self p_resetFrame];
}

- (void)setMinHeight:(CGFloat)minHeight
{
    _minHeight = minHeight;
    
    [self p_resetFrame];
}

#pragma mark - # Private Methods
- (void)p_resetFrame
{
    CGSize size = [TLBadge badgeSizeWithValue:self.badgeValue font:self.titleFont maxHeight:self.maxHeight minHeight:self.minHeight];
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height)];
    [self setNeedsDisplay];
}

#pragma mark - # Getters
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setLineBreakMode:NSLineBreakByTruncatingMiddle];
    }
    return _titleLabel;
}

@end
