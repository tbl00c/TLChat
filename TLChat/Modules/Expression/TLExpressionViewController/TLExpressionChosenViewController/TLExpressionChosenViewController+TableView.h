//
//  TLExpressionChosenViewController+TableView.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionChosenViewController.h"
#import "TLExpressionBannerCell.h"
#import "TLExpressionCell.h"

#define         HEIGHT_BANNERCELL       140.0f
#define         HEGIHT_EXPCELL          80.0f

@interface TLExpressionChosenViewController (TableView) <TLExpressionCellDelegate, TLExpressionBannerCellDelegate>

- (void)registerCellsForTableView:(UITableView *)tableView;

@end
