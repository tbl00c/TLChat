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

@interface TLExpressionDetailViewController ()
{
    NSInteger kPageIndex;
}

@property (nonatomic, strong) TLExpressionProxy *proxy;

@end

@implementation TLExpressionDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    
    [self registerCellForCollectionView:self.collectionView];
    
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] init];
    [longPressGR setMinimumPressDuration:1.0f];
    [longPressGR addTarget:self action:@selector(didLongPressScreen:)];
    [self.collectionView addGestureRecognizer:longPressGR];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.group.data == nil) {
        [SVProgressHUD show];
        [self p_loadData];
    }
}

- (void)setGroup:(TLEmojiGroup *)group
{
    _group = group;
    [self.navigationItem setTitle:group.groupName];
//    [self.collectionView reloadData];
}

#pragma mark - # Private Methods -
- (void)p_loadData
{
    kPageIndex = 1;
    __weak typeof(self) weakSelf = self;
    [self.proxy requestExpressionGroupDetailByGroupID:self.group.groupID pageIndex:kPageIndex success:^(id data) {
        [SVProgressHUD dismiss];
        weakSelf.group.data = data;
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
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        [_collectionView setAlwaysBounceVertical:YES];
    }
    return _collectionView;
}

- (TLImageExpressionDisplayView *)emojiDisplayView
{
    if (_emojiDisplayView == nil) {
        _emojiDisplayView = [[TLImageExpressionDisplayView alloc] init];
    }
    return _emojiDisplayView;
}

@end
