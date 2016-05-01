//
//  TLCommonSettingViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/21.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLCommonSettingViewController.h"
#import "TLCommonSettingHelper.h"
#import "TLMessageManager.h"

#import "TLChatViewController.h"
#import "TLChatFontViewController.h"
#import "TLChatBackgroundSettingViewController.h"
#import "TLMyExpressionViewController.h"

#define     TAG_ACTIONSHEET_EMPTY_REC       1001

@interface TLCommonSettingViewController () <TLActionSheetDelegate>

@property (nonatomic, strong) TLCommonSettingHelper *helper;

@end

@implementation TLCommonSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"通用"];
    
    self.helper = [[TLCommonSettingHelper alloc] init];
    self.data = self.helper.commonSettingData;
}

#pragma mark - Delegate -
//MARK: UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLSettingItem *item = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    if ([item.title isEqualToString:@"字体大小"]) {
        TLChatFontViewController *chatFontVC = [[TLChatFontViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:chatFontVC animated:YES];
    }
    else if ([item.title isEqualToString:@"聊天背景"]) {
        TLChatBackgroundSettingViewController *chatBGSettingVC = [[TLChatBackgroundSettingViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:chatBGSettingVC animated:YES];
    }
    else if ([item.title isEqualToString:@"我的表情"]) {
        TLMyExpressionViewController *myExpressionVC = [[TLMyExpressionViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:myExpressionVC animated:YES];
    }
    else if ([item.title isEqualToString:@"清空聊天记录"]) {
        TLActionSheet *actionSheet = [[TLActionSheet alloc] initWithTitle:@"将删除所有个人和群的聊天记录。" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"清空聊天记录" otherButtonTitles:nil];
        [actionSheet setTag:TAG_ACTIONSHEET_EMPTY_REC];
        [actionSheet show];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

//MARK: TLActionSheetDelegate
- (void)actionSheet:(TLActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == TAG_ACTIONSHEET_EMPTY_REC) {
        if (buttonIndex == 0) {
            [[TLMessageManager sharedInstance] deleteAllMessages];
            [[TLChatViewController sharedChatVC] resetChatVC];
        }
    }
}

@end
