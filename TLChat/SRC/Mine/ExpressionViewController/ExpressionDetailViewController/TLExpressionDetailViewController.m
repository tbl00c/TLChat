//
//  TLExpressionDetailViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionDetailViewController.h"
#import "TLExpressionDetailViewController+CollectionView.h"
#import "TLExpressionProxy.h"

#define         EDGE                20.0
#define         SPACE_CELL          15.0
#define         WIDTH_CELL          ((WIDTH_SCREEN - EDGE * 2 - SPACE_CELL * 3.0) / 4.0)

@interface TLExpressionDetailViewController ()
{
    NSInteger kPageIndex;
}

@property (nonatomic, strong) TLExpressionProxy *proxy;

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation TLExpressionDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    
    [self registerCellForCollectionView:self.collectionView];
    [SVProgressHUD show];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self p_loadDataIfNeed];
}

- (void)setGroup:(TLEmojiGroup *)group
{
    _group = group;
    [self.navigationItem setTitle:group.groupName];
}

#pragma mark - # Private Methods -
- (void)p_loadDataIfNeed
{
    kPageIndex = 1;
    __weak typeof(self) weakSelf = self;
    [self.proxy requestExpressionGroupDetailByGroupID:self.group.groupID pageIndex:kPageIndex success:^(id data) {
        [SVProgressHUD dismiss];
        weakSelf.data = data;
        [weakSelf.collectionView reloadData];
    } failure:^(NSString *error) {
        [SVProgressHUD dismiss];
    }];
}

#pragma mark - # Getter -
- (TLExpressionProxy *)proxy
{
    if (_proxy == nil) {
        _proxy = [[TLExpressionProxy alloc] init];
    }
    return _proxy;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setSectionInset:UIEdgeInsetsMake(EDGE, EDGE, EDGE, EDGE)];
        [layout setItemSize:CGSizeMake(WIDTH_CELL, WIDTH_CELL)];
        [layout setMinimumLineSpacing:SPACE_CELL];
        [layout setMinimumInteritemSpacing:SPACE_CELL];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        [_collectionView setAlwaysBounceVertical:YES];
    }
    return _collectionView;
}

@end
