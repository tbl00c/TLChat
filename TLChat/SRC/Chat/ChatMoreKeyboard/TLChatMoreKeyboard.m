//
//  TLChatMoreKeyboard.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatMoreKeyboard.h"
#import "TLChatMacros.h"
#import "TLChatMoreKeyboardCell.h"

#define     HEIGHT_COLLECTIONVIEW       HEIGHT_CHAT_KEYBOARD * 0.85
#define     HEIGHT_PAGECONTROL          HEIGHT_CHAT_KEYBOARD * 0.14
#define     WIDTH_COLLECTION_CELL       60

static TLChatMoreKeyboard *moreKB;

@interface TLChatMoreKeyboard () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation TLChatMoreKeyboard

+ (TLChatMoreKeyboard *)keyboard
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        moreKB = [[TLChatMoreKeyboard alloc] init];
    });
    return moreKB;
}

- (id) init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor colorChatBox]];
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
        [self p_addMasonry];
        [self.collectionView registerClass:[TLChatMoreKeyboardCell class] forCellWithReuseIdentifier:@"TLChatMoreKeyboardCell"];
    }
    return self;
}

#pragma mark - Public Methods -
- (void) showInView:(UIView *)view withAnimation:(BOOL)animation;
{
    if (_delegate && [_delegate respondsToSelector:@selector(chatKeyboardWillShow:)]) {
        [_delegate chatKeyboardWillShow:self];
    }
    [view addSubview:self];
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(view);
        make.height.mas_equalTo(HEIGHT_CHAT_KEYBOARD);
        make.bottom.mas_equalTo(view).mas_offset(HEIGHT_CHAT_KEYBOARD);
    }];
    [view layoutIfNeeded];
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(view);
            }];
            [view layoutIfNeeded];
            if (_delegate && [_delegate respondsToSelector:@selector(chatKeyboard:didChangeHeight:)]) {
                [_delegate chatKeyboard:self didChangeHeight:view.height - self.y];
            }
        } completion:^(BOOL finished) {
            if (_delegate && [_delegate respondsToSelector:@selector(chatKeyboardDidShow:)]) {
                [_delegate chatKeyboardDidShow:self];
            }
        }];
    }
    else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(view);
        }];
        [view layoutIfNeeded];
        if (_delegate && [_delegate respondsToSelector:@selector(chatKeyboardDidShow:)]) {
            [_delegate chatKeyboardDidShow:self];
        }
    }
}

- (void) dismissWithAnimation:(BOOL)animation
{
    if (_delegate && [_delegate respondsToSelector:@selector(chatKeyboardWillDismiss:)]) {
        [_delegate chatKeyboardWillDismiss:self];
    }
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.superview).mas_offset(HEIGHT_CHAT_KEYBOARD);
            }];
            [self.superview layoutIfNeeded];
            if (_delegate && [_delegate respondsToSelector:@selector(chatKeyboard:didChangeHeight:)]) {
                [_delegate chatKeyboard:self didChangeHeight:self.superview.height - self.y];
            }
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if (_delegate && [_delegate respondsToSelector:@selector(chatKeyboardDidDismiss:)]) {
                [_delegate chatKeyboardDidDismiss:self];
            }
        }];
    }
    else {
        [self removeFromSuperview];
        if (_delegate && [_delegate respondsToSelector:@selector(chatKeyboardDidDismiss:)]) {
            [_delegate chatKeyboardDidDismiss:self];
        }
    }
}

- (void)reset
{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, self.collectionView.width, self.collectionView.height) animated:NO];
}

- (void) setChatMoreKeyboardData:(NSMutableArray *)chatMoreKeyboardData
{
    _chatMoreKeyboardData = chatMoreKeyboardData;
    [self.collectionView reloadData];
    NSUInteger pageNumber = chatMoreKeyboardData.count / 8 + (chatMoreKeyboardData.count % 8 == 0 ? 0 : 1);
    [self.pageControl setNumberOfPages:pageNumber];
}

#pragma mark - Delegate -
//MARK: UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.chatMoreKeyboardData.count / 8 + (self.chatMoreKeyboardData.count % 8 == 0 ? 0 : 1);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLChatMoreKeyboardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLChatMoreKeyboardCell" forIndexPath:indexPath];
    NSUInteger index = indexPath.section * 8 + indexPath.row;
    NSUInteger tIndex = [self p_transformIndex:index];  // 矩阵坐标转置
    if (tIndex >= self.chatMoreKeyboardData.count) {
        [cell setItem:nil];
    }
    else {
        [cell setItem:self.chatMoreKeyboardData[tIndex]];
    }
    __weak typeof(self) weakSelf = self;
    [cell setClickBlock:^(TLChatMoreKeyboardItem *sItem) {
        if (_delegate && [_delegate respondsToSelector:@selector(chatKeyboard:didSelectedFunctionItem:)]) {
            [_delegate chatKeyboard:weakSelf didSelectedFunctionItem:sItem];
        }
    }];
    return cell;
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.pageControl setCurrentPage:(int)(scrollView.contentOffset.x / WIDTH_SCREEN)];
}

#pragma mark - Event Response -
- (void) pageControlChanged:(UIPageControl *)pageControl
{
    [self.collectionView scrollRectToVisible:CGRectMake(WIDTH_SCREEN * pageControl.currentPage, 0, WIDTH_SCREEN, HEIGHT_PAGECONTROL) animated:YES];
}

#pragma mark - Private Methods -
- (NSUInteger)p_transformIndex:(NSUInteger)index
{
    NSUInteger page = index / 8;
    index = index % 8;
    NSUInteger x = index / 2;
    NSUInteger y = index % 2;
    return 4 * y + x + page * 8;
}

- (void)p_addMasonry
{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(3);
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(HEIGHT_COLLECTIONVIEW);
    }];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(self);
        make.height.mas_equalTo(HEIGHT_PAGECONTROL);
    }];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor colorChatBoxLine].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, WIDTH_SCREEN, 0);
    CGContextStrokePath(context);
}

#pragma mark - Getter -
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        float h = HEIGHT_COLLECTIONVIEW / 2 * 0.885;
        float spaceX = (WIDTH_SCREEN - WIDTH_COLLECTION_CELL * 4) / 5;
        float spaceY = (HEIGHT_COLLECTIONVIEW - h * 2) / 2;
        [layout setItemSize:CGSizeMake(WIDTH_COLLECTION_CELL, h)];
        [layout setSectionInset:UIEdgeInsetsMake(spaceY, 0, 0, 0)];
        [layout setMinimumLineSpacing:spaceX];
        [layout setHeaderReferenceSize:CGSizeMake(spaceX, HEIGHT_COLLECTIONVIEW)];
        [layout setFooterReferenceSize:CGSizeMake(spaceX, HEIGHT_COLLECTIONVIEW)];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView setPagingEnabled:YES];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setScrollsToTop:YES];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.centerX = self.centerX;
        [_pageControl setPageIndicatorTintColor:[UIColor colorChatBoxLine]];
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor grayColor]];
        [_pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

@end
