//
//  ZZTextFieldChainModel.m
//  ZZFLEXDemo
//
//  Created by lbk on 2017/12/9.
//  Copyright © 2017年 lbk. All rights reserved.
//

#import "ZZTextFieldChainModel.h"
#import "UIControl+ZZEvent.h"

#define     ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(methodName, ZZParamType)      ZZFLEX_CHAIN_IMPLEMENTATION(methodName, ZZParamType, ZZTextFieldChainModel *, UITextField)
@implementation ZZTextFieldChainModel

ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(text, NSString *);
ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(attributedText, NSAttributedString *);

ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(font, UIFont *);
ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(textColor, UIColor *);

ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(textAlignment, NSTextAlignment);
ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(borderStyle, UITextBorderStyle);

ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(defaultTextAttributes, NSDictionary *);

ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(placeholder, NSString *);
ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(attributedPlaceholder, NSAttributedString *);

ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(keyboardType, UIKeyboardType);

ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(clearsOnBeginEditing, BOOL);
ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(adjustsFontSizeToFitWidth, BOOL);
ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(minimumFontSize, CGFloat);

ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(delegate, id<UITextFieldDelegate>);

ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(background, UIImage *);
ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(disabledBackground, UIImage *);

ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(allowsEditingTextAttributes, BOOL);
ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(typingAttributes, NSDictionary *);

ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(clearButtonMode, UITextFieldViewMode);
ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(leftView, UIView *);
ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(leftViewMode, UITextFieldViewMode);
ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(rightView, UIView *);
ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(rightViewMode, UITextFieldViewMode);

ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(inputView, UIView *);
ZZFLEX_CHAIN_TEXTFIELD_IMPLEMENTATION(inputAccessoryView, UIView *);

- (ZZTextFieldChainModel *(^)(UIControlEvents controlEvents, void (^eventBlock)(id sender)))eventBlock
{
    return ^ZZTextFieldChainModel *(UIControlEvents controlEvents, void (^eventBlock)(id sender)) {
        [(UIControl *)self.view addControlEvents:controlEvents handler:eventBlock];
        return self;
    };
}

@end

ZZFLEX_EX_IMPLEMENTATION(UITextField, ZZTextFieldChainModel)
