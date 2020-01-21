//
//  UIScrollView+TLRefreshHeader.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/21.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (TLRefreshHeader)

- (void)tt_addRefreshHeaderWithAction:(void (^)())refreshAction;
- (void)tt_beginRefreshing;
- (void)tt_endRefreshing;
- (void)tt_removeRefreshHeader;

@end
