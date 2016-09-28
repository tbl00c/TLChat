
//
//  TLMomentExtensionLikedCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentExtensionLikedCell.h"

@interface TLMomentExtensionLikedCell ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation TLMomentExtensionLikedCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView).mas_offset(UIEdgeInsetsMake(2, 8, 2, 8));
        }];
    }
    return self;
}

- (void)setLikedFriends:(NSArray *)likedFriends
{
    _likedFriends = likedFriends;
    NSMutableString *str = [[NSMutableString alloc] init];
    for (TLUser *user in likedFriends) {
        [str appendString:user.showName];
        if (likedFriends.lastObject != user) {
            [str appendString:@", "];
        }
    }
    [self.label setText:str];
}

- (void)setShowBottomLine:(BOOL)showBottomLine
{
    _showBottomLine = showBottomLine;
    if (showBottomLine) {
        [self setBottomLineStyle:TLCellLineStyleFill];
    }
    else {
        [self setBottomLineStyle:TLCellLineStyleNone];
    }
}

#pragma mark - # Getter
- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        [_label setFont:[UIFont boldSystemFontOfSize:14.0]];
        [_label setTextColor:[UIColor colorBlueMoment]];
    }
    return _label;
}

@end
