//
//  TLFriendsViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTableViewController.h"
#import "TLFriendSearchViewController.h"

@interface TLFriendsViewController : TLTableViewController

@property (nonatomic, weak) NSMutableArray *data;

@property (nonatomic, weak) NSMutableArray *sectionHeaders;

@property (nonatomic, strong) TLFriendSearchViewController *searchVC;

@end
