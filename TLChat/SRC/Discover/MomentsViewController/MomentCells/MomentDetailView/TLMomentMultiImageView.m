//
//  TLMomentMultiImageView.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/21.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentMultiImageView.h"
#import "UIView+Extensions.h"
#import <UIImageView+WebCache.h>

#define     WIDTH_IMAGE_ONE     (WIDTH_SCREEN - 70) * 0.6
#define     WIDTH_IMAGE         (WIDTH_SCREEN - 70) * 0.31
#define     SPACE               4.0

@interface TLMomentMultiImageView ()

@property (nonatomic, strong) NSMutableArray *imageViews;

@end

@implementation TLMomentMultiImageView

- (void)setImages:(NSArray *)images
{
    _images = images;
    [self removeAllSubViews];
   
    if (images.count == 0) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        return;
    }
    
    CGFloat height = 0;
    CGFloat imageWidth;
    CGFloat imageHeight;
    if (images.count == 1) {
        imageWidth = WIDTH_IMAGE_ONE;
        imageHeight = imageWidth * 0.8;
        height += imageHeight;
    }
    else {
        imageHeight = imageWidth = WIDTH_IMAGE;
        if (images.count <= 3) {
            height += imageHeight;
        }
        else if (images.count <= 6) {
            height += imageHeight * 2 + SPACE;
        }
        else {
            height += imageHeight * 3 + SPACE * 2;
        }
    }
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
    
    CGFloat x = 0;
    CGFloat y = 0;
    for (int i = 0; i < images.count && i < 9; i++) {
        UIImageView *imageView;
        if (i < self.imageViews.count) {
            imageView = self.imageViews[i];
        }
        else {
            imageView = [[UIImageView alloc] init];
            [self.imageViews addObject:imageView];
        }
        [imageView sd_setImageWithURL:images[i]];
        [imageView setFrame:CGRectMake(x, y, imageWidth, imageHeight)];
        [self addSubview:imageView];
        
        if ((i != 0 && images.count != 4 && (i + 1) % 3 == 0) || (images.count == 4 && i == 1)) {
            y += (imageHeight + SPACE);
            x = 0;
        }
        else {
            x += (imageWidth + SPACE);
        }
    }
    
}

@end
