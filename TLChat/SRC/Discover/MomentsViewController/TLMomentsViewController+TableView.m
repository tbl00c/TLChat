//
//  TLMomentsViewController+TableView.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/5.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentsViewController+TableView.h"
#import "TLMomentHeaderCell.h"
#import "TLMomentTextCell.h"
#import "TLMomentImagesCell.h"

@implementation TLMomentsViewController (TableView)

- (void)registerCellForTableView:(UITableView *)tableView
{
    [tableView registerClass:[TLMomentHeaderCell class] forCellReuseIdentifier:@"TLMomentHeaderCell"];
    [tableView registerClass:[TLMomentImagesCell class] forCellReuseIdentifier:@"TLMomentTextCell"];
    [tableView registerClass:[TLMomentImagesCell class] forCellReuseIdentifier:@"TLMomentImagesCell"];
    [tableView registerClass:[TLTableViewCell class] forCellReuseIdentifier:@"EmptyCell"];
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
    
    TLMoment *moment = [self.data objectAtIndex:indexPath.row - 1];
    id cell;
    if (moment.detail.images.count > 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TLMomentImagesCell"];
    }
    else if (moment.detail.text.length > 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"TLMomentTextCell"];
    }

    if (cell) {
        [cell setMoment:moment];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCell"];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 260.0f;
    }

    TLMoment *moment = [self.data objectAtIndex:indexPath.row - 1];
    return moment.momentFrame.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
