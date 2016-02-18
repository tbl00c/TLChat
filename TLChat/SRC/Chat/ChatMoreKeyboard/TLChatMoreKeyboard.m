//
//  TLChatMoreKeyboard.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatMoreKeyboard.h"
#import "TLChatMoreKeyboardCell.h"

#define     HEIGHT_COLLECTIONVIEW       HEIGHT_CHAT_KEYBOARD * 0.87
#define     HEIGHT_PAGECONTROL          HEIGHT_CHAT_KEYBOARD - HEIGHT_COLLECTIONVIEW
#define     WIDTH_COLLECTION_CELL       62

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
    [self setFrame:CGRectMake(0, view.height, view.width, HEIGHT_CHAT_KEYBOARD)];
    [view addSubview:self];
    if (animation) {
        [UIView animateWithDuration:0.3 animations:^{
            self.y = view.height - self.height;
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
        self.y = view.height - self.height;
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
            self.y = self.superview.height;
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

- (void) setChatMoreKeyboardData:(NSMutableArray *)chatMoreKeyboardData
{
    _chatMoreKeyboardData = chatMoreKeyboardData;
    [self.collectionView reloadData];
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
    if (indexPath.section * 8 + indexPath.row >= self.chatMoreKeyboardData.count) {
        [cell setItem:nil];
    }
    else {
        [cell setItem:self.chatMoreKeyboardData[indexPath.section * 8 + indexPath.row]];
    }
    return cell;
}

#pragma mark - Private Methods -
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
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
        float h = HEIGHT_COLLECTIONVIEW / 2 * 0.89;
        float spaceX = (WIDTH_SCREEN - WIDTH_COLLECTION_CELL * 4) / 5;
        float spaceY = (HEIGHT_COLLECTIONVIEW - h * 2) / 2;
        [layout setItemSize:CGSizeMake(WIDTH_COLLECTION_CELL, h)];
        [layout setSectionInset:UIEdgeInsetsMake(spaceY, 0, 0, 0)];
        [layout setMinimumLineSpacing:spaceX];
        [layout setHeaderReferenceSize:CGSizeMake(spaceX, HEIGHT_COLLECTIONVIEW)];
        [layout setFooterReferenceSize:CGSizeMake(spaceX, HEIGHT_COLLECTIONVIEW)];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_COLLECTIONVIEW) collectionViewLayout:layout];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView setPagingEnabled:YES];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, HEIGHT_COLLECTIONVIEW, 100, HEIGHT_PAGECONTROL)];
        _pageControl.centerX = self.centerX;
    }
    return _pageControl;
}

@end
