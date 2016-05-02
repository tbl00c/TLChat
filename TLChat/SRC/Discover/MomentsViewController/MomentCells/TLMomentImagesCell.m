//
//  TLMomentImagesCell.m
//  TLChat
//
//  Created by libokun on 16/4/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentImagesCell.h"
#import "TLMomentImageView.h"

@interface TLMomentImagesCell ()

@property (nonatomic, strong) TLMomentImageView *momentView;

@end

@implementation TLMomentImagesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.momentView];
        [self.momentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setMoment:(TLMoment *)moment
{
    [super setMoment:moment];
    [self.momentView setMoment:moment];
}

- (void)setDelegate:(id<TLMomentViewDelegate>)delegate
{
    [super setDelegate:delegate];
    [self.momentView setDelegate:delegate];
}

#pragma mark - # Getter
- (TLMomentImageView *)momentView
{
    if (_momentView == nil) {
        _momentView = [[TLMomentImageView alloc] init];
    }
    return _momentView;
}

@end
