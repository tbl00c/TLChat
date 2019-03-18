//
//  ZZImageViewChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZImageViewChainModel.h"

#define     ZZFLEX_CHAIN_IV_IMPLEMENTATION(methodName, ZZParamType)      ZZFLEX_CHAIN_IMPLEMENTATION(methodName, ZZParamType, ZZImageViewChainModel *, UIImageView)

@implementation ZZImageViewChainModel

ZZFLEX_CHAIN_IV_IMPLEMENTATION(image, UIImage *);
ZZFLEX_CHAIN_IV_IMPLEMENTATION(highlightedImage, UIImage *);
ZZFLEX_CHAIN_IV_IMPLEMENTATION(highlighted, BOOL);

@end

ZZFLEX_EX_IMPLEMENTATION(UIImageView, ZZImageViewChainModel)
