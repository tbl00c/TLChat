//
//  ZZControlChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZControlChainModel.h"
#import "UIControl+ZZEvent.h"

#define     ZZFLEX_CHAIN_CONTROL_IMPLEMENTATION(methodName, ZZParamType)      ZZFLEX_CHAIN_IMPLEMENTATION(methodName, ZZParamType, ZZControlChainModel *, UIControl)

@implementation ZZControlChainModel

ZZFLEX_CHAIN_CONTROL_IMPLEMENTATION(enabled, BOOL);
ZZFLEX_CHAIN_CONTROL_IMPLEMENTATION(selected, BOOL);
ZZFLEX_CHAIN_CONTROL_IMPLEMENTATION(highlighted, BOOL);

- (ZZControlChainModel *(^)(UIControlEvents controlEvents, void (^eventBlock)(id sender)))eventBlock
{
    return ^ZZControlChainModel *(UIControlEvents controlEvents, void (^eventBlock)(id sender)) {
        [(UIControl *)self.view addControlEvents:controlEvents handler:eventBlock];
        return self;
    };
}

ZZFLEX_CHAIN_CONTROL_IMPLEMENTATION(contentVerticalAlignment, UIControlContentVerticalAlignment);
ZZFLEX_CHAIN_CONTROL_IMPLEMENTATION(contentHorizontalAlignment, UIControlContentHorizontalAlignment);

@end

ZZFLEX_EX_IMPLEMENTATION(UIControl, ZZControlChainModel)
