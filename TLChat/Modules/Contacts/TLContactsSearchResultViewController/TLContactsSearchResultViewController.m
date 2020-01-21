//
//  TLContactsSearchResultViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/25.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLContactsSearchResultViewController.h"
#import "TLContactsItemCell.h"
#import "TLFriendHelper.h"

@interface TLContactsSearchResultViewController ()

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZZFLEXAngel *tableViewAngel;

@property (nonatomic, strong) NSMutableArray *friendsData;

@end

@implementation TLContactsSearchResultViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.friendsData = [TLFriendHelper sharedFriendHelper].friendsData;
}

//MARK: UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    TLContactsItemModel *(^createContactsItemModelWithUserModel)(TLUser *userModel) = ^TLContactsItemModel *(TLUser *userModel){
        TLContactsItemModel *model = createContactsItemModel(userModel.avatarPath, userModel.avatarURL, userModel.showName, userModel.detailInfo.remarkInfo, userModel);
        return model;
    };
    
    // 查找数据
    NSString *searchText = [searchController.searchBar.text lowercaseString];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (TLUser *user in self.friendsData) {
        if ([user.remarkName containsString:searchText] || [user.username containsString:searchText] || [user.nikeName containsString:searchText] || [user.pinyin containsString:searchText] || [user.pinyinInitial containsString:searchText]) {
            TLContactsItemModel *model = createContactsItemModelWithUserModel(user);
            [data addObject:model];
        }
    }
    
    // 更新UI
    self.tableViewAngel.clear();
    if (data.count > 0) {
        self.tableViewAngel.addSection(0);
        self.tableViewAngel.setHeader(@"TLContactsHeaderView").toSection(0).withDataModel(@"联系人");
        self.tableViewAngel.addCells(@"TLContactsItemCell").toSection(0).withDataModelArray(data).selectedAction(^ (TLContactsItemModel *model) {
            if (self.itemSelectedAction) {
                self.itemSelectedAction(self, model.userInfo);
            }
        });
    }
    [self.tableView reloadData];
}

//MARK: UISearchBarDelegate
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    [TLUIUtility showAlertWithTitle:@"语音搜索按钮"];
}

@end
