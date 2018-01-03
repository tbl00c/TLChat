//
//  TLMyExpressionViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMyExpressionViewController.h"
#import "TLExpressionDetailViewController.h"
#import "TLExpressionHelper.h"
#import "TLMyExpressionCell.h"

@interface TLMyExpressionViewController () <TLMyExpressionCellDelegate>

@property (nonatomic, strong) TLExpressionHelper *helper;

@end

@implementation TLMyExpressionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"我的表情"];
    
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"排序" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDown:)];
    [self.navigationItem setRightBarButtonItem:rightBarButtonItem];
    
    if (self.navigationController.rootViewController == self) {
        UIBarButtonItem *dismissBarButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain actionBlick:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [self.navigationItem setLeftBarButtonItem:dismissBarButton];
    }
    
    [self.tableView registerClass:[TLMyExpressionCell class] forCellReuseIdentifier:@"TLMyExpressionCell"];
    
    self.helper = [TLExpressionHelper sharedHelper];
    self.data = [self.helper myExpressionListData];
}

#pragma mark - Delegate -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLSettingGroup *group = self.data[indexPath.section];
    if (group.headerTitle) {    // 有标题的就是表情组
        TLExpressionGroupModel *emojiGroup = [group objectAtIndex:indexPath.row];
        TLMyExpressionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLMyExpressionCell"];
        [cell setGroup:emojiGroup];
        [cell setDelegate:self];
        return cell;
    }
    else {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLSettingGroup *group = self.data[indexPath.section];
    if (group.headerTitle) {
        return 50.0f;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLSettingGroup *group = self.data[indexPath.section];
    if (group.headerTitle) {    // 有标题的就是表情组
        TLExpressionGroupModel *emojiGroup = [group objectAtIndex:indexPath.row];
        TLExpressionDetailViewController *detailVC = [[TLExpressionDetailViewController alloc] init];
        [detailVC setGroup:emojiGroup];
        PushVC(detailVC);
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

//MARK: TLMyExpressionCellDelegate
- (void)myExpressionCellDeleteButtonDown:(TLExpressionGroupModel *)group
{
    BOOL ok = [self.helper deleteExpressionGroupByID:group.gId];
    if (ok) {
        BOOL canDeleteFile = ![self.helper didExpressionGroupAlwaysInUsed:group.gId];
        if (canDeleteFile) {
            NSError *error;
            ok = [[NSFileManager defaultManager] removeItemAtPath:group.path error:&error];
            if (!ok) {
                DDLogError(@"删除表情文件失败\n路径:%@\n原因:%@", group.path, [error description]);
            }
        }
        
        NSInteger row = [self.data[0] indexOfObject:group];
        [self.data[0] removeObject:group];
        if ([self.data[0] count] == 0) {
            [self.data removeObjectAtIndex:0];
            [self.tableView beginUpdates];
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.tableView endUpdates];
        }
        else {
            [self.tableView beginUpdates];
            [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView endUpdates];
        }
    }
    else {
        [TLUIUtility showErrorHint:@"表情包删除失败"];
    }
}

#pragma mark - Event Response -
- (void)rightBarButtonDown:(UIBarButtonItem *)sender
{

}

@end
