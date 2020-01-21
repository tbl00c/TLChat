//
//  ZZSwitchChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZBaseViewChainModel.h"

@class ZZSwitchChainModel;
@interface ZZSwitchChainModel : ZZBaseViewChainModel<ZZSwitchChainModel *>

ZZFLEX_CHAIN_PROPERTY ZZSwitchChainModel *(^ on)(BOOL on);
ZZFLEX_CHAIN_PROPERTY ZZSwitchChainModel *(^ onTintColor)(UIColor *onTintColor);
ZZFLEX_CHAIN_PROPERTY ZZSwitchChainModel *(^ thumbTintColor)(UIColor *thumbTintColor);

ZZFLEX_CHAIN_PROPERTY ZZSwitchChainModel *(^ onImage)(UIImage *onImage);
ZZFLEX_CHAIN_PROPERTY ZZSwitchChainModel *(^ offImage)(UIImage *offImage);

#pragma mark - # UIControl
ZZFLEX_CHAIN_PROPERTY ZZSwitchChainModel *(^ enabled)(BOOL enabled);
ZZFLEX_CHAIN_PROPERTY ZZSwitchChainModel *(^ selected)(BOOL selected);
ZZFLEX_CHAIN_PROPERTY ZZSwitchChainModel *(^ highlighted)(BOOL highlighted);

ZZFLEX_CHAIN_PROPERTY ZZSwitchChainModel *(^ eventBlock)(UIControlEvents controlEvents, void (^eventBlock)(id sender));

@end

ZZFLEX_EX_INTERFACE(UISwitch, ZZSwitchChainModel)
