//
//  TLConversationViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLConversationViewController.h"

#import "TLFriendSearchViewController.h"

#import "TLConversationCell.h"

#import <UIImageView+WebCache.h>

#define     HEIGHT_CONVERSATION_CELL        63.0f


@interface TLConversationViewController () <UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) TLFriendSearchViewController *searchVC;


@end

@implementation TLConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"微信"];
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.tableView setTableHeaderView:self.searchController.searchBar];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_add"] style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonDown:)];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
    
    [self.tableView registerClass:[TLConversationCell class] forCellReuseIdentifier:@"TLConversationCell"];
    
    //TODO: Do not work
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClick)];
    [tapGes setNumberOfTapsRequired:2];
  
    
    [self initTestData];
}

- (void) doubleClick
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Double Click Tab Bar" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLConversation *conversation = [self.data objectAtIndex:indexPath.row];
    TLConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLConversationCell"];
    [cell setConversation:conversation];
    
    [cell setTopLineStyle:indexPath.row == 0 ? TLCellLineStyleFill : TLCellLineStyleNone];
    [cell setBottomLineStyle:indexPath.row == self.data.count - 1 ? TLCellLineStyleFill : TLCellLineStyleDefault];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEIGHT_CONVERSATION_CELL;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    TLConversationCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [cell markAsRead];
}

- (NSArray *) tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLConversation *conversation = [self.data objectAtIndex:indexPath.row];
    __weak typeof(self) weakSelf = self;
    UITableViewRowAction *delAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                         title:@"删除"
                                                                       handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                           [weakSelf.data removeObjectAtIndex:indexPath.row];
                                                                           [weakSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                                                                           if (self.data.count > 0 && indexPath.row == self.data.count) {
                                                                               NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:indexPath.row - 1 inSection:indexPath.section];
                                                                               TLConversationCell *cell = [self.tableView cellForRowAtIndexPath:lastIndexPath];
                                                                               [cell setBottomLineStyle:TLCellLineStyleFill];
                                                                           }
                                                                       }];
    UITableViewRowAction *moreAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                          title:conversation.isRead ? @"标为未读" : @"标为已读"
                                                                        handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                            TLConversationCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                                                                            conversation.isRead ? [cell markAsUnread] : [cell markAsRead];
                                                                            [tableView setEditing:NO animated:YES];
                                                                        }];
    moreAction.backgroundColor = [UIColor colorCellMoreButton];
    NSArray *arr = @[delAction, moreAction];
    return arr;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

#pragma mark UISearchBarDelegate
- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.tabBarController.tabBar setHidden:YES];
}

- (void) searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark - Event Response
- (void) rightBarButtonDown:(UIBarButtonItem *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Right Bar Button Down!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

#pragma mark - Getter
- (UISearchController *) searchController
{
    if (_searchController == nil) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchVC];
        [_searchController.searchBar setPlaceholder:@"搜索"];
        [_searchController.searchBar setBarTintColor:[UIColor colorSearchBarTint]];
        [_searchController.searchBar setDelegate:self];
        [_searchController.searchBar.layer setBorderWidth:0.5f];
        [_searchController.searchBar.layer setBorderColor:[UIColor colorSearchBarBorder].CGColor];
    }
    return _searchController;
}

- (TLFriendSearchViewController *) searchVC
{
    if (_searchVC == nil) {
        _searchVC = [[TLFriendSearchViewController alloc] init];
    }
    return _searchVC;
}

- (void) initTestData
{
    NSArray *jsonData = @[@{
                              @"username":@"莫小贝",
                              @"messageDetail":@"帅哥你好啊!",
                              @"avatarPath":@"10.jpeg",
                              },
                          @{
                              @"username":@"刘亦菲、IU、汤唯、刘诗诗、杨幂、Baby",
                              @"messageDetail":@"凤姐：什么鬼，我为什么会在这个群组里面？?",
                              @"avatarURL":@"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg",
                              }
                         ];
    self.data = [TLConversation mj_objectArrayWithKeyValuesArray:jsonData];
    TLConversation *conv = self.data[1];
    conv.remindType = TLMessageRemindTypeClosed;
    conv.convType = TLConversationTypePublic;
}

@end
