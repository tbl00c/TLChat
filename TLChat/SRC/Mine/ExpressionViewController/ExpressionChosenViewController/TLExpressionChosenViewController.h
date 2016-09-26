//
//  TLExpressionChosenViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTableViewController.h"
#import "TLExpressionHelper.h"

@interface TLExpressionChosenViewController : TLTableViewController
{
    NSInteger kPageIndex;
}

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) NSArray *bannerData;


@end
