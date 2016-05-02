//
//  TLFriendDetailViewController+Delegate.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendDetailViewController.h"
#import "TLFriendDetailUserCell.h"

#define     HEIGHT_USER_CELL           90.0f
#define     HEIGHT_ALBUM_CELL          80.0f

@interface TLFriendDetailViewController (Delegate) <TLFriendDetailUserCellDelegate>

- (void)registerCellClass;

@end
