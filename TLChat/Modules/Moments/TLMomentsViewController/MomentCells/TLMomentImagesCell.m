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

@property (nonatomic, strong) TLMomentDetailImagesView *imagesView;

@end

@implementation TLMomentImagesCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        @weakify(self);
        self.imagesView = [[TLMomentDetailImagesView alloc] initWithImageSelectedAction:^(NSArray *images, NSInteger index) {
            @strongify(self);
            if (self.delegate && [self.delegate respondsToSelector:@selector(momentViewClickImage:atIndex:)]) {
                [self.delegate momentViewClickImage:images atIndex:index];
            }
        }];
        [self.detailContainer addSubview:self.imagesView];
        [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setMoment:(TLMoment *)moment
{
    [super setMoment:moment];
    
    [self.imagesView setImages:moment.detail.images];
    [self.detailContainer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(moment.detail.detailFrame.heightImages);
    }];
}

@end
