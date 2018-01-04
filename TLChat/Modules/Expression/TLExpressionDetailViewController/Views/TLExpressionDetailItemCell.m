//
//  TLExpressionDetailItemCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionDetailItemCell.h"
#import <SDWebImage/UIImage+GIF.h>
#import "UIImage+Color.h"

@interface TLExpressionDetailItemCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TLExpressionDetailItemCell

+ (CGSize)viewSizeByDataModel:(id)dataModel
{
    return CGSizeMake(EXP_DETAIL_CELL_WIDTH, EXP_DETAIL_CELL_WIDTH);
}

- (void)setViewDataModel:(id)dataModel
{
    [self setEmoji:dataModel];
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView = self.contentView.addImageView(1)
        .cornerRadius(3.0f)
        .masonry(^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        })
        .view;
    }
    return self;
}

- (void)setEmoji:(TLExpressionModel *)emoji
{
    _emoji = emoji;
    UIImage *image = [UIImage imageNamed:emoji.path];
    if (image) {
        [self.imageView setImage:image];
    }
    else {
        [self.imageView tt_setImageWithURL:TLURL(emoji.url)];
    }
}


@end
