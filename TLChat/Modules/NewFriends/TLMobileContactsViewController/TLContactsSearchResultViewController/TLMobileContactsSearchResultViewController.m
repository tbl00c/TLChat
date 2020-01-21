//
//  TLMobileContactsSearchResultViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMobileContactsSearchResultViewController.h"
#import "TLMobileContactsItemCell.h"

@interface TLMobileContactsSearchResultViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZZFLEXAngel *tableViewAngel;

@end

@implementation TLMobileContactsSearchResultViewController

- (void)loadView
{
    [super loadView];
    [self setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.tableView = self.view.addTableView(1)
    .backgroundColor([UIColor colorGrayBG]).separatorStyle(UITableViewCellSeparatorStyleNone)
    .tableFooterView([UIView new])
    .estimatedRowHeight(0).estimatedSectionFooterHeight(0).estimatedSectionHeaderHeight(0)
    .masonry(^ (MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    })
    .view;
    
    self.tableViewAngel = [[ZZFLEXAngel alloc] initWithHostView:self.tableView];
}

- (void)loadListUIWithData:(NSArray *)data
{
    self.tableViewAngel.clear();
    self.tableViewAngel.addSection(0);
    self.tableViewAngel.addCells(@"TLMobileContactsItemCell").toSection(0).withDataModelArray(data).selectedAction(^ (id data) {
 
    });
    [self.tableView reloadData];
}

//MARK: UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = [searchController.searchBar.text lowercaseString];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (TLMobileContactModel *contact in self.contactsData) {
        if ([contact.name containsString:searchText] || [contact.pinyin containsString:searchText] || [contact.pinyinInitial containsString:searchText]) {
            [data addObject:contact];
        }
    }
    [self loadListUIWithData:data];
}

@end
