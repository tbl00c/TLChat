//
//  ZZFlexibleLayoutViewModel+UITableView.m
//  ZZFLEXDemo
//
//  Created by 李伯坤 on 2019/1/20.
//  Copyright © 2019 李伯坤. All rights reserved.
//

#import "ZZFlexibleLayoutViewModel+UITableView.h"
#import "ZZFLEXMacros.h"

@implementation ZZFlexibleLayoutViewModel (UITableView)

- (UITableViewCell *)tableViewCellForPageControler:(id)pageController
                                         tableView:(UITableView *)tableView
                                      sectionCount:(NSInteger)sectionCount
                                         indexPath:(NSIndexPath *)indexPath
{
    UITableViewCell<ZZFlexibleLayoutViewProtocol> *cell;
    if (!self.viewClass) {
        ZZFLEXLog(@"!!!!! tableViewCell不存在，将使用空白Cell：%@", self.className);
        cell = [tableView dequeueReusableCellWithIdentifier:@"ZZFLEXTableViewEmptyCell" forIndexPath:indexPath];
        [cell setTag:self.viewTag];
        return cell;
    }
    
    cell = [tableView dequeueReusableCellWithIdentifier:self.className forIndexPath:indexPath];
    [self excuteConfigActionForPageControler:pageController hostView:tableView itemView:cell sectionCount:sectionCount indexPath:indexPath];
    return cell;
}

- (UITableViewHeaderFooterView *)tableViewHeaderFooterViewForPageControler:(id)pageController
                                                                 tableView:(UITableView *)tableView
                                                                   section:(NSInteger)section
{
    if (!self.viewClass) {
        return nil;
    }
    UITableViewHeaderFooterView<ZZFlexibleLayoutViewProtocol> *view = nil;
    view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:self.className];
    
    if ([view respondsToSelector:@selector(setViewDataModel:)]) {
        [view setViewDataModel:self.dataModel];
    }
    if ([view respondsToSelector:@selector(setViewEventAction:)]) {
        [view setViewEventAction:self.eventAction];
    }
    if ([view respondsToSelector:@selector(setViewDelegate:)]) {
        [view setViewDelegate:self.delegate ? self.delegate : pageController];
    }
    if ([view respondsToSelector:@selector(viewIndexPath:sectionItemCount:)]) {
        [view viewIndexPath:nil sectionItemCount:section];
    }
    [view setTag:self.viewTag];
    [self excuteConfigActionForPageControler:pageController hostView:tableView itemView:view sectionCount:section indexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    return view;
}

@end
