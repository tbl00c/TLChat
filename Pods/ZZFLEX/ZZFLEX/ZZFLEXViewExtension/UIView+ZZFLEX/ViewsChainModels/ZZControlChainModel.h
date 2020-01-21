//
//  ZZControlChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZBaseViewChainModel.h"

@class ZZControlChainModel;
@interface ZZControlChainModel : ZZBaseViewChainModel<ZZControlChainModel *>

ZZFLEX_CHAIN_PROPERTY ZZControlChainModel *(^ enabled)(BOOL enabled);
ZZFLEX_CHAIN_PROPERTY ZZControlChainModel *(^ selected)(BOOL selected);
ZZFLEX_CHAIN_PROPERTY ZZControlChainModel *(^ highlighted)(BOOL highlighted);

ZZFLEX_CHAIN_PROPERTY ZZControlChainModel *(^ eventBlock)(UIControlEvents controlEvents, void (^eventBlock)(id sender));

ZZFLEX_CHAIN_PROPERTY ZZControlChainModel *(^ contentVerticalAlignment)(UIControlContentVerticalAlignment contentVerticalAlignment);
ZZFLEX_CHAIN_PROPERTY ZZControlChainModel *(^ contentHorizontalAlignment)(UIControlContentHorizontalAlignment contentHorizontalAlignment);


@end

ZZFLEX_EX_INTERFACE(UIControl, ZZControlChainModel)
