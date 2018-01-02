//
//  TLEmojiGroupCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/19.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiGroupCell.h"

@interface TLEmojiGroupCell ()

@property (nonatomic, strong) UIImageView *groupIconView;

@end

@implementation TLEmojiGroupCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        UIView *selectedView = [[UIView alloc] init];
        [selectedView setBackgroundColor:[UIColor colorGrayForChatBar]];
        [self setSelectedBackgroundView:selectedView];
        
        [self.contentView addSubview:self.groupIconView];
        [self p_addMasonry];
    }
    return self;
}

- (void)setEmojiGroup:(TLExpressionGroupModel *)emojiGroup
{
    _emojiGroup = emojiGroup;
    [self.groupIconView setImage:[UIImage imageNamed:emojiGroup.iconPath]];
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.groupIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
        make.width.and.height.mas_lessThanOrEqualTo(30);
    }];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor colorGrayLine].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.width - 0.5, 5);
    CGContextAddLineToPoint(context, self.width - 0.5, self.height - 5);
    CGContextStrokePath(context);
}

#pragma mark - Getter -
- (UIImageView *)groupIconView
{
    if (_groupIconView == nil) {
        _groupIconView = [[UIImageView alloc] init];
    }
    return _groupIconView;
}

@end
