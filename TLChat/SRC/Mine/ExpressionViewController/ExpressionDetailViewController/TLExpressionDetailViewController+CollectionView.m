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

- (void)didLongPressScreen:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {        // 长按停止
        [self.emojiDisplayView removeFromSuperview];
    }
    else {
        CGPoint point = [sender locationInView:self.collectionView];
        for (UICollectionViewCell *cell in self.collectionView.visibleCells) {
            if (cell.x <= point.x && cell.y <= point.y && cell.x + cell.width >= point.x && cell.y + cell.height >= point.y) {
                NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
                TLEmoji *emoji = [self.group objectAtIndex:indexPath.row];
                CGRect rect = cell.frame;
                rect.origin.y -= (self.collectionView.contentOffset.y + 13);
                [self.emojiDisplayView removeFromSuperview];
                [self.emojiDisplayView displayEmoji:emoji atRect:rect];
                [self.view addSubview:self.emojiDisplayView];
                break;
            }
        }
    }
}

- (void)didTap5TimesScreen:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.collectionView];
    for (UICollectionViewCell *cell in self.collectionView.visibleCells) {
        if (cell.x <= point.x && cell.y <= point.y && cell.x + cell.width >= point.x && cell.y + cell.height >= point.y) {
            NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
            TLEmoji *emoji = [self.group objectAtIndex:indexPath.row];
            [SVProgressHUD showWithStatus:@"正在将表情保存到系统相册"];
            NSString *urlString = [TLHost expressionDownloadURLWithEid:emoji.emojiID];
            NSData *data = [NSData dataWithContentsOfURL:TLURL(urlString)];
            if (!data) {
                data = [NSData dataWithContentsOfFile:emoji.emojiPath];
            }
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
            }
            break;
        }
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [UIAlertView bk_alertViewWithTitle:@"错误" message:[NSString stringWithFormat:@"保存图片到系统相册失败\n%@", [error description]]];
    }
    else {
        [SVProgressHUD showSuccessWithStatus:@"已保存到系统相册"];
    }
}

#pragma mark - # Delegate
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
        CGFloat height = [TLExpressionDetailCell cellHeightForModel:self.group];
        return CGSizeMake(collectionView.width, height);
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
        BOOL ok = [[TLExpressionHelper sharedHelper] addExpressionGroup:group];
        if (!ok) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"表情 %@ 存储失败！", group.groupName]];
        }
    } failure:^(TLEmojiGroup *group, NSString *error) {
        group.status = TLEmojiGroupStatusUnDownload;
        [self.collectionView reloadData];
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"\"%@\" 下载失败: %@", group.groupName, error]];
    }];
}

@end
