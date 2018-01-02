//
//  TLExpressionChosenViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLViewController.h"

@interface TLExpressionChosenViewController : TLViewController
{
    NSInteger kPageIndex;
}

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) NSArray *bannerData;

@property (nonatomic, strong) UITableView *tableView;


@end
