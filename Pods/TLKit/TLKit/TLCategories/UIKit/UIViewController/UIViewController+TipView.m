//
//  UIViewController+TipView.m
//  Pods
//
//  Created by 李伯坤 on 2017/8/30.
//
//

#import "UIViewController+TipView.h"
#import "UIView+TipView.h"

@implementation UIViewController (TipView)

- (void)showTipView:(UIView *)tipView retryAction:(void (^)(id userData))retryAction
{
    [self showTipView:tipView userData:nil retryAction:retryAction];
}

- (void)showTipView:(UIView *)tipView userData:(id)userData retryAction:(void (^)(id userData))retryAction
{
    [self.view showTipView:tipView userData:userData retryAction:retryAction];
}

- (void)removeTipView
{
    [self.view removeTipView];
}

- (UIView *)tt_tipView
{
    return self.view.tt_tipView;
}

@end
