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

@interface UIViewController (JZExtension)

/// navbar可见
@property (nonatomic, assign) IBInspectable BOOL jz_wantsNavigationBarVisible;
/// navbar背景透明度
@property (nonatomic, assign) IBInspectable CGFloat jz_navigationBarBackgroundAlpha;
/// navbar背景色
@property (nonatomic, strong) IBInspectable UIColor *jz_navigationBarTintColor;

/// navbar背景隐藏
@property (nonatomic, assign, getter=jz_isNavigationBarBackgroundHidden, setter=jz_setNavigationBarBackgroundHidden:) IBInspectable BOOL jz_navigationBarBackgroundHidden;
- (void)jz_setNavigationBarBackgroundHidden:(BOOL)jz_navigationBarBackgroundHidden animated:(BOOL)animated NS_AVAILABLE_IOS(8_0);


- (BOOL)jz_navigationBarVisableWithNavigationController:(UINavigationController *)navigationController;

@end

