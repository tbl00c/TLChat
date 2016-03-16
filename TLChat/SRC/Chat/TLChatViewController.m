//
//  TLChatViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatViewController.h"
#import <MobClick.h>
#import "TLMoreKBHelper.h"
#import "TLEmojiKBHelper.h"
#import "TLChatDetailViewController.h"
#import "TLChatGroupDetailViewController.h"
#import "TLExpressionViewController.h"
#import "TLMyExpressionViewController.h"

static TLChatViewController *chatVC;

@interface TLChatViewController()

@property (nonatomic, strong) TLMoreKBHelper *moreKBhelper;

@property (nonatomic, strong) TLEmojiKBHelper *emojiKBHelper;

@property (nonatomic, strong) UIBarButtonItem *rightBarButton;

@end

@implementation TLChatViewController

+ (TLChatViewController *) sharedChatVC
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        chatVC = [[TLChatViewController alloc] init];
    });
    return chatVC;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorTableViewBG]];
    
    [self.navigationItem setRightBarButtonItem:self.rightBarButton];
    
    self.moreKBhelper = [[TLMoreKBHelper alloc] init];
    [self setChatMoreKeyboardData:self.moreKBhelper.chatMoreKeyboardData];
    self.emojiKBHelper = [TLEmojiKBHelper sharedKBHelper];
    [self.emojiKBHelper emojiGroupDataByUserID:[TLUserHelper sharedHelper].userID complete:^(NSMutableArray *emojiGroups) {
        [self setChatEmojiKeyboardData:emojiGroups];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:@"ChatVC"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:@"ChatVC"];
}

- (void)dealloc
{
#ifdef DEBUG_MEMERY
    NSLog(@"dealloc ChatVC");
#endif
}

#pragma mark - Public Methods -
- (void)setUser:(TLUser *)user
{
    [super setUser:user];
    [self.rightBarButton setImage:[UIImage imageNamed:@"nav_chat_single"]];
}

- (void)setGroup:(TLGroup *)group
{
    [super setGroup:group];
    [self.rightBarButton setImage:[UIImage imageNamed:@"nav_chat_multi"]];
}

#pragma mark - Delegate -
//MARK: TLMoreKeyboardDelegate
- (void)moreKeyboard:(id)keyboard didSelectedFunctionItem:(TLMoreKeyboardItem *)funcItem
{
    if (funcItem.type == TLMoreKeyboardItemTypeCamera || funcItem.type == TLMoreKeyboardItemTypeImage) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        if (funcItem.type == TLMoreKeyboardItemTypeCamera) {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
            }
            else {
                [UIAlertView alertWithTitle:@"错误" message:@"相机初始化失败"];
                return;
            }
        }
        else {
            [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        }
        [self presentViewController:imagePickerController animated:YES completion:nil];
        [imagePickerController.rac_imageSelectedSignal subscribeNext:^(id x) {
            [imagePickerController dismissViewControllerAnimated:YES completion:^{
                UIImage *image = [x objectForKey:UIImagePickerControllerOriginalImage];
                [self sendImageMessage:image];
            }];
        } completed:^{
            [imagePickerController dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"选中”%@“ 按钮", funcItem.title] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}

//MARK: TLEmojiKeyboardDelegate
- (void)emojiKeyboardEmojiEditButtonDown
{
    TLExpressionViewController *expressionVC = [[TLExpressionViewController alloc] init];
    TLNavigationController *navC = [[TLNavigationController alloc] initWithRootViewController:expressionVC];
    [self presentViewController:navC animated:YES completion:nil];
}

- (void)emojiKeyboardMyEmojiEditButtonDown
{
    TLMyExpressionViewController *myExpressionVC = [[TLMyExpressionViewController alloc] init];
    TLNavigationController *navC = [[TLNavigationController alloc] initWithRootViewController:myExpressionVC];
    [self presentViewController:navC animated:YES completion:nil];
}

#pragma mark - Event Response -
- (void)rightBarButtonDown:(UINavigationBar *)sender
{
    if (self.curChatType == TLChatVCTypeFriend) {
        TLChatDetailViewController *chatDetailVC = [[TLChatDetailViewController alloc] init];
        [chatDetailVC setUser:self.user];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:chatDetailVC animated:YES];
    }
    else if (self.curChatType == TLChatVCTypeGroup) {
        TLChatGroupDetailViewController *chatGroupDetailVC = [[TLChatGroupDetailViewController alloc] init];
        [chatGroupDetailVC setGroup:self.group];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:chatGroupDetailVC animated:YES];
    }
}

#pragma mark - Getter -
- (UIBarButtonItem *)rightBarButton
{
    if (_rightBarButton == nil) {
        _rightBarButton = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDown:)];
    }
    return _rightBarButton;
}
@end
