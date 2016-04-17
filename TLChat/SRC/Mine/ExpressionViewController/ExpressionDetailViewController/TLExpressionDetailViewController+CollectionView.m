//
//  TLExpressionDetailViewController+CollectionView.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionDetailViewController+CollectionView.h"
#import "TLExpressionHelper.h"
#import "TLExpressionItemCell.h"

#define         EDGE                20.0
#define         SPACE_CELL          15.0
#define         WIDTH_CELL          ((WIDTH_SCREEN - EDGE * 2 - SPACE_CELL * 3.0) / 4.0)

@implementation TLExpressionDetailViewController (CollectionView)

- (void)registerCellForCollectionView:(UICollectionView *)collectionView
{
    [collectionView registerClass:[TLExpressionItemCell class] forCellWithReuseIdentifier:@"TLExpressionItemCell"];
    [collectionView registerClass:[TLExpressionDetailCell class] forCellWithReuseIdentifier:@"TLExpressionDetailCell"];
}

#pragma mark - # Delegate -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.group.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        TLExpressionDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLExpressionDetailCell" forIndexPath:indexPath];
        [cell setGroup:self.group];
        [cell setDelegate:self];
        return cell;
    }
    TLExpressionItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLExpressionItemCell" forIndexPath:indexPath];
    TLEmoji *emoji = [self.group objectAtIndex:indexPath.row];
    [cell setEmoji:emoji];
    return cell;
}

//MARK: UICollectionDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(collectionView.width, 110);
    }
    else {
        return CGSizeMake(WIDTH_CELL, WIDTH_CELL);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return section == 0 ? 0 : SPACE_CELL;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return section == 0 ? 0 : SPACE_CELL;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return section == 0 ? UIEdgeInsetsZero : UIEdgeInsetsMake(EDGE, EDGE, EDGE, EDGE);
}

//MAKR: TLExpressionDetailCellDelegate
- (void)expressionDetailCellDownloadButtonDown:(TLEmojiGroup *)group
{
    [[TLExpressionHelper sharedHelper] downloadExpressionsWithGroupInfo:group progress:^(CGFloat progress) {
        
    } success:^(TLEmojiGroup *group) {
        group.status = TLEmojiGroupStatusDownloaded;
        [self.collectionView reloadData];
        [SVProgressHUD showSuccessWithStatus:[NSString stringWithFormat:@"\"%@\" 下载成功！", group.groupName]];
        BOOL ok = [[TLExpressionHelper sharedHelper] addExpressionGroup:group];
        if (!ok) {
            DDLogError(@"表情 %@ 存储失败！", group.groupName);
        }
    } failure:^(TLEmojiGroup *group, NSString *error) {
        group.status = TLEmojiGroupStatusUnDownload;
        [self.collectionView reloadData];
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"\"%@\" 下载失败: %@", group.groupName, error]];
    }];
}

@end
