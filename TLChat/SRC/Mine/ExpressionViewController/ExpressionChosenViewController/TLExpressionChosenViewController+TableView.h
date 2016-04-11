//
//  TLExpressionChosenViewController+TableView.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionChosenViewController.h"
#import "TLExpressionCell.h"

#define         HEGIHT_EXPCELL      80

@interface TLExpressionChosenViewController (TableView) <TLExpressionCellDelegate>

- (void)registerCellsForTableView:(UITableView *)tableView;

@end
