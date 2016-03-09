//
//  TLChatBaseViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatBaseViewController.h"
#import "TLChatKeyboardController.h"
#import "TLFriendHelper.h"

@interface TLChatBaseViewController () <TLChatBarDataDelegate, TLChatTableViewControllerDelegate>

@property (nonatomic, strong) TLChatKeyboardController *chatKeyboardController;

@end

@implementation TLChatBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.chatTableVC.tableView];
    [self addChildViewController:self.chatTableVC];
    [self.view addSubview:self.chatBar];
    
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
    if (_curChatType != TLChatVCTypeFriend || (_user && ![_user.userID isEqualToString:user.userID])) {
        _curChatType = TLChatVCTypeFriend;
        _group = nil;
        [self.chatTableVC clearData];
    }
    _user = user;
    lastDate = nil;
    [self.navigationItem setTitle:user.showName];
}

- (void)setGroup:(TLGroup *)group
{
    if (_curChatType != TLChatVCTypeGroup || (_group && [_group.groupID isEqualToString:group.groupID])) {
        _curChatType = TLChatVCTypeGroup;
        _user = nil;
        [self.chatTableVC clearData];
    }
    _group = group;
    lastDate = nil;
    [self.navigationItem setTitle:group.groupName];
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
//MARK: TLChatTableViewControllerDelegate
- (void)chatTableViewControllerDidTouched:(TLChatTableViewController *)chatTVC
{
    NSLog(@"Tap ChatVC");
    if ([self.chatBar isFirstResponder]) {
        [self.chatBar resignFirstResponder];
    }
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
    [self.chatTableVC sendMessage:message];
    if (self.curChatType == TLChatVCTypeFriend) {
        TLMessage *message1 = [[TLMessage alloc] init];
        message1.fromID = self.user.userID;
        message1.toID = [TLUserHelper sharedHelper].user.userID;
        message1.fromUser = self.user;
        message1.messageType = TLMessageTypeText;
        message1.ownerTyper = TLMessageOwnerTypeOther;
        message1.text = text;
        message1.showTime = NO;
        message1.showName = NO;
        [self.chatTableVC sendMessage:message1];
    }
    else {
        for (NSString *userID in self.group.users) {
            TLUser *user = [[TLFriendHelper sharedFriendHelper] getFriendInfoByUserID:userID];
            TLMessage *message1 = [[TLMessage alloc] init];
            message1.fromID = user.userID;
            message1.toID = [TLUserHelper sharedHelper].user.userID;
            message1.fromUser = user;
            message1.messageType = TLMessageTypeText;
            message1.ownerTyper = TLMessageOwnerTypeOther;
            message1.text = text;
            message1.showTime = NO;
            message1.showName = NO;
            [self.chatTableVC sendMessage:message1];
        }
    }

    [self.chatTableVC scrollToBottomWithAnimation:YES];
}

//MARK: TLEmojiKeyboardDelegate
- (void)sendButtonDown
{
    [self.chatBar sendCurrentText];
}

- (void)touchInEmojiItem:(TLEmoji *)emoji point:(CGPoint)point
{
    NSLog(@"touch in %@, path %@", emoji.title, emoji.path);
}

- (void)cancelTouchEmojiItem:(TLEmoji *)emoji
{
    NSLog(@"cancel touch %@, path %@", emoji.title, emoji.path);
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.chatTableVC.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
- (TLChatTableViewController *)chatTableVC
{
    if (_chatTableVC == nil) {
        _chatTableVC = [[TLChatTableViewController alloc] init];
        [_chatTableVC setDelegate:self];
    }
    return _chatTableVC;
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

- (TLEmojiKeyboard *)emojiKeyboard
{
    if (_emojiKeyboard == nil) {
        _emojiKeyboard = [TLEmojiKeyboard keyboard];
        [_emojiKeyboard setKeyboardDelegate:self.chatKeyboardController];
        [_emojiKeyboard setDelegate:self];
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
