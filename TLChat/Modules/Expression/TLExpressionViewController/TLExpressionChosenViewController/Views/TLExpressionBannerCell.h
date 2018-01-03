//
//  TLExpressionBannerCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TLExpressionBannerCellDelegate <NSObject>

- (void)expressionBannerCellDidSelectBanner:(id)item;

@end

@interface TLExpressionBannerCell : UITableViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, assign) id<TLExpressionBannerCellDelegate>delegate;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, copy) void (^bannerClickAction)(id bannerModel);

@end
