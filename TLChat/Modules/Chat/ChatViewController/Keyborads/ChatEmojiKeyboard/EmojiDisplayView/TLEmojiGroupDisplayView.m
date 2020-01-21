//
//  TLEmojiGroupDisplayView.m
//  TLChat
//
//  Created by 李伯坤 on 16/9/27.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiGroupDisplayView.h"
#import "TLEmojiGroupDisplayView+CollectionView.h"
#import "TLEmojiGroupDisplayView+Gesture.h"
#import "TLExpressionGroupModel+TLEmojiKB.h"

@implementation TLEmojiGroupDisplayView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        
        [self registerCellClass];
        [self addGusture];
    }
    return self;
}

- (void)setData:(NSMutableArray *)data
{
    if (data && _data && [_data isEqualToArray:data]) {
        return;
    }
    _data = data;
    
    self.height = HEIGHT_CHAT_KEYBOARD - 57;
    self.width = SCREEN_WIDTH;
    
    NSMutableArray *displayData = [[NSMutableArray alloc] init];
    for (NSInteger emojiGroupIndex = 0; emojiGroupIndex < data.count; emojiGroupIndex++) {
        TLExpressionGroupModel *group = data[emojiGroupIndex];
        if (group.count > 0) {      // 已下载的表情包
            NSInteger cellWidth, cellHeight;
            CGFloat spaceX, spaceYTop, spaceYBottom;
            cellWidth = ((self.width - 20) / group.colNumber);
            spaceX = (self.width - cellWidth * group.colNumber) / 2.0;
            if (group.type == TLEmojiTypeEmoji || group.type == TLEmojiTypeFace) {
                cellHeight = (self.height - 15) / group.rowNumber;
                spaceYTop = 10;
            }
            else if (group.type == TLEmojiTypeImageWithTitle) {
                cellHeight = (self.height - 10) / group.rowNumber;
                spaceYTop = 10;
            }
            else {
                cellHeight = (self.height - 40) / group.rowNumber;
                spaceYTop = 20;
            }
            spaceYBottom = (self.height - cellHeight * group.rowNumber) - spaceYTop;
            for (NSInteger pageIndex = 0; pageIndex < group.pageNumber; pageIndex++) {
                TLEmojiGroupDisplayModel *model = [[TLEmojiGroupDisplayModel alloc] initWithEmojiGroup:group pageNumber:pageIndex andCount:group.pageItemCount];
                if (model.type == TLEmojiTypeEmoji || group.type == TLEmojiTypeFace) {     // 为默认表情包添加删除按钮
                    TLExpressionModel *emoji = [[TLExpressionModel alloc] init];
                    emoji.eId = @"-1";
                    emoji.name = @"del";
                    [model addEmoji:emoji];
                    model.pageItemCount ++;
                }
                model.emojiGroupIndex = emojiGroupIndex;
                model.pageIndex = pageIndex;
                model.cellSize = CGSizeMake(cellWidth, cellHeight);
                model.sectionInsets = UIEdgeInsetsMake(spaceYTop, spaceX, spaceYBottom, spaceX);
                [displayData addObject:model];
            }
        }
    }
    self.displayData = displayData;
    [self.collectionView reloadData];
    if (self.displayData.count > 0 && self.delegate && [self.delegate respondsToSelector:@selector(emojiGroupDisplayView:didScrollToPageIndex:forGroupIndex:)]) {
        TLEmojiGroupDisplayModel *group = self.displayData[0];
        [self.collectionView setContentOffset:CGPointZero];
        [self.delegate emojiGroupDisplayView:self didScrollToPageIndex:0 forGroupIndex:group.emojiGroupIndex];
    }
}

- (void)scrollToEmojiGroupAtIndex:(NSInteger)index
{
    if (index > self.data.count) {
        return;
    }
    _curPageIndex = index;
    NSInteger page = 0;
    for (int i = 0; i < index; i ++) {
        TLExpressionGroupModel *group = self.data[i];
        page += group.pageNumber;
    }
    [self.collectionView setContentOffset:CGPointMake(page * self.collectionView.width, 0)];
    if (self.displayData.count > page) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(emojiGroupDisplayView:didScrollToPageIndex:forGroupIndex:)]) {
            TLEmojiGroupDisplayModel *group = self.displayData[page];
            [self.delegate emojiGroupDisplayView:self didScrollToPageIndex:0 forGroupIndex:group.emojiGroupIndex];
        }
    }
}

#pragma mark - # Getter
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView setPagingEnabled:YES];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setScrollsToTop:NO];
    }
    return _collectionView;
}

@end
