//
//  TLFriendDetailViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendDetailViewController.h"
#import "TLFriendDetailUserCell.h"
#import "TLFriendDetailAlbumCell.h"
#import "TLUser.h"

#define     HEIGHT_USER_CELL           90.0f
#define     HEIGHT_ALBUM_CELL          80.0f

@implementation TLFriendDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"详细资料"];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_more"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonDown:)];
    [self.navigationItem setRightBarButtonItem:rightBarButton];
    
    [self.tableView registerClass:[TLFriendDetailUserCell class] forCellReuseIdentifier:@"TLFriendDetailUserCell"];
    [self.tableView registerClass:[TLFriendDetailAlbumCell class] forCellReuseIdentifier:@"TLFriendDetailAlbumCell"];
    
    
    TLInfo *usr = [[TLInfo alloc] init];
    [usr setType:TLInfoTypeOther];
    usr.userInfo = self.user;
    
    TLInfo *tel = [TLInfo createInfoWithTitle:@"电话号码" subTitle:@"18888888888"];
    [tel setShowDisclosureIndicator:NO];
    
    TLInfo *pos = [TLInfo createInfoWithTitle:@"地区" subTitle:@"山东 青岛"];
    [pos setShowDisclosureIndicator:NO];
    
    TLInfo *btn1 = [[TLInfo alloc] init];
    btn1.title = @"发消息";
    btn1.type = TLInfoTypeButton;
    btn1.titleColor = [UIColor whiteColor];
    TLInfo *btn2 = [[TLInfo alloc] init];
    btn2.type = TLInfoTypeButton;
    btn2.title = @"视频聊天";
    btn2.buttonColor = [UIColor whiteColor];
    
    TLInfo *album = [[TLInfo alloc] init];
    album.title = @"个人相册";
    album.type = TLInfoTypeOther;
    
    NSArray *arr = @[@[usr],
                     @[tel,
                       [TLInfo createInfoWithTitle:@"标签" subTitle:@"同学"]],
                     @[pos,
                       album,
                       [TLInfo createInfoWithTitle:@"更多" subTitle:nil]],
                     @[btn1, btn2]];
    self.data = [NSMutableArray arrayWithArray:arr];
}

#pragma mark - Delegate -
//MARK: UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLInfo *info = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    if (info.type == TLInfoTypeOther) {
        if (indexPath.section == 0) {
            TLFriendDetailUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLFriendDetailUserCell"];
            [cell setInfo:info];
            [cell setTopLineStyle:TLCellLineStyleFill];
            [cell setBottomLineStyle:TLCellLineStyleFill];
            return cell;
        }
        else {
            TLFriendDetailAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLFriendDetailAlbumCell"];
            [cell setInfo:info];
            return cell;
        }
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}
//MARK: UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TLInfo *info = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    if (info.type == TLInfoTypeOther) {
        if (indexPath.section == 0) {
            return HEIGHT_USER_CELL;
        }
        return HEIGHT_ALBUM_CELL;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

#pragma mark - Event Response -
- (void)rightBarButtonDown:(UIBarButtonItem *)sender
{

}

@end
