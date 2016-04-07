//
//  TLMomentsViewController+Proxy.m
//  TLChat
//
//  Created by libokun on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentsViewController+Proxy.h"

@implementation TLMomentsViewController (Proxy)

- (void)loadData
{
    self.data = [NSMutableArray arrayWithArray:self.proxy.testData];
    [self.tableView reloadData];
}

@end
