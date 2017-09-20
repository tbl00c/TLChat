//
//  TLGroupViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTableViewController.h"
#import "TLGroupSearchViewController.h"

@interface TLGroupViewController : TLTableViewController

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) TLGroupSearchViewController *searchVC;

@end
