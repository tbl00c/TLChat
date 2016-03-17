//
//  TLGroupSearchViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLGroupSearchViewController.h"
#import "TLGroupCell.h"

@interface TLGroupSearchViewController ()

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation TLGroupSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.data = [[NSMutableArray alloc] init];;
    [self.tableView registerClass:[TLGroupCell class] forCellReuseIdentifier:@"TLGroupCell"];
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
    TLGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLGroupCell"];
    
    TLGroup *group = [self.data objectAtIndex:indexPath.row];
    [cell setGroup:group];
    return cell;
}

#pragma mark - Delegate -
//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
}

//MARK: UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = [searchController.searchBar.text lowercaseString];
    [self.data removeAllObjects];
    for (TLGroup *group in self.groupData) {
        if ([group.groupName containsString:searchText] || [group.pinyin containsString:searchText] || [group.pinyinInitial containsString:searchText]) {
            [self.data addObject:group];
        }
    }
    [self.tableView reloadData];
}

@end