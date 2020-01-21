//
//  TLNewFriendViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLNewFriendViewController.h"
#import "TLFriendFindViewController.h"
#import "TLSearchController.h"
#import "TLAddContactsViewController.h"
#import "TLMobileContactsViewController.h"
#import "TLNewFriendFuncationCell.h"

typedef NS_ENUM(NSInteger, TLNewFriendVCSectionType) {
    TLNewFriendVCSectionTypeFuncation = -1,
};

@interface TLNewFriendViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZZFLEXAngel *tableViewAngel;

@property (nonatomic, strong) TLSearchController *searchController;

@end

@implementation TLNewFriendViewController

- (void)loadView
{
    [super loadView];
    
    [self p_loadUI];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadListUIWithData:nil];
}

- (void)loadListUIWithData:(NSArray *)data
{
    @weakify(self);
    self.tableViewAngel.clear();
    
    self.tableViewAngel.addSection(TLNewFriendVCSectionTypeFuncation);
    TLNewFriendFuncationModel *model = createNewFriendFuncationModel(@"newFriend_contacts", LOCSTR(@"添加手机联系人"));
    self.tableViewAngel.addCell(@"TLNewFriendFuncationCell").toSection(TLNewFriendVCSectionTypeFuncation).withDataModel(model).selectedAction(^(id data){
        TLMobileContactsViewController *contactsVC = [[TLMobileContactsViewController alloc] init];
        PushVC(contactsVC);
    });
    
    [self.tableView reloadData];
}

#pragma mark - # Private Methods
- (void)p_loadUI
{
    [self setTitle:LOCSTR(@"新的朋友")];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    @weakify(self);
    [self addRightBarButtonWithTitle:LOCSTR(@"添加朋友") actionBlick:^{
        @strongify(self);
        TLAddContactsViewController *addFriendVC = [[TLAddContactsViewController alloc] init];
        PushVC(addFriendVC);
    }];
    
    self.tableView = self.view.addTableView(1)
    .backgroundColor([UIColor whiteColor]).separatorStyle(UITableViewCellSeparatorStyleNone)
    .tableHeaderView(self.searchController.searchBar).tableFooterView([UIView new])
    .masonry(^ (MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    })
    .view;
    
    self.tableViewAngel = [[ZZFLEXAngel alloc] initWithHostView:self.tableView];
}

#pragma mark - # Getters
- (TLSearchController *)searchController
{
    if (_searchController == nil) {
        TLFriendFindViewController *searchResultVC = [[TLFriendFindViewController alloc] init];
        _searchController = [[TLSearchController alloc] initWithSearchResultsController:searchResultVC];
        [_searchController.searchBar setPlaceholder:LOCSTR(@"微信号/手机号")];
    }
    return _searchController;
}

@end
