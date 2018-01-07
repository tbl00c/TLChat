//
//  TLFriendSearchViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/25.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTableViewController.h"
#import "TLSearchControllerProtocol.h"

#define     HEIGHT_FRIEND_CELL      54.0f

@class TLUser;
@interface TLFriendSearchViewController : TLTableViewController <TLSearchControllerProtocol>

@property (nonatomic, copy) void (^itemSelectedAction)(TLFriendSearchViewController *searchVC, TLUser *userModel);

@end
