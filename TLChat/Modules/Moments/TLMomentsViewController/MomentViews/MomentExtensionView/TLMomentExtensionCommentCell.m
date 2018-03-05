//
//  TLMomentExtensionCommentCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentExtensionCommentCell.h"
#import <YYText.h>

@interface TLMomentExtensionCommentCell ()

@property (nonatomic, strong) YYLabel *label;

@end


@implementation TLMomentExtensionCommentCell

#pragma mark - # ZZFlexibleLayoutViewProtocol
+ (CGFloat)viewHeightByDataModel:(TLMomentComment *)dataModel
{
    return dataModel.commentFrame.height;
}

- (void)setViewDataModel:(TLMomentComment *)dataModel
{
    [self.label setAttributedText:dataModel.attrContent];
    [self.label sizeToFit];
    @weakify(self);
    [dataModel setUserClickAction:^(TLUser *user) {
        @strongify(self);
        if (self.eventAction) {
            self.eventAction(TLMECommentCellEventTypeUserClick, user);
        }
    }];
}

- (void)setViewEventAction:(id (^)(NSInteger, id))eventAction
{
    self.eventAction = eventAction;
}

#pragma mark - # Cell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(1.5, 8, 0.5, 8));
        }];
    }
    return self;
}

#pragma mark - # Getter
- (YYLabel *)label
{
    if (_label == nil) {
        _label = [[YYLabel alloc] init];
        [_label setNumberOfLines:0];
    }
    return _label;
}

@end
