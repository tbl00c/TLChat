//
//  TLMessageImageView.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMessageImageView.h"

@interface TLMessageImageView ()

@property (nonatomic, strong) CAShapeLayer *maskLayer;

@property (nonatomic, strong) CALayer *contentLayer;

@end

@implementation TLMessageImageView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.layer addSublayer:self.contentLayer];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.maskLayer setFrame:CGRectMake(0, 0, self.width, self.height)];
    [self.contentLayer setFrame:CGRectMake(0, 0, self.width, self.height)];
}

- (void)setThumbnailPath:(NSString *)imagePath highDefinitionImageURL:(NSString *)imageURL
{
    if (imagePath == nil) {
        [self.contentLayer setContents:nil];
    }
    else {
        [self.contentLayer setContents:(id)[UIImage imageNamed:imagePath].CGImage];
    }
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    _backgroundImage = backgroundImage;
    [self.maskLayer setContents:(id)backgroundImage.CGImage];
}

#pragma mark - Getter -
- (CAShapeLayer *)maskLayer
{
    if (_maskLayer == nil) {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.contentsCenter = CGRectMake(0.5, 0.6, 0.1, 0.1);
        _maskLayer.contentsScale = [UIScreen mainScreen].scale;                 //非常关键设置自动拉伸的效果且不变形
    }
    return _maskLayer;
}

- (CALayer *)contentLayer
{
    if (_contentLayer == nil) {
        _contentLayer = [[CALayer alloc] init];
        [_contentLayer setMask:self.maskLayer];
    }
    return _contentLayer;
}


@end
