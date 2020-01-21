//
//  TLExpressionDetailBannerCell.m
//  TLChat
//
//  Created by 李伯坤 on 2018/1/4.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLExpressionDetailBannerCell.h"

@interface TLExpressionDetailBannerCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TLExpressionDetailBannerCell

+ (CGSize)viewSizeByDataModel:(id)dataModel
{
    return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH * 0.45);
}

- (void)setViewDataModel:(NSString *)dataModel
{
    if (dataModel) {
        [self.imageView tt_setImageWithURL:TLURL(dataModel)];
    }
    else {
        [self.imageView setImage:nil];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.imageView = self.addImageView(1)
        .clipsToBounds(YES)
        .contentMode(UIViewContentModeScaleAspectFill)
        .masonry(^(MASConstraintMaker *make){
            make.edges.mas_equalTo(0);
        })
        .view;
    }
    return self;
}

@end
