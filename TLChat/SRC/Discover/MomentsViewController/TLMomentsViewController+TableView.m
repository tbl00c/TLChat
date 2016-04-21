//
//  TLMomentsViewController+TableView.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/5.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentsViewController+TableView.h"
#import "TLMomentHeaderCell.h"
#import "TLMomentImagesCell.h"

@implementation TLMomentsViewController (TableView)

- (void)registerCellForTableView:(UITableView *)tableView
{
    [tableView registerClass:[TLMomentHeaderCell class] forCellReuseIdentifier:@"TLMomentHeaderCell"];
    [tableView registerClass:[TLMomentImagesCell class] forCellReuseIdentifier:@"TLMomentImagesCell"];
}

#pragma mark - # Delegate -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        TLMomentHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLMomentHeaderCell"];
        [cell setUser:[TLUserHelper sharedHelper].user];
        return cell;
    }
    TLMomentImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLMomentImagesCell"];
    TLMoment *moment = [self.data objectAtIndex:indexPath.row - 1];
    [cell setMoment:moment];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 260.0f;
    }

    TLMoment *moment = [self.data objectAtIndex:indexPath.row - 1];
    return moment.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
