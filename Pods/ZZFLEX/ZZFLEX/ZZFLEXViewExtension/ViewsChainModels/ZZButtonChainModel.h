//
//  ZZButtonChainModel.h
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZBaseViewChainModel.h"

@class ZZButtonChainModel;
@interface ZZButtonChainModel : ZZBaseViewChainModel<ZZButtonChainModel *>

ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ title)(NSString *title);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ titleHL)(NSString *titleHL);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ titleSelected)(NSString *titleSelected);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ titleDisabled)(NSString *titleDisabled);

ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ titleColor)(UIColor *titleColor);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ titleColorHL)(UIColor *titleColorHL);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ titleColorSelected)(UIColor *titleColorSelected);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ titleColorDisabled)(UIColor *titleColorDisabled);

ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ titleShadowColor)(UIColor *titleShadowColor);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ titleShadowColorHL)(UIColor *titleShadowColorHL);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ titleShadowColorSelected)(UIColor *titleShadowColorSelected);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ titleShadowColorDisabled)(UIColor *titleShadowColorDisabled);

ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ image)(UIImage *image);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ imageHL)(UIImage *imageHL);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ imageSelected)(UIImage *imageSelected);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ imageDisabled)(UIImage *imageDisabled);

ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ backgroundImage)(UIImage *backgroundImage);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ backgroundImageHL)(UIImage *backgroundImageHL);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ backgroundImageSelected)(UIImage *backgroundImageSelected);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ backgroundImageDisabled)(UIImage *backgroundImageDisabled);

ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ attributedTitle)(NSAttributedString *attributedTitle);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ attributedTitleHL)(NSAttributedString *attributedTitleHL);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ attributedTitleSelected)(NSAttributedString *attributedTitleSelected);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ attributedTitleDisabled)(NSAttributedString *attributedTitleDisabled);

ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ backgroundColorHL)(UIColor *backgroundColorHL);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ backgroundColorSelected)(UIColor *backgroundColorSelected);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ backgroundColorDisabled)(UIColor *backgroundColorDisabled);

ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ titleFont)(UIFont *titleFont);

ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ contentEdgeInsets)(UIEdgeInsets contentEdgeInsets);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ titleEdgeInsets)(UIEdgeInsets titleEdgeInsets);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ imageEdgeInsets)(UIEdgeInsets imageEdgeInsets);

#pragma mark - # UIControl
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ enabled)(BOOL enabled);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ selected)(BOOL selected);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ highlighted)(BOOL highlighted);

ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ eventBlock)(UIControlEvents controlEvents, void (^eventBlock)(id sender));

ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ contentVerticalAlignment)(UIControlContentVerticalAlignment contentVerticalAlignment);
ZZFLEX_CHAIN_PROPERTY ZZButtonChainModel *(^ contentHorizontalAlignment)(UIControlContentHorizontalAlignment contentHorizontalAlignment);


@end

ZZFLEX_EX_INTERFACE(UIButton, ZZButtonChainModel)
