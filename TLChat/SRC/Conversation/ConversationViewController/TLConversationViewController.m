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

#define     HEIGHT_CONVERSATION_CELL        65.0f


@interface TLConversationViewController () <SWTableViewCellDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) TLFriendSearchViewController *searchVC;


@end

@implementation TLConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"微信"];
    
    [self.tableView setTableHeaderView:self.searchController.searchBar];
    
    [self.tableView registerClass:[TLConversationCell class] forCellReuseIdentifier:@"TLConversationCell"];
    
    NSArray *jsonData = @[@{
                              @"username":@"莫小贝",
                              @"messageDetail":@"帅哥你好啊!",
                              @"avatarURL":@"http://img4.duitang.com/uploads/item/201412/19/20141219143241_H3TYu.png",
                              },
                          @{
                              @"username":@"刘亦菲、IU、汤唯、刘诗诗、杨幂、Baby",
                              @"messageDetail":@"凤姐：什么鬼，我为什么会在这个群组里面？?",
                              @"avatarURL":@"http://img4.duitang.com/uploads/item/201510/16/20151016113134_TZye4.thumb.224_0.jpeg",
                              },
                          @{
                              @"username":@"test2",
                              @"messageDetail":@"This is a test. Hello world, hello everyone!",
                              @"avatarURL":@"http://img4.duitang.com/uploads/item/201512/22/20151222132938_BRTcQ.png",
                              }];
    self.data = [TLConversation mj_objectArrayWithKeyValuesArray:jsonData];
    TLConversation *conv = self.data[1];
    conv.remindType = TLMessageRemindTypeClosed;
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLConversation *conversation = [self.data objectAtIndex:indexPath.row];
    TLConversationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLConversationCell"];
    [cell setConversation:conversation];
    [cell setBottomLineStyle:indexPath.row == self.data.count - 1 ? TLCellLineStyleFill : TLCellLineStyleDefault];
    cell.rightUtilityButtons = [self p_getRightButtonsByConversationType:conversation.type];
    cell.delegate = self;
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
}

#pragma mark SWTableViewCellDelegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%ld", (long)index] message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [alert show];
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

#pragma mark - Private Methods
- (NSArray *) p_getRightButtonsByConversationType:(TLConversationType)type
{
    NSMutableArray *cellRightButtons = [[NSMutableArray alloc] init];
    switch (type) {
        case TLConversationTypePersonal:
        case TLConversationTypeGroup:
            [cellRightButtons sw_addUtilityButtonWithColor:[TLColorUtility colorCellMoreButton] title:@"标为未读"];
            [cellRightButtons sw_addUtilityButtonWithColor:[TLColorUtility colorCellDeleteButton] title:@"删除"];
            break;
        case TLConversationTypePublic:
            [cellRightButtons sw_addUtilityButtonWithColor:[TLColorUtility colorCellMoreButton] title:@"取消关注"];
            [cellRightButtons sw_addUtilityButtonWithColor:[TLColorUtility colorCellDeleteButton] title:@"删除"];
            break;
        default:
            [cellRightButtons sw_addUtilityButtonWithColor:[TLColorUtility colorCellDeleteButton] title:@"删除"];
            break;
    }
    return cellRightButtons;
}

#pragma mark - Getter
- (UISearchController *) searchController
{
    if (_searchController == nil) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchVC];
        [_searchController.searchBar setPlaceholder:@"搜索"];
        [_searchController.searchBar setBarTintColor:[TLColorUtility colorSearchBarTint]];
        [_searchController.searchBar setDelegate:self];
        [_searchController.searchBar.layer setBorderWidth:0.5f];
        [_searchController.searchBar.layer setBorderColor:[TLColorUtility colorSearchBarBorder].CGColor];
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

@end
