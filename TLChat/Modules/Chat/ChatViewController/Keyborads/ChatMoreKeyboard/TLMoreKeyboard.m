//
//  TLMoreKeyboard.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMoreKeyboard.h"
#import "TLMoreKeyboard+CollectionView.h"
#import "TLChatMacros.h"

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
        [self setBackgroundColor:[UIColor colorGrayForChatBar]];
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
        [self p_addMasonry];
        
        [self registerCellClass];
    }
    return self;
}

- (CGFloat)keyboardHeight
{
    return HEIGHT_CHAT_KEYBOARD + SAFEAREA_INSETS_BOTTOM;
}

#pragma mark - # Public Methods
- (void)setChatMoreKeyboardData:(NSMutableArray *)chatMoreKeyboardData
{
    _chatMoreKeyboardData = chatMoreKeyboardData;
    [self.collectionView reloadData];
    NSUInteger pageNumber = chatMoreKeyboardData.count / self.pageItemCount + (chatMoreKeyboardData.count % self.pageItemCount == 0 ? 0 : 1);
    [self.pageControl setNumberOfPages:pageNumber];
}

- (void)reset
{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, self.collectionView.width, self.collectionView.height) animated:NO];
}

#pragma mark - # Event Response
- (void)pageControlChanged:(UIPageControl *)pageControl
{
    [self.collectionView scrollRectToVisible:CGRectMake(self.collectionView.width * pageControl.currentPage, 0, self.collectionView.width, self.collectionView.height) animated:YES];
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(190);
    }];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(-2 - SAFEAREA_INSETS_BOTTOM);
    }];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor colorGrayLine].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, SCREEN_WIDTH, 0);
    CGContextStrokePath(context);
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

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        [_pageControl setPageIndicatorTintColor:[UIColor colorGrayLine]];
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor grayColor]];
        [_pageControl addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}

@end
