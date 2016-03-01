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

static TLChatViewController *chatVC;

@interface TLChatViewController()

@property (nonatomic, strong) TLMoreKBHelper *moreKBhelper;

@property (nonatomic, strong) TLEmojiKBHelper *emojiKBHelper;

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
    
    self.moreKBhelper = [[TLMoreKBHelper alloc] init];
    [self setChatMoreKeyboardData:self.moreKBhelper.chatMoreKeyboardData];
    self.emojiKBHelper = [[TLEmojiKBHelper alloc] init];
    [self setChatEmojiKeyboardData:self.emojiKBHelper.emojiGroupData];
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

#pragma mark - Delegate -
//MARK: TLMoreKeyboardDelegate
- (void)moreKeyboard:(id)keyboard didSelectedFunctionItem:(TLMoreKeyboardItem *)funcItem
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"选中”%@“ 按钮", funcItem.title] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

//MARK: TLEmojiKeyboardDataSource
- (NSMutableArray *)emojiKeyboard:(id)emojiKeyboard emojiDataForGroupItem:(TLEmojiGroup *)item
{
    NSUInteger count = (item.type == TLEmojiGroupTypeFace || item.type == TLEmojiGroupTypeEmoji)? 100 : 20;
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (int i = 0; i <= count; i ++) {
        TLEmoji *emoji = [[TLEmoji alloc] init];
        emoji.title = (item.type == TLEmojiGroupTypeEmoji) ? @"😚" : @"你好";
        emoji.iconPath = (item.type == TLEmojiGroupTypeFace) ? @"[微笑]" : @"10.jpeg";
        [arr addObject:emoji];
    }
    return arr;
}

@end
