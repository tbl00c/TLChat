//
//  TLChatBackgroundSelectViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/2.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatBackgroundSelectViewController.h"
#import "TLChatBackgroundSelectViewController+CollectionView.h"
#import "TLChatBackgroundSelectViewController+Proxy.h"

#define     SPACE_EDGE                      10
#define     WIDTH_COLLECTIONVIEW_CELL       (WIDTH_SCREEN - SPACE_EDGE * 2) / 3 * 0.98
#define     SPACE_COLLECTIONVIEW_CELL       (WIDTH_SCREEN - SPACE_EDGE * 2 - WIDTH_COLLECTIONVIEW_CELL * 3) / 2

@interface TLChatBackgroundSelectViewController ()


@end

@implementation TLChatBackgroundSelectViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"选择背景图"];
    [self.collectionView setBackgroundColor:[UIColor colorBlackBG]];
    [self.view addSubview:self.collectionView];
    
    [self p_addMasonry];
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

#pragma mark - # Getter
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setSectionHeadersPinToVisibleBounds:YES];
        [layout setItemSize:CGSizeMake(WIDTH_COLLECTIONVIEW_CELL, WIDTH_COLLECTIONVIEW_CELL)];
        [layout setMinimumInteritemSpacing:SPACE_COLLECTIONVIEW_CELL];
        [layout setMinimumLineSpacing:SPACE_COLLECTIONVIEW_CELL];
        [layout setSectionInset:UIEdgeInsetsMake(0, SPACE_EDGE, 0, SPACE_EDGE)];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setAlwaysBounceVertical:YES];
    }
    return _collectionView;
}

@end
