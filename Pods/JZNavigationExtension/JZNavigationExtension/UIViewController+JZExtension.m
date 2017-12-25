// The MIT License (MIT)
//
// Copyright (c) 2015-present JazysYu ( https://github.com/JazysYu )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

#import "UIViewController+JZExtension.h"
#import "UINavigationController+JZExtension.h"
#import <objc/runtime.h>

@implementation UIViewController (JZExtension)

#pragma mark - # navbar可见
- (void)setJz_wantsNavigationBarVisible:(BOOL)jz_wantsNavigationBarVisible {
    objc_setAssociatedObject(self, @selector(jz_wantsNavigationBarVisible), @(jz_wantsNavigationBarVisible), OBJC_ASSOCIATION_ASSIGN);
    [self.navigationController setNavigationBarHidden:!jz_wantsNavigationBarVisible animated:true];
}
- (BOOL)jz_wantsNavigationBarVisible {
    NSNumber *visableNumber = objc_getAssociatedObject(self, _cmd);
    BOOL visable = visableNumber ? [visableNumber boolValue] : YES;
    return visable;
}

- (BOOL)jz_navigationBarVisableWithNavigationController:(UINavigationController *)navigationController {
    id visableNumber = objc_getAssociatedObject(self, @selector(jz_wantsNavigationBarVisible));
    if (visableNumber) {
        return [visableNumber boolValue];
    }
    
    visableNumber = objc_getAssociatedObject(navigationController, @selector(jz_wantsNavigationBarVisible));
    if (visableNumber) {
        return [visableNumber boolValue];
    }
    
    return !navigationController.isNavigationBarHidden;
}

#pragma mark - # navbar背景透明度
- (void)setJz_navigationBarBackgroundAlpha:(CGFloat)jz_navigationBarBackgroundAlpha {
    [self.navigationController setJz_navigationBarBackgroundAlpha:jz_navigationBarBackgroundAlpha];
    objc_setAssociatedObject(self, @selector(jz_navigationBarBackgroundAlpha), @(jz_navigationBarBackgroundAlpha), OBJC_ASSOCIATION_RETAIN);
}
- (CGFloat)jz_navigationBarBackgroundAlpha {
    NSNumber *alphaNumber = objc_getAssociatedObject(self, _cmd);
    CGFloat alpha = alphaNumber ? [alphaNumber doubleValue] : 1.0;
    return alpha;
}

#pragma mark - # navbar背景色
- (void)setJz_navigationBarTintColor:(UIColor *)jz_navigationBarTintColor {
    [self.navigationController setJz_navigationBarTintColor:jz_navigationBarTintColor];
    objc_setAssociatedObject(self, @selector(jz_navigationBarTintColor), jz_navigationBarTintColor, OBJC_ASSOCIATION_RETAIN);
}
- (UIColor *)jz_navigationBarTintColor {
    UIColor *tintColor = objc_getAssociatedObject(self, _cmd);
    return tintColor;
}

#pragma mark - # navbar背景隐藏
- (void)jz_setNavigationBarBackgroundHidden:(BOOL)jz_navigationBarBackgroundHidden {
    [self setJz_navigationBarBackgroundAlpha:jz_navigationBarBackgroundHidden ? 0.0f : 1.0f];
}
- (BOOL)jz_isNavigationBarBackgroundHidden {
    BOOL hidden = self.jz_navigationBarBackgroundAlpha - 0.0f <= 0.0001;
    return hidden;
}

- (void)jz_setNavigationBarBackgroundHidden:(BOOL)jz_navigationBarBackgroundHidden animated:(BOOL)animated {
    [UIView animateWithDuration:animated ? UINavigationControllerHideShowBarDuration : 0.f animations:^{
        [self jz_setNavigationBarBackgroundHidden:jz_navigationBarBackgroundHidden];
    }];
}

@end

