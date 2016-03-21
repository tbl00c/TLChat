//
//  TLConversationViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTableViewController.h"
#import "TLMessageManager+ConversationRecord.h"
#import "TLFriendSearchViewController.h"

@interface TLConversationViewController : TLTableViewController

@property (nonatomic, strong) TLFriendSearchViewController *searchVC;

@property (nonatomic, strong) NSMutableArray *data;

@end