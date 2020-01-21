//
//  ZZLabelChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZLabelChainModel.h"

#define     ZZFLEX_CHAIN_LABEL_IMPLEMENTATION(methodName, ZZParamType)      ZZFLEX_CHAIN_IMPLEMENTATION(methodName, ZZParamType, ZZLabelChainModel *, UILabel)

@implementation ZZLabelChainModel

ZZFLEX_CHAIN_LABEL_IMPLEMENTATION(text, NSString *);
ZZFLEX_CHAIN_LABEL_IMPLEMENTATION(font, UIFont *);
ZZFLEX_CHAIN_LABEL_IMPLEMENTATION(textColor, UIColor *);
ZZFLEX_CHAIN_LABEL_IMPLEMENTATION(attributedText, NSAttributedString *);

ZZFLEX_CHAIN_LABEL_IMPLEMENTATION(textAlignment, NSTextAlignment);
ZZFLEX_CHAIN_LABEL_IMPLEMENTATION(numberOfLines, NSInteger);
ZZFLEX_CHAIN_LABEL_IMPLEMENTATION(lineBreakMode, NSLineBreakMode);
ZZFLEX_CHAIN_LABEL_IMPLEMENTATION(adjustsFontSizeToFitWidth, BOOL);

@end

ZZFLEX_EX_IMPLEMENTATION(UILabel, ZZLabelChainModel)
