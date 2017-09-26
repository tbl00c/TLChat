//
//  TLMineViewController+Delegate.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/18.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLMineViewController.h"

typedef NS_ENUM(NSInteger, TLMineSectionTag) {
    TLMineSectionTagUserInfo,
    TLMineSectionTagWallet,
    TLMineSectionTagFounction,
    TLMineSectionTagExpression,
    TLMineSectionTagSetting,
};

typedef NS_ENUM(NSInteger, TLMineCellTag) {
    TLMineCellTagUserInfo,
    TLMineCellTagWallet,
    TLMineCellTagCollect,
    TLMineCellTagAlbum,
    TLMineCellTagCard,
    TLMineCellTagExpression,
    TLMineCellTagSetting,
};

@interface TLMineViewController (Delegate)

/// 重置tabBar红点
- (void)resetTabBarBadge;

@end
