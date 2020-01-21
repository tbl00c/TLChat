//
//  ZZCollectionViewChainModel.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZBaseViewChainModel.h"

@class ZZTableViewChainModel;
@interface ZZTableViewChainModel : ZZBaseViewChainModel<ZZTableViewChainModel *>

ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ delegate)(id<UITableViewDelegate> delegate);
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ dataSource)(id<UITableViewDataSource> dataSource);

ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ rowHeight)(CGFloat rowHeight);
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ sectionHeaderHeight)(CGFloat sectionHeaderHeight);
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ sectionFooterHeight)(CGFloat sectionFooterHeight);
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ estimatedRowHeight)(CGFloat estimatedRowHeight);
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ estimatedSectionHeaderHeight)(CGFloat estimatedSectionHeaderHeight);
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ estimatedSectionFooterHeight)(CGFloat estimatedSectionFooterHeight);
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ separatorInset)(UIEdgeInsets separatorInset);

ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ editing)(BOOL editing);
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ allowsSelection)(BOOL allowsSelection);
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ allowsMultipleSelection)(BOOL allowsMultipleSelection);
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ allowsSelectionDuringEditing)(BOOL allowsSelectionDuringEditing);
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ allowsMultipleSelectionDuringEditing)(BOOL allowsMultipleSelectionDuringEditing);

ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ separatorStyle)(UITableViewCellSeparatorStyle separatorStyle);
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ separatorColor)(UIColor *separatorColor);

ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ tableHeaderView)(UIView * tableHeaderView);
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ tableFooterView)(UIView * separatorStyle);

ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ sectionIndexBackgroundColor)(UIColor *sectionIndexBackgroundColor);
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ sectionIndexColor)(UIColor *sectionIndexColor);

#pragma mark - UIScrollView
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ contentSize)(CGSize contentSize);
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ contentOffset)(CGPoint contentOffset);
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ contentInset)(UIEdgeInsets contentInset);

ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ bounces)(BOOL bounces);
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ alwaysBounceVertical)(BOOL alwaysBounceVertical);
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ alwaysBounceHorizontal)(BOOL alwaysBounceHorizontal);

ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ pagingEnabled)(BOOL pagingEnabled);
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ scrollEnabled)(BOOL scrollEnabled);

ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ showsHorizontalScrollIndicator)(BOOL showsHorizontalScrollIndicator);
ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ showsVerticalScrollIndicator)(BOOL showsVerticalScrollIndicator);

ZZFLEX_CHAIN_PROPERTY ZZTableViewChainModel *(^ scrollsToTop)(BOOL scrollsToTop);

@end

ZZFLEX_EX_INTERFACE(UITableView, ZZTableViewChainModel)
