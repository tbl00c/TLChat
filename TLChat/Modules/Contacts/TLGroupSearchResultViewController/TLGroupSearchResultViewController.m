//
//  TLGroupSearchResultViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLGroupSearchResultViewController.h"
#import "TLChatViewController.h"
#import "TLFriendHelper.h"

typedef NS_ENUM(NSInteger, TLGroupSearchResultVCSectionType) {
    TLGroupSearchResultVCSectionTypeItems,
};

@interface TLGroupSearchResultViewController ()

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZZFLEXAngel *tableViewAngel;

/// 页面跳转block
@property (nonatomic, copy) void (^jumpAction)(__kindof UIViewController *vc);

@end

@implementation TLGroupSearchResultViewController

- (instancetype)initWithJumpAction:(void (^)(__kindof UIViewController *))jumpAction
{
    if (self = [super init]) {
        self.jumpAction = jumpAction;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.tableView = self.view.addTableView(1)
    .backgroundColor([UIColor colorGrayBG]).separatorStyle(UITableViewCellSeparatorStyleNone)
    .tableFooterView([UIView new])
    .masonry(^ (MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    })
    .view;;
    
    self.tableViewAngel = [[ZZFLEXAngel alloc] initWithHostView:self.tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.data = [TLFriendHelper sharedFriendHelper].groupsData;
}

- (void)loadListUIWithData:(NSArray *)data
{
    @weakify(self);
    self.tableViewAngel.clear();
    self.tableViewAngel.addSection(TLGroupSearchResultVCSectionTypeItems);
    self.tableViewAngel.addCells(@"TLGroupItemCell").toSection(TLGroupSearchResultVCSectionTypeItems).withDataModelArray(data).selectedAction(^ (TLGroup *group) {
        @strongify(self);
        TLChatViewController *chatVC = [[TLChatViewController alloc] initWithGroupId:group.groupID];
        if (self.jumpAction) {
            self.jumpAction(chatVC);
        }
    });
    [self.tableView reloadData];
}

#pragma mark - # Protocol
//MARK: UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchText = [searchController.searchBar.text lowercaseString];
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (TLGroup *group in self.data) {
        if ([group.groupName containsString:searchText] || [group.pinyin containsString:searchText] || [group.pinyinInitial containsString:searchText]) {
            [data addObject:group];
        }
    }
    [self loadListUIWithData:data];
}

@end
