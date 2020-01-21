//
//  TLSettingItemBaseCell.h
//  TLChat
//
//  Created by 李伯坤 on 2018/3/6.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLSettingItem.h"

@interface TLSettingItemBaseCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

/// 右箭头
@property (nonatomic, strong) UIImageView *arrowView;

@property (nonatomic, strong) TLSettingItem *item;

@end
