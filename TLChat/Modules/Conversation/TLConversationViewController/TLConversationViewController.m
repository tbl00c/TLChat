//
//  TLConversationViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLConversationViewController.h"
#import "TLConversationAngel.h"
#import "TLNetworkStatusManager.h"
#import "TLMessageManager+ConversationRecord.h"
#import "TLConversation+TLUser.h"
#import "TLFriendHelper.h"
#import "TLAddMenuView.h"

#import "TLSearchController.h"
#import "TLContactsSearchResultViewController.h"
#import "TLChatViewController+Conversation.h"
#import "TLUserDetailViewController.h"

@interface TLConversationViewController () <TLMessageManagerConvVCDelegate>
{
    TLNetworkStatusManager *networkStatusManger;
}

/// 列表
@property (nonatomic, strong) UITableView *tableView;

/// 列表数据及控制中心
@property (nonatomic, strong) TLConversationAngel *listAngel;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) TLSearchController *searchController;

@property (nonatomic, strong) TLAddMenuView *addMenuView;

@end

@implementation TLConversationViewController

- (id)init
{
    if (self = [super init]) {
        initTabBarItem(self.tabBarItem, LOCSTR(@"微信"), @"tabbar_mainframe", @"tabbar_mainframeHL");
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self p_setNavTitleWithStatusString:nil];
    
    // 初始化界面视图控件
    [self p_loadUI];
    
    // 初始化列表模块
    [self p_initListModule];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_startNetworkMonitoring];
    [[TLMessageManager sharedInstance] setConversationDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //TODO: 临时写法
    [self updateConversationData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.addMenuView.isShow) {
        [self.addMenuView dismiss];
    }
}

#pragma mark - # Delegate
//MARK: TLMessageManagerConvVCDelegate
- (void)updateConversationData
{
    [[TLMessageManager sharedInstance] conversationRecord:^(NSArray *data) {
        for (TLConversation *conversation in data) {
            if (conversation.convType == TLConversationTypePersonal) {
                TLUser *user = [[TLFriendHelper sharedFriendHelper] getFriendInfoByUserID:conversation.partnerID];
                [conversation updateUserInfo:user];
            }
            else if (conversation.convType == TLConversationTypeGroup) {
                TLGroup *group = [[TLFriendHelper sharedFriendHelper] getGroupInfoByGroupID:conversation.partnerID];
                [conversation updateGroupInfo:group];
            }
        }
        [self p_updateConvsationModuleWithData:data];
    }];
}

#pragma mark - # Private Methods
- (void)p_loadUI
{
    // 列表
    self.tableView = self.view.addTableView(1)
    .backgroundColor([UIColor whiteColor])
    .tableHeaderView(self.searchController.searchBar)
    .tableFooterView([UIView new])
    .separatorStyle(UITableViewCellSeparatorStyleNone)
    .masonry(^ (MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    })
    .view;
    
    // 顶部logo
    self.tableView.addImageView(1001)
    .image(TLImage(@"conv_wechat_icon"))
    .masonry(^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.tableView);
        make.bottom.mas_equalTo(self.tableView.mas_top).mas_offset(-35);
    });
    
    // 右侧按钮
    @weakify(self);
    [self addRightBarButtonWithImage:TLImage(@"nav_add") actionBlick:^{
        @strongify(self);
        if (self.addMenuView.isShow) {
            [self.addMenuView dismiss];
        }
        else {
            [self.addMenuView showInView:self.navigationController.view];
        }
    }];
}

- (void)p_initListModule
{
    @weakify(self);
    self.listAngel = [[TLConversationAngel alloc] initWithHostView:self.tableView badgeStatusChangeAction:^(NSString *badge) {
        @strongify(self);
        [self.tabBarItem setBadgeValue:badge];
    }];
    
    // 搜索，网络失败
    self.listAngel.addSection(TLConversationSectionTagAlert);
    // 置顶文章
    self.listAngel.addSection(TLConversationSectionTagTopArticle);
    // 播放内容
    self.listAngel.addSection(TLConversationSectionTagPlay);
    // 置顶会话
    self.listAngel.addSection(TLConversationSectionTagTopConversation);
    // 普通会话
    self.listAngel.addSection(TLConversationSectionTagConv);
    
    [self.tableView reloadData];
}

/// 更新会话模块的信息
- (void)p_updateConvsationModuleWithData:(NSArray *)data
{
    @weakify(self);
    self.listAngel.sectionForTag(TLConversationSectionTagConv).clear();
    self.listAngel.addCells(@"TLConversationCell").toSection(TLConversationSectionTagConv).withDataModelArray(data).selectedAction(^ (TLConversation *conversation) {
        @strongify(self);
        [conversation setUnreadCount:0];
        [self.listAngel reloadBadge];
        TLChatViewController *chatVC = [[TLChatViewController alloc] initWithConversation:conversation];
        PushVC(chatVC);
    });

    [self.tableView reloadData];
}

/// 开始网络监控
- (void)p_startNetworkMonitoring
{
    networkStatusManger = [[TLNetworkStatusManager alloc] init];
    [networkStatusManger startNetworkStatusMonitoring];
    @weakify(self);
    [networkStatusManger setNetworkChangedBlock:^(TLNetworkStatus status){
        @strongify(self);
        self.listAngel.sectionForTag(TLConversationSectionTagAlert).clear();
        if (status == TLNetworkStatusNone) {
            [self.navigationItem setTitle:LOCSTR(@"未连接")];
            self.listAngel.addCell(@"TLConversationNoNetCell").toSection(TLConversationSectionTagAlert).viewTag(TLConversationCellTagNoNet);
        }
        else {
            [self p_setNavTitleWithStatusString:nil];
        }
        [self.tableView reloadData];
    }];
}

- (void)p_setNavTitleWithStatusString:(NSString *)statusString
{
    NSString *title = LOCSTR(@"微信");
    title = statusString.length > 0 ? [title stringByAppendingFormat:@"(%@)", statusString] : title;
    [self.navigationItem setTitle:LOCSTR(title)];
}

#pragma mark - # Getter
- (TLSearchController *)searchController
{
    if (!_searchController) {
        TLContactsSearchResultViewController *searchVC = [[TLContactsSearchResultViewController alloc] init];
        @weakify(self);
        [searchVC setItemSelectedAction:^(TLContactsSearchResultViewController *searchVC, TLUser *userModel) {
            @strongify(self);
            [self.searchController setActive:NO];
            TLUserDetailViewController *detailVC = [[TLUserDetailViewController alloc] initWithUserModel:userModel];
            PushVC(detailVC);
        }];
        _searchController = [TLSearchController createWithResultsContrller:searchVC];
        [_searchController setEnableVoiceInput:YES];
    }
    return _searchController;
}

- (TLAddMenuView *)addMenuView
{
    if (!_addMenuView) {
        _addMenuView = [[TLAddMenuView alloc] init];
        @weakify(self);
        [_addMenuView setItemSelectedAction:^(TLAddMenuView *addMenuView, TLAddMenuItem *item) {
            @strongify(self);
            if (item.className.length > 0) {
                id vc = [[NSClassFromString(item.className) alloc] init];
                PushVC(vc);
            }
            else {
                [TLUIUtility showAlertWithTitle:item.title message:@"功能暂未实现"];
            }
        }];
    }
    return _addMenuView;
}

@end
