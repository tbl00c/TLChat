//
//  TLMomentsViewController+TableView.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/5.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentsViewController+TableView.h"
#import "TLMomentsHeaderCell.h"

@implementation TLMomentsViewController (TableView)

- (void)registerCellForTableView:(UITableView *)tableView
{
    [tableView registerClass:[TLMomentsHeaderCell class] forCellReuseIdentifier:@"TLMomentsHeaderCell"];
}

#pragma mark - # Delegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TLMomentsHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLMomentsHeaderCell"];
        [cell setUser:[TLUserHelper sharedHelper].user];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 260.0f;
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
