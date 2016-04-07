//
//  TLMomentCell.m
//  TLChat
//
//  Created by libokun on 16/4/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentCell.h"
#import "TLMomentDetailView.h"
#import "TLMomentCommentView.h"

@interface TLMomentCell ()

@property (nonatomic, strong) TLMomentDetailView *detailView;

@property (nonatomic, strong) TLMomentCommentView *commentView;

@end

@implementation TLMomentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.detailContainerView addSubview:self.detailView];
        [self.commentContainerView addSubview:self.commentView];
        
        [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.detailContainerView);
        }];
        [self.commentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.commentContainerView);
        }];
    }
    return self;
}

#pragma mark - # Getter -
- (TLMomentDetailView *)detailView
{
    if (_detailView == nil) {
        _detailView = [[TLMomentDetailView alloc] init];
    }
    return _detailView;
}

- (TLMomentCommentView *)commentView
{
    if (_commentView == nil) {
        _commentView = [[TLMomentCommentView alloc] init];
    }
    return _commentView;
}

@end
