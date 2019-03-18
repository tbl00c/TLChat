//
//  ZZTextViewChainModel.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2018/1/24.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "ZZBaseViewChainModel.h"

@class ZZTextViewChainModel;
@interface ZZTextViewChainModel : ZZBaseViewChainModel <ZZTextViewChainModel *>

ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ delegate)(id<UITextViewDelegate> delegate);

ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ text)(NSString *text);
ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ font)(UIFont *font);
ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ textColor)(UIColor *textColor);

ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ textAlignment)(NSTextAlignment textAlignment);
ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ selectedRange)(NSRange numberOfLines);
ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ editable)(BOOL editable);
ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ selectable)(BOOL selectable);
ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ dataDetectorTypes)(UIDataDetectorTypes dataDetectorTypes);

ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ keyboardType)(UIKeyboardType keyboardType);

ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ allowsEditingTextAttributes)(BOOL allowsEditingTextAttributes);
ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ attributedText)(NSAttributedString *attributedText);
ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ typingAttributes)(NSDictionary *typingAttributes);

ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ clearsOnInsertion)(BOOL clearsOnInsertion);

ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ textContainerInset)(UIEdgeInsets textContainerInset);
ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ linkTextAttributes)(NSDictionary *linkTextAttributes);

#pragma mark - UIScrollView
ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ contentSize)(CGSize contentSize);
ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ contentOffset)(CGPoint contentOffset);
ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ contentInset)(UIEdgeInsets contentInset);

ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ bounces)(BOOL bounces);
ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ alwaysBounceVertical)(BOOL alwaysBounceVertical);
ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ alwaysBounceHorizontal)(BOOL alwaysBounceHorizontal);

ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ pagingEnabled)(BOOL pagingEnabled);
ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ scrollEnabled)(BOOL scrollEnabled);

ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ showsHorizontalScrollIndicator)(BOOL showsHorizontalScrollIndicator);
ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ showsVerticalScrollIndicator)(BOOL showsVerticalScrollIndicator);

ZZFLEX_CHAIN_PROPERTY ZZTextViewChainModel *(^ scrollsToTop)(BOOL scrollsToTop);

@end

ZZFLEX_EX_INTERFACE(UITextView, ZZTextViewChainModel)
