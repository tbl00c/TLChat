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
#import "TLChatBaseViewController+ChatTableView.h"

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
- (void)setPartner:(id<TLChatUserProtocol>)partner
{
    if (_partner && [[_partner chat_userID] isEqualToString:[partner chat_userID]]) {
        return;
    }
    _partner = partner;
    [self.navigationItem setTitle:[_partner chat_username]];
    [self resetChatVC];
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
    NSString *chatViewBGImage = [[NSUserDefaults standardUserDefaults] objectForKey:[@"CHAT_BG_" stringByAppendingString:[self.partner chat_userID]]];
    if (chatViewBGImage == nil) {
        chatViewBGImage = [[NSUserDefaults standardUserDefaults] objectForKey:@"CHAT_BG_ALL"];
        if (chatViewBGImage == nil) {
            [self.view setBackgroundColor:[UIColor colorGrayCharcoalBG]];
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
    message.fromUser = self.user;
    message.messageType = TLMessageTypeImage;
    message.ownerTyper = TLMessageOwnerTypeSelf;
    message.imagePath = imageName;
    message.imageSize = image.size;
    [self sendMessage:message];
    if ([self.partner chat_userType] == TLChatUserTypeUser) {
        TLImageMessage *message1 = [[TLImageMessage alloc] init];
        message1.fromUser = self.partner;
        message1.messageType = TLMessageTypeImage;
        message1.ownerTyper = TLMessageOwnerTypeFriend;
        message1.imagePath = imageName;
        message1.imageSize = image.size;
        [self sendMessage:message1];
    }
    else {
        for (id<TLChatUserProtocol> user in [self.partner groupMembers]) {
            TLImageMessage *message1 = [[TLImageMessage alloc] init];
            message1.friendID = [user chat_userID];
            message1.fromUser = user;
            message1.messageType = TLMessageTypeImage;
            message1.ownerTyper = TLMessageOwnerTypeFriend;
            message1.imagePath = imageName;
            message1.imageSize = image.size;
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
