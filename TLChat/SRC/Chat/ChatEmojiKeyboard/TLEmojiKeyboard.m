//
//  TLEmojiKeyboard.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiKeyboard.h"
#import "TLChatMacros.h"
#import "TLEmojiKBHelper.h"
#import "TLEmojiGroupControl.h"
#import "TLEmojiItemCell.h"
#import "TLEmojiImageItemCell.h"
#import "TLEmojiImageTitleItemCell.h"

#define     HEIGHT_TOP_SPACE            10
#define     HEIGHT_EMOJIVIEW            (HEIGHT_CHAT_KEYBOARD * 0.75 - HEIGHT_TOP_SPACE)
#define     HEIGHT_PAGECONTROL          HEIGHT_CHAT_KEYBOARD * 0.1
#define     HEIGHT_GROUPCONTROL         HEIGHT_CHAT_KEYBOARD * 0.17

static TLEmojiKeyboard *emojiKB;

@interface TLEmojiKeyboard () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, TLEmojiGroupControlDelegate>
{
    CGSize cellSize;
    CGSize headerReferenceSize;
    CGSize footerReferenceSize;
    CGFloat minimumLineSpacing;
    CGFloat minimumInteritemSpacing;
    UIEdgeInsets sectionInsets;
}

@property (nonatomic, strong) TLEmojiGroup *curGroup;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) TLEmojiGroupControl *groupControl;

@end

@implementation TLEmojiKeyboard

+ (TLEmojiKeyboard *)keyboard
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        emojiKB = [[TLEmojiKeyboard alloc] init];
    });
    return emojiKB;
}

- (id) init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor colorChatBox]];
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
        [self addSubview:self.groupControl];
        [self p_addMasonry];
        
        [self.collectionView registerClass:[TLEmojiItemCell class] forCellWithReuseIdentifier:@"TLEmojiItemCell"];
        [self.collectionView registerClass:[TLEmojiImageItemCell class] forCellWithReuseIdentifier:@"TLEmojiImageItemCell"];
        [self.collectionView registerClass:[TLEmojiImageTitleItemCell class] forCellWithReuseIdentifier:@"TLEmojiImageTitleItemCell"];
    }
    return self;
}

- (void) setEmojiGroupData:(NSMutableArray *)emojiGroupData
{
    [self.groupControl setEmojiGroupData:emojiGroupData];
}

#pragma mark - Public Methods -
- (void) showInView:(UIView *)view withAnimation:(BOOL)animation;
{
    if (_keyboardDelegate && [_keyboardDelegate respondsToSelector:@selector(chatKeyboardWillShow:)]) {
        [_keyboardDelegate chatKeyboardWillShow:self];
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
            if (_keyboardDelegate && [_keyboardDelegate respondsToSelector:@selector(chatKeyboard:didChangeHeight:)]) {
                [_keyboardDelegate chatKeyboard:self didChangeHeight:view.height - self.y];
            }
        } completion:^(BOOL finished) {
            if (_keyboardDelegate && [_keyboardDelegate respondsToSelector:@selector(chatKeyboardDidShow:)]) {
                [_keyboardDelegate chatKeyboardDidShow:self];
            }
        }];
    }
    else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(view);
        }];
        [view layoutIfNeeded];
        if (_keyboardDelegate && [_keyboardDelegate respondsToSelector:@selector(chatKeyboardDidShow:)]) {
            [_keyboardDelegate chatKeyboardDidShow:self];
        }
    }
}

- (void) dismissWithAnimation:(BOOL)animation
{
    if (_keyboardDelegate && [_keyboardDelegate respondsToSelector:@selector(chatKeyboardWillDismiss:)]) {
        [_keyboardDelegate chatKeyboardWillDismiss:self];
    }
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.superview).mas_offset(HEIGHT_CHAT_KEYBOARD);
            }];
            [self.superview layoutIfNeeded];
            if (_keyboardDelegate && [_keyboardDelegate respondsToSelector:@selector(chatKeyboard:didChangeHeight:)]) {
                [_keyboardDelegate chatKeyboard:self didChangeHeight:self.superview.height - self.y];
            }
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            if (_keyboardDelegate && [_keyboardDelegate respondsToSelector:@selector(chatKeyboardDidDismiss:)]) {
                [_keyboardDelegate chatKeyboardDidDismiss:self];
            }
        }];
    }
    else {
        [self removeFromSuperview];
        if (_keyboardDelegate && [_keyboardDelegate respondsToSelector:@selector(chatKeyboardDidDismiss:)]) {
            [_keyboardDelegate chatKeyboardDidDismiss:self];
        }
    }
}

- (void)reset
{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, self.collectionView.width, self.collectionView.height) animated:NO];
}

#pragma mark - Delegate -
//MARK: UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.curGroup.pageNumber;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.curGroup.pageItemNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger index = indexPath.section * self.curGroup.pageItemNumber + indexPath.row;
    id cell;
    if (self.curGroup.type == TLEmojiGroupTypeEmoji) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLEmojiItemCell" forIndexPath:indexPath];
    }
    else if (self.curGroup.type == TLEmojiGroupTypeImageWithTitle) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLEmojiImageTitleItemCell" forIndexPath:indexPath];
    }
    else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLEmojiImageItemCell" forIndexPath:indexPath];
    }
    NSUInteger tIndex = [self p_transformIndex:index];  // 矩阵坐标转置
    TLEmoji *emojiItem = self.curGroup.count > tIndex ? [self.curGroup objectAtIndex:tIndex] : nil;
    [cell setEmojiItem:emojiItem];
    return cell;
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.pageControl setCurrentPage:(int)(scrollView.contentOffset.x / WIDTH_SCREEN)];
}

//MARK: UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return cellSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return headerReferenceSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return footerReferenceSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return minimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return minimumInteritemSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return sectionInsets;
}

//MARK: TLEmojiGroupControlDelegate
- (void)emojiGroupControl:(TLEmojiGroupControl *)emojiGroupControl didSelectedGroup:(TLEmojiGroup *)group
{
    if (group.data == nil) {
        group.data = [TLEmojiKBHelper getEmojiDataByPath:group.dataPath];
    }
    self.curGroup = group;
    [self p_resetCollectionSize];
    [self.pageControl setNumberOfPages:group.pageNumber];
    [self.pageControl setCurrentPage:0];
    [self.collectionView reloadData];
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, self.collectionView.width, self.collectionView.height) animated:NO];
}

#pragma mark - Event Response -
- (void) pageControlChanged:(UIPageControl *)pageControl
{
    [self.collectionView scrollRectToVisible:CGRectMake(WIDTH_SCREEN * pageControl.currentPage, 0, WIDTH_SCREEN, HEIGHT_PAGECONTROL) animated:YES];
}

#pragma mark - Private Methods -
- (void)p_resetCollectionSize
{
    float cellHeight;
    float cellWidth;
    float topSpace = 0;
    float btmSpace = 0;
    float hfSpace = 0;
    if (self.curGroup.type == TLEmojiGroupTypeFace || self.curGroup.type == TLEmojiGroupTypeEmoji) {
        cellWidth = cellHeight = (HEIGHT_EMOJIVIEW / self.curGroup.lineNumber) * 0.55;
        topSpace = 11;
        btmSpace = 19;
        hfSpace = (WIDTH_SCREEN - cellWidth * self.curGroup.rowNumber) / (self.curGroup.rowNumber + 1) * 1.4;
    }
    else if (self.curGroup.type == TLEmojiGroupTypeImageWithTitle){
        cellHeight = (HEIGHT_EMOJIVIEW / self.curGroup.lineNumber) * 0.96;
        cellWidth = cellHeight * 0.75;
        hfSpace = (WIDTH_SCREEN - cellWidth * self.curGroup.rowNumber) / (self.curGroup.rowNumber + 1) * 1.2;
    }
    else {
        cellWidth = cellHeight = (HEIGHT_EMOJIVIEW / self.curGroup.lineNumber) * 0.72;
        topSpace = 8;
        btmSpace = 16;
        hfSpace = (WIDTH_SCREEN - cellWidth * self.curGroup.rowNumber) / (self.curGroup.rowNumber + 1) * 1.2;
    }
    
    cellSize = CGSizeMake(cellWidth, cellHeight);
    headerReferenceSize = CGSizeMake(hfSpace, HEIGHT_EMOJIVIEW);
    footerReferenceSize = CGSizeMake(hfSpace, HEIGHT_EMOJIVIEW);
    minimumLineSpacing = (WIDTH_SCREEN - hfSpace * 2 - cellWidth * self.curGroup.rowNumber) / (self.curGroup.rowNumber - 1);
    minimumInteritemSpacing = (HEIGHT_EMOJIVIEW - topSpace - btmSpace - cellHeight * self.curGroup.lineNumber) / (self.curGroup.lineNumber - 1);
    sectionInsets = UIEdgeInsetsMake(topSpace, 0, btmSpace, 0);
}

- (NSUInteger)p_transformIndex:(NSUInteger)index
{
    NSUInteger page = index / self.curGroup.pageItemNumber;
    index = index % self.curGroup.pageItemNumber;
    NSUInteger x = index / self.curGroup.lineNumber;
    NSUInteger y = index % self.curGroup.lineNumber;
    return self.curGroup.rowNumber * y + x + page * self.curGroup.pageItemNumber;
}

- (void)p_addMasonry
{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(HEIGHT_TOP_SPACE);
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(HEIGHT_EMOJIVIEW);
    }];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.groupControl.mas_top);
        make.height.mas_equalTo(HEIGHT_PAGECONTROL);
    }];
    [self.groupControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(self);
        make.height.mas_equalTo(HEIGHT_GROUPCONTROL);
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

- (TLEmojiGroupControl *)groupControl
{
    if (_groupControl == nil) {
        _groupControl = [[TLEmojiGroupControl alloc] init];
        [_groupControl setDelegate:self];
    }
    return _groupControl;
}

@end
