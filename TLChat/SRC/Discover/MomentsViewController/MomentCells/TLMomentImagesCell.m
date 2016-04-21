//
//  TLMomentImagesCell.m
//  TLChat
//
//  Created by libokun on 16/4/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentImagesCell.h"
#import "TLMomentDetailImagesView.h"

@interface TLMomentImagesCell ()

@property (nonatomic, strong) TLMomentDetailImagesView *detailView;

@end

@implementation TLMomentImagesCell

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
- (TLMomentDetailImagesView *)detailView
{
    if (_detailView == nil) {
        _detailView = [[TLMomentDetailImagesView alloc] init];
    }
    return _detailView;
}

@end
