//
//  TLMomentCell.m
//  TLChat
//
//  Created by libokun on 16/4/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentCell.h"
#import "TLMomentDetailView.h"
#import "TLMomentExtensionView.h"

@interface TLMomentCell ()

@property (nonatomic, strong) TLMomentDetailView *detailView;

@property (nonatomic, strong) TLMomentExtensionView *extensionView;

@end

@implementation TLMomentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.detailContainerView addSubview:self.detailView];
        [self.extensionContainerView addSubview:self.extensionView];
        
        [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.detailContainerView);
        }];
        [self.extensionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.extensionContainerView);
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
- (TLMomentDetailView *)detailView
{
    if (_detailView == nil) {
        _detailView = [[TLMomentDetailView alloc] init];
    }
    return _detailView;
}

- (TLMomentExtensionView *)extensionView
{
    if (_extensionView == nil) {
        _extensionView = [[TLMomentExtensionView alloc] init];
    }
    return _extensionView;
}

@end
