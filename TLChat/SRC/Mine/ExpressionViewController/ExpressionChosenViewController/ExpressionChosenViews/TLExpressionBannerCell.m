//
//  TLExpressionBannerCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionBannerCell.h"
#import "TLPictureCarouselView.h"

@interface TLExpressionBannerCell () <TLPictureCarouselDelegate>

@property (nonatomic, strong) TLPictureCarouselView *picCarouselView;

@end

@implementation TLExpressionBannerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBottomLineStyle:TLCellLineStyleNone];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.contentView addSubview:self.picCarouselView];
        
        [self p_addMasonry];
    }
    return self;
}

- (void)setData:(NSArray *)data
{
    _data = data;
    [self.picCarouselView setData:data];
}

#pragma mark - # Delegate
- (void)pictureCarouselView:(TLPictureCarouselView *)pictureCarouselView didSelectItem:(id<TLPictureCarouselProtocol>)model
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(expressionBannerCellDidSelectBanner:)]) {
        [self.delegate expressionBannerCellDidSelectBanner:model];
    }
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.picCarouselView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}

#pragma mark - # Getter 
- (TLPictureCarouselView *)picCarouselView
{
    if (_picCarouselView == nil) {
        _picCarouselView = [[TLPictureCarouselView alloc] init];
        [_picCarouselView setDelegate:self];
    }
    return _picCarouselView;
}

@end
