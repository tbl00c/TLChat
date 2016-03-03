//
//  TLChatBaseViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatBaseViewController.h"
#import "TLChatKeyboardController.h"
#import "TLFriendDetailViewController.h"

#import "TLTextMessageCell.h"

@interface TLChatBaseViewController () <UITableViewDataSource, UITableViewDelegate, TLChatBarDataDelegate, TLMessageCellDelegate>

@property (nonatomic, strong) TLChatKeyboardController *chatKeyboardController;

@end

@implementation TLChatBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.chatBar];
    
    [self.tableView registerClass:[TLTextMessageCell class] forCellReuseIdentifier:@"TLTextMessageCell"];
    
    [self p_addMasonry];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.chatKeyboardController setChatBaseVC:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self.chatKeyboardController selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self.chatKeyboardController selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self.chatKeyboardController selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Public Methods -
- (void)setUser:(TLUser *)user
{
    if (_user && ![_user.userID isEqualToString:user.userID]) {
        [self.data removeAllObjects];
        [self.tableView reloadData];
    }
    _user = user;
    lastDate = nil;
    [self.navigationItem setTitle:user.showName];
}

- (void)setChatMoreKeyboardData:(NSMutableArray *)moreKeyboardData
{
    [self.moreKeyboard setChatMoreKeyboardData:moreKeyboardData];
}

- (void)setChatEmojiKeyboardData:(NSMutableArray *)emojiKeyboardData
{
    [self.emojiKeyboard setEmojiGroupData:emojiKeyboardData];
}

- (void)sendImageMessage:(NSString *)imagePath
{
    [self chatBar:nil sendText:@"[图片消息，即将支持]"];
}


#pragma mark - Delegate -
//MARK: UITableViewDataSouce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLMessage *message = self.data[indexPath.row];
    if (message.messageType == TLMessageTypeText) {
        TLTextMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLTextMessageCell"];
        [cell setMessage:message];
        [cell setDelegate:self];
        return cell;
    }
    return nil;
}

//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return 60.0f;
}

//MARK: TLMessageCellDelegate
- (void)messageCellDidClickAvatarForUser:(TLUser *)user
{
    TLFriendDetailViewController *detailVC = [[TLFriendDetailViewController alloc] init];
    [detailVC setUser:user];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:detailVC animated:YES];
}

//MARK: TLChatBarDataDelegate
- (void)chatBar:(TLChatBar *)chatBar sendText:(NSString *)text
{
    TLMessage *message = [[TLMessage alloc] init];
    message.fromID = [TLUserHelper sharedHelper].user.userID;
    message.toID = self.user.userID;
    message.fromUser = [TLUserHelper sharedHelper].user;
    message.messageType = TLMessageTypeText;
    message.ownerTyper = TLMessageOwnerTypeSelf;
    message.text = text;
    message.showTime = YES;
    message.showName = NO;
    [self.data addObject:message];
    TLMessage *message1 = [[TLMessage alloc] init];
    message1.fromID = self.user.userID;
    message1.toID = [TLUserHelper sharedHelper].user.userID;
    message1.fromUser = self.user;
    message1.messageType = TLMessageTypeText;
    message1.ownerTyper = TLMessageOwnerTypeOther;
    message1.text = text;
    message1.showTime = NO;
    message1.showName = NO;
    [self.data addObject:message1];
    [self.tableView reloadData];
    [self.tableView scrollToBottomWithAnimation:YES];
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.chatBar.mas_top);
    }];
    [self.chatBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(self.view);
    }];
}

static NSDate *lastDate = nil;
- (BOOL)p_needShowTime:(NSDate *)date
{
    if (lastDate == nil) {
        date = lastDate;
        return YES;
    }
    return NO;
}


#pragma mark - Getter -
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        [_tableView setBackgroundColor:[UIColor colorChatTableViewBG]];
        [_tableView setTableFooterView:[[UIView alloc] init]];
        [_tableView setDataSource:self];
        [_tableView setDelegate:self];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _tableView;
}

- (TLChatBar *)chatBar
{
    if (_chatBar == nil) {
        _chatBar = [[TLChatBar alloc] init];
        [_chatBar setDelegate:self.chatKeyboardController];
        [_chatBar setDataDelegate:self];
    }
    return _chatBar;
}

- (NSMutableArray *)data
{
    if (_data == nil) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

- (TLEmojiKeyboard *)emojiKeyboard
{
    if (_emojiKeyboard == nil) {
        _emojiKeyboard = [TLEmojiKeyboard keyboard];
        [_emojiKeyboard setKeyboardDelegate:self.chatKeyboardController];
        [_emojiKeyboard setDataSource:self];
    }
    return _emojiKeyboard;
}

- (TLMoreKeyboard *)moreKeyboard
{
    if (_moreKeyboard == nil) {
        _moreKeyboard = [TLMoreKeyboard keyboard];
        [_moreKeyboard setKeyboardDelegate:self.chatKeyboardController];
        [_moreKeyboard setDelegate:self];
    }
    return _moreKeyboard;
}

- (TLChatKeyboardController *)chatKeyboardController
{
    if (_chatKeyboardController == nil) {
        _chatKeyboardController = [[TLChatKeyboardController alloc] init];
    }
    return _chatKeyboardController;
}

@end
