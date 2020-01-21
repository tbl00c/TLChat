//
//  TLPictureCarouselViewCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLPictureCarouselViewCell.h"

@interface TLPictureCarouselViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TLPictureCarouselViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.imageView];
        
        [self p_addMasonry];
    }
    return self;
}

- (void)setModel:(id<TLPictureCarouselProtocol>)model
{
    [self.imageView tt_setImageWithURL:TLURL([model pictureURL])];
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}

#pragma mark - # Getter
- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

@end
