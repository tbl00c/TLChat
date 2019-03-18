//
//  ZZFlexibleLayoutViewModel+UITableView.h
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2019/1/20.
//  Copyright © 2019 李伯坤. All rights reserved.
//

#import "ZZFlexibleLayoutViewModel+HostView.h"

@interface ZZFlexibleLayoutViewModel (UITableView)

- (UITableViewCell *)tableViewCellForPageControler:(id)pageController
                                         tableView:(UITableView *)tableView
                                      sectionCount:(NSInteger)sectionCount
                                         indexPath:(NSIndexPath *)indexPath;

- (UITableViewHeaderFooterView *)tableViewHeaderFooterViewForPageControler:(id)pageController
                                                                 tableView:(UITableView *)tableView
                                                                   section:(NSInteger)section;

@end
