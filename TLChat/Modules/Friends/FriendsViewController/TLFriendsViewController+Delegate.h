//
//  TLFriendsViewController+Delegate.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendsViewController.h"

#define     HEIGHT_FRIEND_CELL      54.0f
#define     HEIGHT_HEADER           22.0f

@interface TLFriendsViewController (Delegate) <UISearchBarDelegate>

- (void)registerCellClass;

@end
