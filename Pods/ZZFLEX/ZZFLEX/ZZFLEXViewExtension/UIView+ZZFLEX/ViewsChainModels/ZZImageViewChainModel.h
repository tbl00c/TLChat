//
//  ZZImageViewChainModel.h
//  zhuanzhuan
//
//  Created by 李伯坤 on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZBaseViewChainModel.h"

@class ZZImageViewChainModel;
@interface ZZImageViewChainModel : ZZBaseViewChainModel <ZZImageViewChainModel *>

ZZFLEX_CHAIN_PROPERTY ZZImageViewChainModel *(^ image)(UIImage *image);
ZZFLEX_CHAIN_PROPERTY ZZImageViewChainModel *(^ highlightedImage)(UIImage *highlightedImage);
ZZFLEX_CHAIN_PROPERTY ZZImageViewChainModel *(^ highlighted)(BOOL highlighted);

@end

ZZFLEX_EX_INTERFACE(UIImageView, ZZImageViewChainModel)
