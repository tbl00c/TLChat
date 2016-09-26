//
//  TLMomentsViewController+Proxy.m
//  TLChat
//
//  Created by libokun on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentsViewController+Proxy.h"
#import "TLMomentsProxy.h"

@implementation TLMomentsViewController (Proxy)

- (void)loadData
{
    TLMomentsProxy *proxy = [[TLMomentsProxy alloc] init];
    self.data = [NSMutableArray arrayWithArray:proxy.testData];
    [self.tableView reloadData];
}

@end
