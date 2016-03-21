//
//  TLChatFontViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/21.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatFontViewController.h"
#import "TLChatTableViewController.h"

@interface TLChatFontViewController ()

@property (nonatomic, strong) TLChatTableViewController *chatTVC;

@end


@implementation TLChatFontViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"字体大小"];
    
    [self.view addSubview:self.chatTVC.view];
    [self addChildViewController:self.chatTVC];
    [self p_addMasonry];
    
    self.chatTVC.data = [self p_chatTVCData];
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.chatTVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(self.view);
        make.height.mas_equalTo(self.view).multipliedBy(0.65);
    }];
}

- (NSMutableArray *)p_chatTVCData
{
    TLMessage *message = [[TLMessage alloc] init];
    message.fromUser = [TLUserHelper sharedHelper].user;
    message.messageType = TLMessageTypeText;
    message.ownerTyper = TLMessageOwnerTypeSelf;
    message.text = @"预览字体大小";
    
    TLUser *user = [[TLUser alloc] init];
    user.avatarPath = @"AppIcon";
    TLMessage *message1 = [[TLMessage alloc] init];
    message1.fromUser = user;
    message1.messageType = TLMessageTypeText;
    message1.ownerTyper = TLMessageOwnerTypeFriend;
    message1.text = @"拖动下面的滑块，可设置字体大小";
    TLMessage *message2 = [[TLMessage alloc] init];
    message2.fromUser = user;
    message2.messageType = TLMessageTypeText;
    message2.ownerTyper = TLMessageOwnerTypeFriend;
    message2.text = @"设置后，会改变聊天、菜单和朋友圈的字体大小。如果在使用过程中存在问题或意见，可反馈给微信团队。";
    
    NSMutableArray *data = [[NSMutableArray alloc] initWithObjects:message, message1, message2, nil];
    return data;
}


#pragma mark - Getter -
- (TLChatTableViewController *)chatTVC
{
    if (_chatTVC == nil) {
        _chatTVC = [[TLChatTableViewController alloc] init];
    }
    return _chatTVC;
}

@end
