//
//  TLUserGroupCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLUserGroupCell.h"
#import "TLUserGroupItemCell.h"
#import "TLUser.h"

#define     USER_CELL_WIDTH         57
#define     USER_CELL_HEIGHT        75
#define     USER_CELL_ROWSPACE     15
#define     USER_CELL_COLSPACE      ((SCREEN_WIDTH - USER_CELL_WIDTH * 4) / 5)

@interface TLUserGroupCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation TLUserGroupCell

#pragma mark - # Protocol
+ (CGFloat)viewHeightByDataModel:(NSArray *)dataModel
{
    NSInteger count = dataModel.count;
    CGFloat height = ((count + 1) / 4 + ((((count + 1) % 4) == 0) ? 0 : 1)) * 90 + 15;
    return height;
}

- (void)setViewDataModel:(id)dataModel
{
    [self setUsers:dataModel];
}

- (void)setViewEventAction:(id (^)(NSInteger, id))eventAction
{
    self.eventAction = eventAction;
}

#pragma mark - # Cell
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
        
        [self.collectionView registerClass:[TLUserGroupItemCell class] forCellWithReuseIdentifier:@"TLUserGroupItemCell"];
    }
    return self;
}

#pragma mark - # Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.users.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLUserGroupItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLUserGroupItemCell" forIndexPath:indexPath];
    if (indexPath.row < self.users.count) {
        [cell setUser:self.users[indexPath.row]];
    }
    else {
        [cell setUser:nil];
    }
    @weakify(self);
    [cell setClickBlock:^(TLUser *user) {
        @strongify(self);
        if (self.eventAction) {
            self.eventAction(user ? TLUserGroupCellEventTypeClickUser : TLUserGroupCellEventTypeAdd, user);
        }
    }];
    return cell;
}

#pragma mark - # Getter
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:CGSizeMake(USER_CELL_WIDTH, USER_CELL_HEIGHT)];
        [layout setMinimumInteritemSpacing:USER_CELL_COLSPACE];
        [layout setSectionInset:UIEdgeInsetsMake(USER_CELL_ROWSPACE, USER_CELL_COLSPACE * 0.9, USER_CELL_ROWSPACE, USER_CELL_ROWSPACE * 0.9)];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView setBackgroundColor:[UIColor whiteColor]];
        [_collectionView setScrollEnabled:NO];
        [_collectionView setPagingEnabled:YES];
        [_collectionView setDataSource:self];
        [_collectionView setDelegate:self];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setScrollsToTop:NO];
    }
    return _collectionView;
}
@end
