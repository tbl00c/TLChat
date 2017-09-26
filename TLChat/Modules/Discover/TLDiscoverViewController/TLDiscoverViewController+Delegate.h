//
//  TLDiscoverViewController+Delegate.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/17.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLDiscoverViewController.h"

typedef NS_ENUM(NSInteger, TLDiscoverSectionTag) {
    TLDiscoverSectionTagMoments,
    TLDiscoverSectionTagFounction,
    TLDiscoverSectionTagStudy,
    TLDiscoverSectionTagSocial,
    TLDiscoverSectionTagLife,
    TLDiscoverSectionTagProgram,
};

typedef NS_ENUM(NSInteger, TLDiscoverCellTag) {
    TLDiscoverCellTagMoments,       // 好友圈
    TLDiscoverCellTagScaner,        // 扫一扫
    TLDiscoverCellTagShake,         // 摇一摇
    TLDiscoverCellTagRead,          // 看一看
    TLDiscoverCellTagSearch,        // 搜一搜
    TLDiscoverCellTagNearby,        // 附近的人
    TLDiscoverCellTagBottle,        // 漂流瓶
    TLDiscoverCellTagShopping,      // 购物
    TLDiscoverCellTagGame,          // 游戏
    TLDiscoverCellTagProgram,       // 小程序
};

@interface TLDiscoverViewController (Delegate)

/// 重置tabBar红点
- (void)resetTabBarBadge;

@end
