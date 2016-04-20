//
//  TLExpressionBannerCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTableViewCell.h"

@protocol TLExpressionBannerCellDelegate <NSObject>

- (void)expressionBannerCellDidSelectBanner:(id)item;

@end

@interface TLExpressionBannerCell : TLTableViewCell

@property (nonatomic, assign) id<TLExpressionBannerCellDelegate>delegate;

@property (nonatomic, strong) NSArray *data;

@end
