//
//  TLContactsViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTableViewController.h"

@interface TLContactsViewController : TLTableViewController

@property (nonatomic, strong) NSArray *data;

+ (void)tryToGetAllContactsSuccess:(void (^)(NSArray *data))success
                            failed:(void (^)())failed;

@end
