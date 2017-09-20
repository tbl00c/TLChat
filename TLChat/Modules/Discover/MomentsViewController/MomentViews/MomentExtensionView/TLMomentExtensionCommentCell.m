//
//  TLMomentExtensionCommentCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentExtensionCommentCell.h"

@interface TLMomentExtensionCommentCell ()

@property (nonatomic, strong) UILabel *label;

@end


@implementation TLMomentExtensionCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setBottomLineStyle:TLCellLineStyleNone];
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView).mas_offset(UIEdgeInsetsMake(2, 8, 2, 8));
        }];
    }
    return self;
}

- (void)setComment:(TLMomentComment *)comment
{
    _comment = comment;
    NSMutableString *str = [[NSMutableString alloc] init];
    if (comment.user && !(comment.toUser && [comment.toUser.userID isEqualToString:comment.user.userID])) {
        [str appendString:comment.user.showName];
        if (comment.toUser) {
            [str appendFormat:@"回复%@: ", comment.toUser.showName];
        }
        else {
            [str appendString:@": "];
        }
    }
    [str appendString:comment.content];
    [self.label setText:str];
}

#pragma mark - # Getter
- (UILabel *)label
{
    if (_label == nil) {
        _label = [[UILabel alloc] init];
        [_label setFont:[UIFont systemFontOfSize:14.0]];
    }
    return _label;
}


@end
