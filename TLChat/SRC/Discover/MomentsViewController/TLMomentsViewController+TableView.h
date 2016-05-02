//
//  TLMomentsViewController+TableView.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/5.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentsViewController.h"
#import "TLMomentViewDelegate.h"

@interface TLMomentsViewController (TableView) <TLMomentViewDelegate>

- (void)registerCellForTableView:(UITableView *)tableView;

@end
