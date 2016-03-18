//
//  TLMoreKeyboard.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMoreKeyboard.h"
#import "TLMoreKeyboard+CollectionViewDelegate.h"
#import "TLChatMacros.h"

#define     HEIGHT_TOP_SPACE            15
#define     HEIGHT_COLLECTIONVIEW       (HEIGHT_CHAT_KEYBOARD * 0.85 - HEIGHT_TOP_SPACE)
#define     WIDTH_COLLECTION_CELL       60

static TLMoreKeyboard *moreKB;

@implementation TLMoreKeyboard

+ (TLMoreKeyboard *)keyboard
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        moreKB = [[TLMoreKeyboard alloc] init];
    });
    return moreKB;
}

- (id)init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor colorChatBox]];
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
        [self p_addMasonry];
        [self registerCellClass];
    }
    return self;
}

#pragma mark - Public Methods -
- (void)showInView:(UIView *)view withAnimation:(BOOL)animation;
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

- (void)dismissWithAnimation:(BOOL)animation
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

- (void)setChatMoreKeyboardData:(NSMutableArray *)chatMoreKeyboardData
{
    _chatMoreKeyboardData = chatMoreKeyboardData;
    [self.collectionView reloadData];
    NSUInteger pageNumber = chatMoreKeyboardData.count / 8 + (chatMoreKeyboardData.count % 8 == 0 ? 0 : 1);
    [self.pageControl setNumberOfPages:pageNumber];
}

#pragma mark - Event Response -
- (void) pageControlChanged:(UIPageControl *)pageControl
{
    [self.collectionView scrollRectToVisible:CGRectMake(self.collectionView.width * pageControl.currentPage, 0, self.collectionView.width, self.collectionView.height) animated:YES];
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(HEIGHT_TOP_SPACE);
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(HEIGHT_COLLECTIONVIEW);
    }];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self);
        make.top.mas_equalTo(self.collectionView.mas_bottom);
        make.bottom.mas_equalTo(self).mas_offset(-2);
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
        float h = HEIGHT_COLLECTIONVIEW / 2 * 0.93;
        float spaceX = (WIDTH_SCREEN - WIDTH_COLLECTION_CELL * 4) / 5;
        float spaceY = HEIGHT_COLLECTIONVIEW - h * 2;
        [layout setItemSize:CGSizeMake(WIDTH_COLLECTION_CELL, h)];
        [layout setMinimumInteritemSpacing:spaceY];
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

@end
