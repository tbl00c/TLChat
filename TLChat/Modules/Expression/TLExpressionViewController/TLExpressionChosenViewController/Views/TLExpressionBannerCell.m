//
//  TLExpressionBannerCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionBannerCell.h"
#import "TLPictureCarouselView.h"
#import "TLExpressionGroupModel.h"

@interface TLExpressionBannerCell ()

@property (nonatomic, strong) TLPictureCarouselView *picCarouselView;

@end

@implementation TLExpressionBannerCell

#pragma mark - # Protocol
+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 0.4 * SCREEN_WIDTH;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setData:dataModel];
}

- (void)setViewDelegate:(id)delegate
{
    [self setDelegate:delegate];
}

- (void)setViewEventAction:(id (^)(NSInteger, id))eventAction
{
    [self setBannerClickAction:^(id bannerModel) {
        if (eventAction) {
            eventAction(0, bannerModel);
        }
    }];
}

#pragma mark - # Public Methods
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
        @weakify(self);
        [_picCarouselView setDidSelectItem:^(TLPictureCarouselView *pictureCarouselView, id<TLPictureCarouselProtocol> model){
            @strongify(self);
            if (self.bannerClickAction) {
                self.bannerClickAction(model);
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(expressionBannerCellDidSelectBanner:)]) {
                [self.delegate expressionBannerCellDidSelectBanner:model];
            }
        }];
    }
    return _picCarouselView;
}

@end

#pragma mark - ## TLExpressionGroupModel (TLExpressionBannerCell)
@interface TLExpressionGroupModel (TLExpressionBannerCell) <TLPictureCarouselProtocol>

@end

@implementation TLExpressionGroupModel (TLExpressionBannerCell)

- (NSString *)pictureURL
{
    return self.bannerURL;
}

@end
