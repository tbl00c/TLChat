//
//  TLMomentDetailImagesView.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/21.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentDetailImagesView.h"
#import "TLMomentMultiImageView.h"

@interface TLMomentDetailImagesView ()

@property (nonatomic, strong) TLMomentMultiImageView *multiImageView;

@end

@implementation TLMomentDetailImagesView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.multiImageView];
        
        [self.multiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.bottom.mas_equalTo(self);
            make.top.mas_equalTo(self.titleLabel.mas_bottom);
        }];
    }
    return self;
}

- (void)setDetail:(TLMomentDetail *)detail
{
    [super setDetail:detail];
    [self.multiImageView setImages:detail.images];
    CGFloat offset = detail.images.count > 0 ? (detail.text.length > 0 ? 7.0 : 3.0) : 0.0;
    [self.multiImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(offset);
    }];
}

- (void)setDelegate:(id<TLMomentDetailViewDelegate>)delegate
{
    [super setDelegate:delegate];
    [self.multiImageView setDelegate:delegate];
}

#pragma mark - # Getter
- (TLMomentMultiImageView *)multiImageView
{
    if (_multiImageView == nil) {
        _multiImageView = [[TLMomentMultiImageView alloc] init];
        [_multiImageView setDelegate:self.delegate];
    }
    return _multiImageView;
}

@end
