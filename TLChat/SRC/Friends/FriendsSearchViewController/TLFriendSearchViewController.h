//
//  TLFriendSearchViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/25.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTableViewController.h"

@interface TLFriendSearchViewController : TLTableViewController <UISearchResultsUpdating>

@property (nonatomic, strong) NSMutableArray *friendsData;

@end
