//
//  TLChatBaseViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatBaseViewController.h"
#import "TLChatBaseViewController+UIDelegate.h"
#import "TLChatBaseViewController+DataDelegate.h"
#import "TLChatBaseViewController+ChatBarDelegate.h"
#import "TLChatBaseViewController+EmojiKBDelegate.h"
#import "TLChatBaseViewController+ChatTableViewDelegate.h"

#import "UIImage+Size.h"

@implementation TLChatBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.chatTableVC.tableView];
    [self addChildViewController:self.chatTableVC];
    [self.view addSubview:self.chatBar];
    
    [self p_addMasonry];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Public Methods -
- (void)setUser:(TLUser *)user
{
    if (_curChatType != TLChatVCTypeFriend || !_user || ![_user.userID isEqualToString:user.userID]) {
        _user = user;
        [self.navigationItem setTitle:user.showName];
        _curChatType = TLChatVCTypeFriend;
        _group = nil;
        [self resetChatVC];
    }
}

- (void)setGroup:(TLGroup *)group
{
    if (_curChatType != TLChatVCTypeGroup || !_group || [_group.groupID isEqualToString:group.groupID]) {
        _group = group;
        [self.navigationItem setTitle:group.groupName];
        _curChatType = TLChatVCTypeGroup;
        _user = nil;
        [self resetChatVC];
    }
}

- (void)setChatMoreKeyboardData:(NSMutableArray *)moreKeyboardData
{
    [self.moreKeyboard setChatMoreKeyboardData:moreKeyboardData];
}

- (void)setChatEmojiKeyboardData:(NSMutableArray *)emojiKeyboardData
{
    [self.emojiKeyboard setEmojiGroupData:emojiKeyboardData];
}

- (void)resetChatVC
{
    NSString *chatViewBGImage;
    //TODO: 临时写法
    if (self.curChatType == TLChatVCTypeFriend && self.user) {
        chatViewBGImage = [[NSUserDefaults standardUserDefaults] objectForKey:[@"CHAT_BG_" stringByAppendingString:self.user.userID]];
    }
    else if (self.curChatType == TLChatVCTypeGroup && self.group) {
        chatViewBGImage = [[NSUserDefaults standardUserDefaults] objectForKey:[@"CHAT_BG_" stringByAppendingString:self.group.groupID]];
    }
    if (chatViewBGImage == nil) {
        chatViewBGImage = [[NSUserDefaults standardUserDefaults] objectForKey:@"CHAT_BG_ALL"];
        if (chatViewBGImage == nil) {
            [self.view setBackgroundColor:[UIColor colorChatTableViewBG]];
        }
        else {
            NSString *imagePath = [NSFileManager pathUserChatBackgroundImage:chatViewBGImage];
            UIImage *image = [UIImage imageNamed:imagePath];
            [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
        }
    }
    else {
        NSString *imagePath = [NSFileManager pathUserChatBackgroundImage:chatViewBGImage];
        UIImage *image = [UIImage imageNamed:imagePath];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    }
    
    [self resetChatTVC];
}

/**
 *  发送图片消息
 */
- (void)sendImageMessage:(UIImage *)image
{
    NSData *imageData = (UIImagePNGRepresentation(image) ? UIImagePNGRepresentation(image) :UIImageJPEGRepresentation(image, 0.5));
    NSString *imageName = [NSString stringWithFormat:@"%lf.jpg", [NSDate date].timeIntervalSince1970];
    NSString *imagePath = [NSFileManager pathUserChatImage:imageName];
    [[NSFileManager defaultManager] createFileAtPath:imagePath contents:imageData attributes:nil];
    
    TLImageMessage *message = [[TLImageMessage alloc] init];
    message.fromUser = [TLUserHelper sharedHelper].user;
    message.messageType = TLMessageTypeImage;
    message.ownerTyper = TLMessageOwnerTypeSelf;
    message.imagePath = imageName;
    [self sendMessage:message];
    if (self.curChatType == TLChatVCTypeFriend) {
        TLImageMessage *message1 = [[TLImageMessage alloc] init];
        message1.fromUser = self.user;
        message1.messageType = TLMessageTypeImage;
        message1.ownerTyper = TLMessageOwnerTypeFriend;
        message1.imagePath = imageName;
        [self sendMessage:message1];
    }
    else {
        for (TLUser *user in self.group.users) {
            TLImageMessage *message1 = [[TLImageMessage alloc] init];
            message1.friendID = user.userID;
            message1.fromUser = user;
            message1.messageType = TLMessageTypeImage;
            message1.ownerTyper = TLMessageOwnerTypeFriend;
            message1.imagePath = imageName;
            [self sendMessage:message1];
        }
    }
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
        [_chatBar setDelegate:self];
        [_chatBar setDataDelegate:self];
    }
    return _chatBar;
}

- (TLEmojiKeyboard *)emojiKeyboard
{
    if (_emojiKeyboard == nil) {
        _emojiKeyboard = [TLEmojiKeyboard keyboard];
        [_emojiKeyboard setKeyboardDelegate:self];
        [_emojiKeyboard setDelegate:self];
    }
    return _emojiKeyboard;
}

- (TLMoreKeyboard *)moreKeyboard
{
    if (_moreKeyboard == nil) {
        _moreKeyboard = [TLMoreKeyboard keyboard];
        [_moreKeyboard setKeyboardDelegate:self];
        [_moreKeyboard setDelegate:self];
    }
    return _moreKeyboard;
}

- (TLEmojiDisplayView *)emojiDisplayView
{
    if (_emojiDisplayView == nil) {
        _emojiDisplayView = [[TLEmojiDisplayView alloc] init];
    }
    return _emojiDisplayView;
}

- (TLImageExpressionDisplayView *)imageExpressionDisplayView
{
    if (_imageExpressionDisplayView == nil) {
        _imageExpressionDisplayView = [[TLImageExpressionDisplayView alloc] init];
    }
    return _imageExpressionDisplayView;
}

@end
