//
//  TLContactsSearchViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLContactsSearchViewController.h"
#import "TLContactCell.h"

@interface TLContactsSearchViewController ()

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation TLContactsSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.data = [[NSMutableArray alloc] init];;
    [self.tableView registerClass:[TLContactCell class] forCellReuseIdentifier:@"TLContactCell"];
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.y = HEIGHT_NAVBAR + HEIGHT_STATUSBAR;
    self.tableView.height = HEIGHT_SCREEN - self.tableView.y;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLContactCell"];
    
    TLContact *contact = [self.data objectAtIndex:indexPath.row];
    [cell setContact:contact];
    [cell setTopLineStyle:(indexPath.row == 0 ? TLCellLineStyleFill : TLCellLineStyleNone)];
    [cell setBottomLineStyle:(indexPath.row == self.data.count - 1 ? TLCellLineStyleFill : TLCellLineStyleDefault)];
    return cell;
}

#pragma mark - Delegate -
//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}

//MARK: UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = [searchController.searchBar.text lowercaseString];
    [self.data removeAllObjects];
    for (TLContact *contact in self.contactsData) {
        if ([contact.name containsString:searchText] || [contact.pinyin containsString:searchText] || [contact.pinyinInitial containsString:searchText]) {
            [self.data addObject:contact];
        }
    }
    [self.tableView reloadData];
}

@end