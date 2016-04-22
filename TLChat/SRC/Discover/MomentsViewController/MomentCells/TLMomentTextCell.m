//
//  TLMomentTextCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentTextCell.h"
#import "TLMomentDetailTextView.h"

@interface TLMomentTextCell ()

@property (nonatomic, strong) TLMomentDetailTextView *detailView;

@end

@implementation TLMomentTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.detailContainerView addSubview:self.detailView];
        
        [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.detailContainerView);
        }];
    }
    return self;
}

- (void)setMoment:(TLMoment *)moment
{
    [super setMoment:moment];
    [self.detailView setDetail:moment.detail];
}

#pragma mark - # Getter -
- (TLMomentDetailTextView *)detailView
{
    if (_detailView == nil) {
        _detailView = [[TLMomentDetailTextView alloc] init];
    }
    return _detailView;
}

@end