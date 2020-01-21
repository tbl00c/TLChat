//
//  TLMenuItemCell.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/17.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLMenuItem.h"
#import <TLTabBarController/TLBadge.h>

@interface TLMenuItemCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

/// 左侧icon
@property (nonatomic, strong) UIImageView *iconView;
/// 左侧标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 红点
@property (nonatomic, strong) TLBadge *badgeView;

/// 右侧副标题
@property (nonatomic, strong) UILabel *detailLabel;
/// 右侧广告图
@property (nonatomic, strong) UIImageView *rightImageView;
/// 右侧广告图红点
@property (nonatomic, strong) TLBadge *rightBadgeView;
/// 右箭头
@property (nonatomic, strong) UIImageView *arrowView;


@property (nonatomic, strong) TLMenuItem *menuItem;

@end
