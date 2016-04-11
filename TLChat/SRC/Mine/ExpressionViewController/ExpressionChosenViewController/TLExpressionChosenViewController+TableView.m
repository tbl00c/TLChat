//
//  TLExpressionChosenViewController+TableView.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionChosenViewController+TableView.h"
#import "TLExpressionDetailViewController.h"
#import "TLDBExpressionStore.h"

@implementation TLExpressionChosenViewController (TableView)

- (void)registerCellsForTableView:(UITableView *)tableView
{
    [tableView registerClass:[TLExpressionCell class] forCellReuseIdentifier:@"TLExpressionCell"];
}

#pragma mark - # Delegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLExpressionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLExpressionCell"];
    TLEmojiGroup *group = self.data[indexPath.row];
    [cell setGroup:group];
    [cell setDelegate:self];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLEmojiGroup *group = [self.data objectAtIndex:indexPath.row];
    TLExpressionDetailViewController *detailVC = [[TLExpressionDetailViewController alloc] init];
    [detailVC setGroup:group];
    [self.parentViewController setHidesBottomBarWhenPushed:YES];
    [self.parentViewController.navigationController pushViewController:detailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEGIHT_EXPCELL;
}

//MARK: TLExpressionCellDelegate
- (void)expressionCellDownloadButtonDown:(TLEmojiGroup *)group
{
    [self.proxy requestExpressionGroupDetailByGroupID:group.groupID pageIndex:1 success:^(id data) {
        group.data = data;
        [[TLExpressionHelper sharedHelper] downloadExpressionsWithGroupInfo:group progress:^(CGFloat progress) {
            
        } success:^(TLEmojiGroup *group) {
            [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"\"%@\" 下载成功！", group.groupName]];
            TLDBExpressionStore *store = [[TLDBExpressionStore alloc] init];
            BOOL ok = [store addExpressionGroup:group forUid:[TLUserHelper sharedHelper].userID];
            if (!ok) {
                DDLogError(@"表情 %@ 存入用户表情数据库失败！", group.groupName);
            }
        } failure:^(TLEmojiGroup *group, NSString *error) {
            
        }];
    } failure:^(NSString *error) {
        
    }];
}

@end
