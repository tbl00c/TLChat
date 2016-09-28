//
//  TLEmojiKeyboard.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmojiKeyboard.h"
#import "TLEmojiKeyboard+DisplayView.h"
#import "TLEmojiKeyboard+EmojiGroupControl.h"
#import "TLChatMacros.h"

static TLEmojiKeyboard *emojiKB;

@implementation TLEmojiKeyboard

+ (TLEmojiKeyboard *)keyboard
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        emojiKB = [[TLEmojiKeyboard alloc] init];
    });
    return emojiKB;
}

- (id)init
{
    if (self = [super init]) {
        [self setBackgroundColor:[UIColor colorGrayForChatBar]];
        [self addSubview:self.displayView];
        [self addSubview:self.pageControl];
        [self addSubview:self.groupControl];
        [self p_addMasonry];
    }
    return self;
}

- (void)setEmojiGroupData:(NSMutableArray *)emojiGroupData
{
    _emojiGroupData = emojiGroupData;
    [self.displayView setData:emojiGroupData];
    [self.groupControl setEmojiGroupData:emojiGroupData];
}

#pragma mark - # Public Methods
- (void)reset
{
//    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, self.collectionView.width, self.collectionView.height) animated:NO];
}

#pragma mark - # Event Response
- (void)pageControlChanged:(UIPageControl *)pageControl
{
//    [self.collectionView scrollRectToVisible:CGRectMake(WIDTH_SCREEN * pageControl.currentPage, 0, WIDTH_SCREEN, HEIGHT_PAGECONTROL) animated:YES];
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.and.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.pageControl.mas_top);
    }];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.groupControl.mas_top);
        make.height.mas_equalTo(20);
    }];
    [self.groupControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.mas_equalTo(self);
        make.height.mas_equalTo(37);
    }];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // 顶部直线
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5);
    CGContextSetStrokeColorWithColor(context, [UIColor colorGrayLine].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, WIDTH_SCREEN, 0);
    CGContextStrokePath(context);
}

#pragma mark - # Getter
- (TLEmojiGroupDisplayView *)displayView
{
    if (_displayView == nil) {
        _displayView = [[TLEmojiGroupDisplayView alloc] init];
        [_displayView setDelegate:self];
    }
    return _displayView;
}

- (UIPageControl *)pageControl
{
    if (_pageControl == nil) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.centerX = self.centerX;
        [_pageControl setPageIndicatorTintColor:[UIColor colorGrayLine]];
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
