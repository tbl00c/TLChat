//
//  UIView+TipView.h
//  Pods
//
//  Created by 李伯坤 on 2017/8/30.
//
//

#import <UIKit/UIKit.h>

@interface UIView (TipView)

@property (nonatomic, strong, readonly) UIView *tt_tipView;

- (void)showTipView:(UIView *)tipView retryAction:(void (^)(id userData))retryAction;

- (void)showTipView:(UIView *)tipView userData:(id)userData retryAction:(void (^)(id userData))retryAction;

- (void)removeTipView;

@end
