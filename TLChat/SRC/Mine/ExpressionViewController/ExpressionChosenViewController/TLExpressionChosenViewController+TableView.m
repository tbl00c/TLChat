//
//  TLExpressionChosenViewController+TableView.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionChosenViewController+TableView.h"
#import "TLExpressionCell.h"

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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return HEGIHT_EXPCELL;
}

@end
