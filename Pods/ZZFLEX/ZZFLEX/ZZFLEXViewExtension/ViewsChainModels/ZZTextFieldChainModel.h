//
//  ZZTextFieldChainModel.h
//  ZZFLEXDemo
//
//  Created by lbk on 2017/12/9.
//  Copyright © 2017年 lbk. All rights reserved.
//

#import "ZZBaseViewChainModel.h"

@class ZZTextFieldChainModel;
@interface ZZTextFieldChainModel : ZZBaseViewChainModel <ZZTextFieldChainModel *>

ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ text)(NSString *text);
ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ attributedText)(NSAttributedString *attributedText);

ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ font)(UIFont *font);
ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ textColor)(UIColor *textColor);

ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ textAlignment)(NSTextAlignment textAlignment);
ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ borderStyle)(UITextBorderStyle borderStyle);

ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ defaultTextAttributes)(NSDictionary *defaultTextAttributes);

ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ placeholder)(NSString *placeholder);
ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ attributedPlaceholder)(NSAttributedString *attributedPlaceholder);

ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ keyboardType)(UIKeyboardType keyboardType);

ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ clearsOnBeginEditing)(BOOL clearsOnBeginEditing);
ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ adjustsFontSizeToFitWidth)(BOOL adjustsFontSizeToFitWidth);
ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ minimumFontSize)(CGFloat minimumFontSize);

ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ delegate)(id<UITextFieldDelegate> delegate);

ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ background)(UIImage *background);
ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ disabledBackground)(UIImage *disabledBackground);

ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ allowsEditingTextAttributes)(BOOL allowsEditingTextAttributes);
ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ typingAttributes)(NSDictionary *typingAttributes);

ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ clearButtonMode)(UITextFieldViewMode clearButtonMode);
ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ leftView)(UIView *leftView);
ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ leftViewMode)(UITextFieldViewMode leftViewMode);
ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ rightView)(UIView *rightView);
ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ rightViewMode)(UITextFieldViewMode rightViewMode);

ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ inputView)(UIView *inputView);
ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ inputAccessoryView)(UIView *inputAccessoryView);

ZZFLEX_CHAIN_PROPERTY ZZTextFieldChainModel *(^ eventBlock)(UIControlEvents controlEvents, void (^eventBlock)(id sender));

@end

ZZFLEX_EX_INTERFACE(UITextField, ZZTextFieldChainModel)
