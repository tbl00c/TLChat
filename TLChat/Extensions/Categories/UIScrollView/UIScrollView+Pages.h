//
//  UIScrollView+Pages.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 14/12/30.
//  Copyright (c) 2014年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Pages)
- (NSInteger)pages;
- (NSInteger)currentPage;
- (CGFloat)scrollPercent;

- (NSInteger)pagesY;
- (NSInteger)pagesX;
- (NSInteger)currentPageY;
- (NSInteger)currentPageX;
- (void) setPageY:(CGFloat)page;
- (void) setPageX:(CGFloat)page;
- (void) setPageY:(CGFloat)page animated:(BOOL)animated;
- (void) setPageX:(CGFloat)page animated:(BOOL)animated;
@end
