//
//  TLMomentExtensionView+TableView.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentExtensionView+TableView.h"
#import "TLMomentExtensionCommentCell.h"

@implementation TLMomentExtensionView (TableView)

- (void)registerCellForTableView:(UITableView *)tableView
{
    [tableView registerClass:[TLMomentExtensionCommentCell class] forCellReuseIdentifier:@"TLMomentExtensionCommentCell"];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"EmptyCell"];
}

#pragma mark - # Delegate -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger section = 0;
    section += self.extension.likedFriends.count > 0 ? 1 : 0;
    section += self.extension.comments.count > 0 ? 1 : 0;
    return section;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.extension.likedFriends.count == 0 ? self.extension.likedFriends.count : self.extension.comments.count;
    }
    else if (section == 1) {
        return self.extension.comments.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    }
    else if (indexPath.section == 1) {
        TLMomentExtensionCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLMomentExtensionCommentCell"];
        return cell;
    }
    return [tableView dequeueReusableCellWithIdentifier:@"EmptyCell"];
}

@end
