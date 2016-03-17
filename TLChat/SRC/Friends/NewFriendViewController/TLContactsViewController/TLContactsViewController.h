//
//  TLContactsViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTableViewController.h"
#import "TLContactsSearchViewController.h"

@interface TLContactsViewController : TLTableViewController

/// 通讯录好友（初始数据）
@property (nonatomic, strong) NSArray *contactsData;

/// 通讯录好友（格式化的列表数据）
@property (nonatomic, strong) NSArray *data;

/// 通讯录好友索引
@property (nonatomic, strong) NSArray *headers;

@property (nonatomic, strong) TLContactsSearchViewController *searchVC;

@end
