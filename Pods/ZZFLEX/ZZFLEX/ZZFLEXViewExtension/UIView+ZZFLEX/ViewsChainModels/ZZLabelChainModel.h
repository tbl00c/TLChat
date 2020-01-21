//
//  ZZLabelChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZBaseViewChainModel.h"

@class ZZLabelChainModel;
@interface ZZLabelChainModel : ZZBaseViewChainModel <ZZLabelChainModel *>

ZZFLEX_CHAIN_PROPERTY ZZLabelChainModel *(^ text)(NSString *text);
ZZFLEX_CHAIN_PROPERTY ZZLabelChainModel *(^ font)(UIFont *font);
ZZFLEX_CHAIN_PROPERTY ZZLabelChainModel *(^ textColor)(UIColor *textColor);
ZZFLEX_CHAIN_PROPERTY ZZLabelChainModel *(^ attributedText)(NSAttributedString *attributedText);

ZZFLEX_CHAIN_PROPERTY ZZLabelChainModel *(^ textAlignment)(NSTextAlignment textAlignment);
ZZFLEX_CHAIN_PROPERTY ZZLabelChainModel *(^ numberOfLines)(NSInteger numberOfLines);
ZZFLEX_CHAIN_PROPERTY ZZLabelChainModel *(^ lineBreakMode)(NSLineBreakMode lineBreakMode);
ZZFLEX_CHAIN_PROPERTY ZZLabelChainModel *(^ adjustsFontSizeToFitWidth)(BOOL adjustsFontSizeToFitWidth);

@end

ZZFLEX_EX_INTERFACE(UILabel, ZZLabelChainModel)
