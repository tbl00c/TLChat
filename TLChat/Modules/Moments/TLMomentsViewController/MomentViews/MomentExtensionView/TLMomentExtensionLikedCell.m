
//
//  TLMomentExtensionLikedCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentExtensionLikedCell.h"
#import <YYText.h>
#import "TLMomentExtension.h"
#import "TLUser.h"

@interface TLMomentExtensionLikedCell ()

@property (nonatomic, assign) BOOL showBottomLine;

@property (nonatomic, strong) YYLabel *label;

@end

@implementation TLMomentExtensionLikedCell

#pragma mark - # ZZFlexibleLayoutViewProtocol
+ (CGFloat)viewHeightByDataModel:(TLMomentExtension *)dataModel
{
    return dataModel.extensionFrame.heightLiked;
}

- (void)setViewDataModel:(TLMomentExtension *)dataModel
{
    self.showBottomLine = dataModel.comments.count > 0;
    [self.label setAttributedText:dataModel.attrLikedFriendsName];
    @weakify(self);
    [dataModel setLikeUserClickAction:^(TLUser *user) {
        @strongify(self);
        if (self.eventAction) {
            self.eventAction(TLMELikedCellEventTypeClickUser, user);
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
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(4, 8, 2, 8));
        }];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.showBottomLine) {
        self.addSeparator(ZZSeparatorPositionBottom);
    }
    else {
        self.removeSeparator(ZZSeparatorPositionBottom);
    }
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
