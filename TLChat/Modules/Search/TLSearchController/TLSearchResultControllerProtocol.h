//
//  TLSearchResultControllerProtocol.h
//  TLChat
//
//  Created by 李伯坤 on 2018/1/4.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIViewController;
@protocol TLSearchResultControllerProtocol <UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate>

- (void)setItemClickAction:(void (^)(__kindof UIViewController *searchResultVC, id data))itemClickAction;

@end
