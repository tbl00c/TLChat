//
//  TLMyExpressionViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMyExpressionViewController.h"
#import "TLMineExpressionHelper.h"
#import "TLMyExpressionCell.h"

@interface TLMyExpressionViewController () <TLMyExpressionCellDelegate>

@property (nonatomic, strong) TLMineExpressionHelper *mineHelper;

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
    
    self.mineHelper = [[TLMineExpressionHelper alloc] init];
    self.data = [self.mineHelper myExpressionDataByUserID:[TLUserHelper sharedHelper].userID];
}

#pragma mark - Delegate -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLSettingGroup *group = self.data[indexPath.section];
    if (group.headerTitle) {
        TLEmojiGroup *emojiGroup = [group objectAtIndex:indexPath.row];
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

//MARK: TLMyExpressionCellDelegate
- (void)myExpressionCellDeleteButtonDown:(TLEmojiGroup *)group
{
    
}

#pragma mark - Event Response -
- (void)rightBarButtonDown:(UIBarButtonItem *)sender
{

}

@end
