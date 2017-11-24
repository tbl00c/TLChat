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

#import "UINavigationController+JZExtension.h"
#import "UIViewController+JZExtension.h"
#import "UINavigationBar+JZPrivate.h"
#import <objc/runtime.h>
#import "_JZValue.h"

@implementation UINavigationController (JZExtension)

#pragma mark - # 正在Push
- (void)setJz_isPushing:(BOOL)jz_isPushing {
    objc_setAssociatedObject(self, @selector(jz_isPushing), @(jz_isPushing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)jz_isPushing {
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    return [number boolValue];
}

#pragma mark - # 全屏手势返回
- (void)setJz_fullScreenInteractivePopGestureEnabled:(BOOL)jz_fullScreenInteractivePopGestureEnabled {
    object_setClass(self.interactivePopGestureRecognizer, jz_fullScreenInteractivePopGestureEnabled ? [UIPanGestureRecognizer class] : [UIScreenEdgePanGestureRecognizer class]);
}
- (BOOL)jz_fullScreenInteractivePopGestureEnabled {
    return [self.interactivePopGestureRecognizer isMemberOfClass:[UIPanGestureRecognizer class]];
}

#pragma mark - # NavbarSize
- (void)setJz_navigationBarSize:(CGSize)jz_navigationBarSize {
    [self.navigationBar setJz_size:jz_navigationBarSize];
}
- (CGSize)jz_navigationBarSize {
    return [self.navigationBar jz_size];
}

#pragma mark - # 导航栏背景色
- (void)setJz_navigationBarTintColor:(UIColor *)jz_navigationBarTintColor {
    self.navigationBar.jz_barTintColor = jz_navigationBarTintColor;
}
- (UIColor *)jz_navigationBarTintColor {
    return self.navigationBar.jz_barTintColor;
}

#pragma mark - # 导航栏背景alpha
- (void)setJz_navigationBarBackgroundAlpha:(CGFloat)jz_navigationBarBackgroundAlpha {
    [self.navigationBar setJz_alpha:jz_navigationBarBackgroundAlpha];
    if (fabs(jz_navigationBarBackgroundAlpha - 0) <= 0.001) {
        [self.navigationBar setShadowImage:[UIImage new]];
    }
}
- (CGFloat)jz_navigationBarBackgroundAlpha {
    return self.navigationBar.jz_alpha;
}

#pragma mark - # previousVisableVC
- (void)setJz_previousVisibleViewController:(UIViewController * _Nullable)jz_previousVisibleViewController {
    objc_setAssociatedObject(self, @selector(jz_previousVisibleViewController), jz_previousVisibleViewController ? [_JZValue valueWithWeakObject:jz_previousVisibleViewController] : nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIViewController *)jz_previousVisibleViewController {
    id _previousVisibleViewController = [objc_getAssociatedObject(self, _cmd) weakObjectValue];
    if (!_previousVisibleViewController) {
        _previousVisibleViewController = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        self.jz_previousVisibleViewController = _previousVisibleViewController;
    }
    return _previousVisibleViewController;
}

#pragma mark - # Push Pop
- (void)jz_pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(_jz_navigation_block_t)completion {
    self.jz_navigationTransitionCompletion = completion;
    [self pushViewController:viewController animated:animated];
}

- (UIViewController *)jz_popViewControllerAnimated:(BOOL)animated completion:(_jz_navigation_block_t)completion {
    self.jz_navigationTransitionCompletion = completion;
    return [self popViewControllerAnimated:animated];
}

- (NSArray *)jz_popToViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(_jz_navigation_block_t)completion {
    self.jz_navigationTransitionCompletion = completion;
    return [self popToViewController:viewController animated:animated];
}

- (NSArray *)jz_popToRootViewControllerAnimated:(BOOL)animated completion:(_jz_navigation_block_t)completion {
    self.jz_navigationTransitionCompletion = completion;
    return [self popToRootViewControllerAnimated:animated];
}

- (void)jz_setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated completion:(_jz_navigation_block_t)completion {
    self.jz_navigationTransitionCompletion = completion;
    [self setViewControllers:viewControllers animated:animated];
}

#pragma mark - # Property
- (void)setJz_navigationTransitionCompletion:(_jz_navigation_block_t)jz_navigationTransitionCompletion {
    objc_setAssociatedObject(self, @selector(jz_navigationTransitionCompletion), jz_navigationTransitionCompletion, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (_jz_navigation_block_t)jz_navigationTransitionCompletion {
    return objc_getAssociatedObject(self, _cmd);
}

#pragma mark - # Gesture
- (void)jz_setInteractivePopGestureRecognizerCompletion:(_jz_navigation_block_t)jz_interactivePopGestureRecognizerCompletion {
    objc_setAssociatedObject(self, @selector(jz_interactivePopGestureRecognizerCompletion), jz_interactivePopGestureRecognizerCompletion, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (_jz_navigation_block_t)jz_interactivePopGestureRecognizerCompletion {
    return objc_getAssociatedObject(self, _cmd);
}

@end
