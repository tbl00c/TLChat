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

#import <UIKit/UIKit.h>

typedef void(^_jz_navigation_block_t)(UINavigationController *navigationController, BOOL finished);

@interface UINavigationController (JZExtension)

@property (nonatomic, assign) BOOL jz_isPushing;

/// 全屏POP手势
@property (nonatomic, assign) BOOL jz_fullScreenInteractivePopGestureEnabled;

@property (nonatomic, weak, readonly) UIViewController *jz_previousVisibleViewController;

@property (nonatomic, assign, readwrite) CGSize jz_navigationBarSize;

@property (nonatomic, copy) _jz_navigation_block_t jz_navigationTransitionCompletion;
@property (nonatomic, copy, setter=jz_setInteractivePopGestureRecognizerCompletion:) _jz_navigation_block_t jz_interactivePopGestureRecognizerCompletion;

/// push
- (void)jz_pushViewController:(UIViewController *)viewController
                     animated:(BOOL)animated
                   completion:(void (^)(UINavigationController *navigationController, BOOL finished))completion;

/// pop
- (UIViewController *)jz_popViewControllerAnimated:(BOOL)animated
                                        completion:(void (^)(UINavigationController *navigationController, BOOL finished))completion;
/// pop to root
- (NSArray *)jz_popToRootViewControllerAnimated:(BOOL)animated
                                     completion:(void (^)(UINavigationController *navigationController, BOOL finished))completion;
/// pop to vc
- (NSArray *)jz_popToViewController:(UIViewController *)viewController
                           animated:(BOOL)animated
                         completion:(void (^)(UINavigationController *navigationController, BOOL finished))completion;

/// setVC
- (void)jz_setViewControllers:(NSArray<UIViewController *> *)viewControllers
                     animated:(BOOL)animated completion:(void (^)(UINavigationController *navigationController, BOOL finished))completion;

@end
