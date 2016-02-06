//
//  TLTableViewCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTableViewCell.h"

@interface TLTableViewCell ()

@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation TLTableViewCell

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.topLine];
        [self addSubview:self.bottomLine];
        _leftSeparatorSpace = 10.0f;
        _topLineStyle = TLCellLineStyleNone;
        _bottomLineStyle = TLCellLineStyleDefault;
    }
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    if (_topLineStyle == TLCellLineStyleDefault) {
        [_topLine setFrame:CGRectMake(_leftSeparatorSpace, 0, self.width - _leftSeparatorSpace, 0.5)];
    }
    else if (_topLineStyle == TLCellLineStyleFill) {
        [_topLine setFrame:CGRectMake(0, 0, self.width, 0.5)];
    }
    
    if (_bottomLineStyle == TLCellLineStyleDefault) {
        [_bottomLine setFrame:CGRectMake(_leftSeparatorSpace, self.height - 0.5, self.width - _leftSeparatorSpace, 0.5)];
    }
    else if (_bottomLineStyle == TLCellLineStyleFill) {
        [_bottomLine setFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
    }
}

#pragma mark - Setter
- (void) setTopLineStyle:(TLCellLineStyle)topLineStyle
{
    _topLineStyle = topLineStyle;
    if (topLineStyle == TLCellLineStyleNone) {
        [self.topLine setHidden:YES];
        return;
    }
    
    [self.topLine setHidden:NO];
    [self layoutSubviews];
}

- (void) setBottomLineStyle:(TLCellLineStyle)bottomLineStyle
{
    _bottomLineStyle = bottomLineStyle;
    if (_bottomLineStyle == TLCellLineStyleNone) {
        [self.bottomLine setHidden:YES];
        return;
    }
    
    [self.bottomLine setHidden:NO];
    [self layoutSubviews];
}

- (void) setLeftSeparatorSpace:(CGFloat)leftSeparatorSpace
{
    _leftSeparatorSpace = leftSeparatorSpace;
    [self layoutSubviews];
}

#pragma mark - Getter
- (UIView *) topLine
{
    if (_topLine == nil) {
        _topLine = [[UIView alloc] init];
        [_topLine setBackgroundColor:[UIColor colorCellLine]];
    }
    return _topLine;
}

- (UIView *) bottomLine
{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        [_bottomLine setBackgroundColor:[UIColor colorCellLine]];
    }
    return _bottomLine;
}

@end
