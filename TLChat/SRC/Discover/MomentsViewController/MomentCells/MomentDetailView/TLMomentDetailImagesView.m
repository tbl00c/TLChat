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
}

#pragma mark - # Getter -
- (TLMomentMultiImageView *)multiImageView
{
    if (_multiImageView == nil) {
        _multiImageView = [[TLMomentMultiImageView alloc] init];
    }
    return _multiImageView;
}

@end
