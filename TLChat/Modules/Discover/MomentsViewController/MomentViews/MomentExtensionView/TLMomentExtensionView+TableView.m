//
//  TLMomentExtensionView+TableView.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentExtensionView+TableView.h"
#import "TLMomentExtensionCommentCell.h"
#import "TLMomentExtensionLikedCell.h"

@implementation TLMomentExtensionView (TableView)

- (void)registerCellForTableView:(UITableView *)tableView
{
    [tableView registerClass:[TLMomentExtensionCommentCell class] forCellReuseIdentifier:@"TLMomentExtensionCommentCell"];
    [tableView registerClass:[TLMomentExtensionLikedCell class] forCellReuseIdentifier:@"TLMomentExtensionLikedCell"];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"EmptyCell"];
}

#pragma mark - # Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger section = self.extension.likedFriends.count > 0 ? 1 : 0;
    section += self.extension.comments.count > 0 ? 1 : 0;
    return section;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 && self.extension.likedFriends.count > 0) {
        return 1;
    }
    else {
        return self.extension.comments.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && self.extension.likedFriends.count > 0) {  // 点赞
        TLMomentExtensionLikedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLMomentExtensionLikedCell"];
        [cell setLikedFriends:self.extension.likedFriends];
        [cell setShowBottomLine:self.extension.comments.count > 0];
        return cell;
    }
    else {      // 评论
        TLMomentComment *comment = [self.extension.comments objectAtIndex:indexPath.row];
        TLMomentExtensionCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLMomentExtensionCommentCell"];
        [cell setComment:comment];
        return cell;
    }
    return [tableView dequeueReusableCellWithIdentifier:@"EmptyCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && self.extension.likedFriends.count > 0) {
        return self.extension.extensionFrame.heightLiked;
    }
    else {
        TLMomentComment *comment = [self.extension.comments objectAtIndex:indexPath.row];
        return comment.commentFrame.height;
    }
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
