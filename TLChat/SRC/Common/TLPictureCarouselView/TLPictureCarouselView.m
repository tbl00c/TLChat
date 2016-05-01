//
//  TLPictureCarouselView.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLPictureCarouselView.h"
#import "TLPictureCarouselViewCell.h"
#import "UIScrollView+Pages.h"

@interface TLPictureCarouselView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSTimer *timer;


@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation TLPictureCarouselView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.timeInterval = DEFAULT_TIMEINTERVAL;
        [self addSubview:self.collectionView];
        
        [self p_addMasonry];
        
        [self.collectionView registerClass:[TLPictureCarouselViewCell class] forCellWithReuseIdentifier:@"TLPictureCarouselViewCell"];
    }
    return self;
}

- (void)setData:(NSArray *)data
{
    _data = data;
    [self.collectionView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView setPageX:1 animated:NO];
        if (self.timer == nil && self.data.count > 1) {
            __weak typeof(self) weakSelf = self;
            self.timer = [NSTimer bk_scheduledTimerWithTimeInterval:2.0 block:^(NSTimer *tm) {
                [weakSelf scrollToNextPage];
            } repeats:YES];
        }
    });
}

- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - # Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count == 0 ? 0 : self.data.count + 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row == 0 ? self.data.count - 1 : (indexPath.row == self.data.count + 1 ? 0 : indexPath.row - 1);
    id<TLPictureCarouselProtocol> model = self.data[row];
    TLPictureCarouselViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLPictureCarouselViewCell" forIndexPath:indexPath];
    [cell setModel:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row == 0 ? self.data.count - 1 : (indexPath.row == self.data.count - 1 ? 0 : indexPath.row - 1);
    id<TLPictureCarouselProtocol> model = self.data[row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(pictureCarouselView:didSelectItem:)]) {
        [self.delegate pictureCarouselView:self didSelectItem:model];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.size;
}

//MARK: UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.timer == nil && self.data.count > 1) {
        __weak typeof(self) weakSelf = self;
        self.timer = [NSTimer bk_scheduledTimerWithTimeInterval:2.0 block:^(NSTimer *tm) {
            [weakSelf scrollToNextPage];
        } repeats:YES];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 轮播实现
    if (scrollView.currentPageX == 0) {
        [scrollView setPageX:self.data.count animated:NO];
    }
    else if (scrollView.currentPageX == self.data.count + 1) {
        [scrollView setPageX:1 animated:NO];
    }
}

#pragma mark - # Event Response
- (void)scrollToNextPage
{
    NSInteger nextPage;
    if (self.collectionView.currentPageX == self.data.count) {
        [self.collectionView setPageX:0 animated:NO];
        nextPage = 1;
    }
    else {
        nextPage = self.collectionView.currentPageX + 1;
    }
    [self.collectionView setPageX:nextPage animated:YES];
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

#pragma mark - # Getter
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        [layout setMinimumLineSpacing:0];
        [layout setMinimumInteritemSpacing:0];
        [layout setSectionInset:UIEdgeInsetsZero];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        [_collectionView setShowsVerticalScrollIndicator:NO];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setPagingEnabled:YES];
        [_collectionView setScrollsToTop:NO];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
    }
    return _collectionView;
}

@end
