//
//  ZZButtonChainModel.m
//  zhuanzhuan
//
//  Created by lbk on 2017/10/24.
//  Copyright © 2017年 zz. All rights reserved.
//

#import "ZZButtonChainModel.h"
#import "UIControl+ZZEvent.h"
#import "UIButton+ZZExtension.h"

#define     ZZFLEX_CHAIN_BUTTON_IMPLEMENTATION(methodName, ZZParamType)      ZZFLEX_CHAIN_IMPLEMENTATION(methodName, ZZParamType, ZZButtonChainModel *, UIButton)

#define     ZZFLEX_CHAIN_BUTTON_STATE_IMPLEMENTATION(methodName, ZZParamType, Code, State)    \
- (ZZButtonChainModel *(^)(ZZParamType param))methodName   \
{   \
    return ^ZZButtonChainModel *(ZZParamType param) {     \
        [(UIButton *)self.view Code:param forState:State];      \
        return self;        \
    };      \
}       \

#define     ZZFLEX_CHAIN_BUTTON_TITLE_IMPLEMENTATION(methodName, State)             ZZFLEX_CHAIN_BUTTON_STATE_IMPLEMENTATION(methodName, NSString *, setTitle, State)
#define     ZZFLEX_CHAIN_BUTTON_TITLECOLOR_IMPLEMENTATION(methodName, State)        ZZFLEX_CHAIN_BUTTON_STATE_IMPLEMENTATION(methodName, UIColor *, setTitleColor, State)
#define     ZZFLEX_CHAIN_BUTTON_SHADOW_IMPLEMENTATION(methodName, State)            ZZFLEX_CHAIN_BUTTON_STATE_IMPLEMENTATION(methodName, UIColor *, setTitleShadowColor, State)
#define     ZZFLEX_CHAIN_BUTTON_IMAGE_IMPLEMENTATION(methodName, State)             ZZFLEX_CHAIN_BUTTON_STATE_IMPLEMENTATION(methodName, UIImage *, setImage, State)
#define     ZZFLEX_CHAIN_BUTTON_BGIMAGE_IMPLEMENTATION(methodName, State)           ZZFLEX_CHAIN_BUTTON_STATE_IMPLEMENTATION(methodName, UIImage *, setBackgroundImage, State)
#define     ZZFLEX_CHAIN_BUTTON_ATTRTITLE_IMPLEMENTATION(methodName, State)         ZZFLEX_CHAIN_BUTTON_STATE_IMPLEMENTATION(methodName, NSAttributedString *, setAttributedTitle, State)
#define     ZZFLEX_CHAIN_BUTTON_BGCOLOR_IMPLEMENTATION(methodName, State)           ZZFLEX_CHAIN_BUTTON_STATE_IMPLEMENTATION(methodName, UIColor *, setBackgroundColor, State)

@implementation ZZButtonChainModel

ZZFLEX_CHAIN_BUTTON_TITLE_IMPLEMENTATION(title, UIControlStateNormal);
ZZFLEX_CHAIN_BUTTON_TITLE_IMPLEMENTATION(titleHL, UIControlStateHighlighted);
ZZFLEX_CHAIN_BUTTON_TITLE_IMPLEMENTATION(titleSelected, UIControlStateSelected);
ZZFLEX_CHAIN_BUTTON_TITLE_IMPLEMENTATION(titleDisabled, UIControlStateDisabled);

ZZFLEX_CHAIN_BUTTON_TITLECOLOR_IMPLEMENTATION(titleColor, UIControlStateNormal);
ZZFLEX_CHAIN_BUTTON_TITLECOLOR_IMPLEMENTATION(titleColorHL, UIControlStateHighlighted);
ZZFLEX_CHAIN_BUTTON_TITLECOLOR_IMPLEMENTATION(titleColorSelected, UIControlStateSelected);
ZZFLEX_CHAIN_BUTTON_TITLECOLOR_IMPLEMENTATION(titleColorDisabled, UIControlStateDisabled);

ZZFLEX_CHAIN_BUTTON_SHADOW_IMPLEMENTATION(titleShadowColor, UIControlStateNormal);
ZZFLEX_CHAIN_BUTTON_SHADOW_IMPLEMENTATION(titleShadowColorHL, UIControlStateHighlighted);
ZZFLEX_CHAIN_BUTTON_SHADOW_IMPLEMENTATION(titleShadowColorSelected, UIControlStateSelected);
ZZFLEX_CHAIN_BUTTON_SHADOW_IMPLEMENTATION(titleShadowColorDisabled, UIControlStateDisabled);

ZZFLEX_CHAIN_BUTTON_IMAGE_IMPLEMENTATION(image, UIControlStateNormal);
ZZFLEX_CHAIN_BUTTON_IMAGE_IMPLEMENTATION(imageHL, UIControlStateHighlighted);
ZZFLEX_CHAIN_BUTTON_IMAGE_IMPLEMENTATION(imageSelected, UIControlStateSelected);
ZZFLEX_CHAIN_BUTTON_IMAGE_IMPLEMENTATION(imageDisabled, UIControlStateDisabled);

ZZFLEX_CHAIN_BUTTON_BGIMAGE_IMPLEMENTATION(backgroundImage, UIControlStateNormal);
ZZFLEX_CHAIN_BUTTON_BGIMAGE_IMPLEMENTATION(backgroundImageHL, UIControlStateHighlighted);
ZZFLEX_CHAIN_BUTTON_BGIMAGE_IMPLEMENTATION(backgroundImageSelected, UIControlStateSelected);
ZZFLEX_CHAIN_BUTTON_BGIMAGE_IMPLEMENTATION(backgroundImageDisabled, UIControlStateDisabled);

ZZFLEX_CHAIN_BUTTON_ATTRTITLE_IMPLEMENTATION(attributedTitle, UIControlStateNormal);
ZZFLEX_CHAIN_BUTTON_ATTRTITLE_IMPLEMENTATION(attributedTitleHL, UIControlStateHighlighted);
ZZFLEX_CHAIN_BUTTON_ATTRTITLE_IMPLEMENTATION(attributedTitleSelected, UIControlStateSelected);
ZZFLEX_CHAIN_BUTTON_ATTRTITLE_IMPLEMENTATION(attributedTitleDisabled, UIControlStateDisabled);

ZZFLEX_CHAIN_BUTTON_BGCOLOR_IMPLEMENTATION(backgroundColorHL, UIControlStateHighlighted);
ZZFLEX_CHAIN_BUTTON_BGCOLOR_IMPLEMENTATION(backgroundColorSelected, UIControlStateSelected);
ZZFLEX_CHAIN_BUTTON_BGCOLOR_IMPLEMENTATION(backgroundColorDisabled, UIControlStateDisabled);

- (ZZButtonChainModel *(^)(UIFont *titleFont))titleFont
{
    return ^ZZButtonChainModel *(UIFont *titleFont) {
        ((UIButton *)self.view).titleLabel.font = titleFont;
        return self;
    };
}

ZZFLEX_CHAIN_BUTTON_IMPLEMENTATION(contentEdgeInsets, UIEdgeInsets);
ZZFLEX_CHAIN_BUTTON_IMPLEMENTATION(titleEdgeInsets, UIEdgeInsets);
ZZFLEX_CHAIN_BUTTON_IMPLEMENTATION(imageEdgeInsets, UIEdgeInsets);


#pragma mark - # UIControl
ZZFLEX_CHAIN_BUTTON_IMPLEMENTATION(enabled, BOOL);
ZZFLEX_CHAIN_BUTTON_IMPLEMENTATION(selected, BOOL);
ZZFLEX_CHAIN_BUTTON_IMPLEMENTATION(highlighted, BOOL);

- (ZZButtonChainModel *(^)(UIControlEvents controlEvents, void (^eventBlock)(id sender)))eventBlock
{
    return ^ZZButtonChainModel *(UIControlEvents controlEvents, void (^eventBlock)(id sender)) {
        [(UIControl *)self.view addControlEvents:controlEvents handler:eventBlock];
        return self;
    };
}

ZZFLEX_CHAIN_BUTTON_IMPLEMENTATION(contentVerticalAlignment, UIControlContentVerticalAlignment);
ZZFLEX_CHAIN_BUTTON_IMPLEMENTATION(contentHorizontalAlignment, UIControlContentHorizontalAlignment);

@end

ZZFLEX_EX_IMPLEMENTATION(UIButton, ZZButtonChainModel)
