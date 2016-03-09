//
//  TLChatTableView.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/9.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatTableView.h"

@implementation TLChatTableView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self setBackgroundColor:[UIColor colorChatTableViewBG]];
        [self setTableFooterView:[[UIView alloc] init]];
    }
    return self;
}

@end
