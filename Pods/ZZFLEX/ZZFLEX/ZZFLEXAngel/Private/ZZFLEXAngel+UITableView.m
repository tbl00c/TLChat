//
//  ZZFLEXAngel+UITableView.m
//  ZZFLEXDemo
//
//  Created by lbk on 2017/12/18.
//  Copyright © 2017年 lbk. All rights reserved.
//

#import "ZZFLEXAngel+UITableView.h"
#import "ZZFLEXAngel+Private.h"
#import "ZZFlexibleLayoutViewModel+UITableView.h"
#import "ZZFlexibleLayoutSectionModel.h"
#import "ZZFlexibleLayoutViewProtocol.h"
#import "ZZFLEXTableViewEmptyCell.h"
#import "ZZFLEXMacros.h"

@implementation ZZFLEXAngel (UITableView)

//MARK: UICollectionViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    return [sectionModel count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:indexPath.section];
    ZZFlexibleLayoutViewModel *viewModel = [sectionModel objectAtIndex:indexPath.row];
    UITableViewCell *cell = [viewModel tableViewCellForPageControler:self tableView:tableView sectionCount:sectionModel.count indexPath:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    ZZFlexibleLayoutViewModel *viewModel = sectionModel.headerViewModel;
    UITableViewHeaderFooterView *view = [viewModel tableViewHeaderFooterViewForPageControler:self tableView:tableView section:section];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    ZZFlexibleLayoutViewModel *viewModel = sectionModel.footerViewModel;
    UITableViewHeaderFooterView *view = [viewModel tableViewHeaderFooterViewForPageControler:self tableView:tableView section:section];
    return view;
}
//MARK: UICollectionViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    ZZFlexibleLayoutViewModel *viewModel = [self viewModelAtIndexPath:indexPath];
    [viewModel excuteSelectedActionForHostView:tableView];
}

//MARK: ZZFlexibleLayoutFlowLayoutDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZZFlexibleLayoutViewModel *model = [self viewModelAtIndexPath:indexPath];
    CGFloat height = [model visableSizeForHostView:tableView].height;
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    ZZFlexibleLayoutViewModel *model = sectionModel.headerViewModel;
    CGFloat height = [model visableSizeForHostView:tableView].height;
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    ZZFlexibleLayoutSectionModel *sectionModel = [self sectionModelAtIndex:section];
    ZZFlexibleLayoutViewModel *model = sectionModel.footerViewModel;
    CGFloat height = [model visableSizeForHostView:tableView].height;
    return height;
}

@end
