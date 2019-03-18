//
//  UIView+ZZFLEX.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ZZSeparator.h"

#import "ZZViewChainModel.h"
#import "ZZLabelChainModel.h"
#import "ZZImageViewChainModel.h"

#import "ZZControlChainModel.h"
#import "ZZTextFieldChainModel.h"
#import "ZZButtonChainModel.h"
#import "ZZSwitchChainModel.h"

#import "ZZScrollViewChainModel.h"
#import "ZZTextViewChainModel.h"
#import "ZZTableViewChainModel.h"
#import "ZZCollectionViewChainModel.h"

#define     ZZFLEX_VIEW_CHAIN_TYPE              @property (nonatomic, copy, readonly)

@interface UIView (ZZFLEX)

/// 添加View
ZZFLEX_VIEW_CHAIN_TYPE ZZViewChainModel *(^ addView)(NSInteger tag);

/// 添加Label
ZZFLEX_VIEW_CHAIN_TYPE ZZLabelChainModel *(^ addLabel)(NSInteger tag);

/// 添加ImageView
ZZFLEX_VIEW_CHAIN_TYPE ZZImageViewChainModel *(^ addImageView)(NSInteger tag);

#pragma mark - # 按钮类
/// 添加Control
ZZFLEX_VIEW_CHAIN_TYPE ZZControlChainModel *(^ addControl)(NSInteger tag);

/// 添加TextField
ZZFLEX_VIEW_CHAIN_TYPE ZZTextFieldChainModel *(^ addTextField)(NSInteger tag);

/// 添加Button
ZZFLEX_VIEW_CHAIN_TYPE ZZButtonChainModel *(^ addButton)(NSInteger tag);

/// 添加Switch
ZZFLEX_VIEW_CHAIN_TYPE ZZSwitchChainModel *(^ addSwitch)(NSInteger tag);

#pragma mark - # 滚动视图类
/// 添加ScrollView
ZZFLEX_VIEW_CHAIN_TYPE ZZScrollViewChainModel *(^ addScrollView)(NSInteger tag);

/// 添加TextView
ZZFLEX_VIEW_CHAIN_TYPE ZZTextViewChainModel *(^ addTextView)(NSInteger tag);

/// 添加TableView
ZZFLEX_VIEW_CHAIN_TYPE ZZTableViewChainModel *(^ addTableView)(NSInteger tag);

/// 添加CollectionView
ZZFLEX_VIEW_CHAIN_TYPE ZZCollectionViewChainModel *(^ addCollectionView)(NSInteger tag);

@end
