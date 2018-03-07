//
//  TLChatFileViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/18.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatFileViewController.h"
#import "TLChatFileCell.h"
#import "TLChatFileHeaderView.h"
#import "NSDate+TLChat.h"
#import "TLMessageManager+MessageRecord.h"
#import <MWPhotoBrowser/MWPhotoBrowser.h>
#import "NSFileManager+TLChat.h"

#define     HEIGHT_COLLECTIONVIEW_HEADER    28
#define     WIDTH_COLLECTIONVIEW_CELL       SCREEN_WIDTH / 4 * 0.98
#define     SPACE_COLLECTIONVIEW_CELL       (SCREEN_WIDTH - WIDTH_COLLECTIONVIEW_CELL * 4) / 3

@interface TLChatFileViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *mediaData;

@property (nonatomic, strong) NSMutableArray *browserData;

@end

@implementation TLChatFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:LOCSTR(@"聊天文件")];
    [self.view setBackgroundColor:[UIColor colorBlackBG]];
    
    [self.view addSubview:self.collectionView];
    [self p_addMasonry];
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStylePlain actionBlick:^{
        
    }];
    [self.navigationItem setRightBarButtonItem:rightBarButton];

    [self.collectionView registerClass:[TLChatFileHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TLChatFileHeaderView"];
    [self.collectionView registerClass:[TLChatFileCell class] forCellWithReuseIdentifier:@"TLChatFileCell"];
}

- (void)setPartnerID:(NSString *)partnerID
{
    _partnerID = partnerID;
    __weak typeof(self) weakSelf = self;
    [[TLMessageManager sharedInstance] chatFilesForPartnerID:partnerID completed:^(NSArray *data) {
        [weakSelf.data removeAllObjects];
        weakSelf.mediaData = nil;
        [weakSelf.data addObjectsFromArray:data];
        [weakSelf.collectionView reloadData];
    }];
}

#pragma mark - Delegate -
//MARK: UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.data.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.data[section] count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    TLMessage *message = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    TLChatFileHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"TLChatFileHeaderView" forIndexPath:indexPath];
    [headerView setTitle:[message.date chatFileTimeInfo]];
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLMessage * message = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    TLChatFileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TLChatFileCell" forIndexPath:indexPath];
    [cell setMessage:message];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TLMessage *message = [self.data[indexPath.section] objectAtIndex:indexPath.row];
    if (message.messageType == TLMessageTypeImage) {
        NSInteger index = -1;
        for (int i = 0; i < self.mediaData.count; i++) {
            if ([message.messageID isEqualToString:[self.mediaData[i] messageID]]) {
                index = i;
                break;
            }
        }
        if (index >= 0) {
            MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:self.browserData];
            [browser setDisplayNavArrows:YES];
            [browser setCurrentPhotoIndex:index];
            UINavigationController *broserNavC = [[UINavigationController alloc] initWithRootViewController:browser];
            [self presentViewController:broserNavC animated:NO completion:nil];
        }
    }
}

#pragma mark - Private Methods -
- (void)p_addMasonry
{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
}

#pragma mark - Getter -
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
            [layout setSectionHeadersPinToVisibleBounds:YES];
        }
        [layout setItemSize:CGSizeMake(WIDTH_COLLECTIONVIEW_CELL, WIDTH_COLLECTIONVIEW_CELL)];
        [layout setMinimumInteritemSpacing:SPACE_COLLECTIONVIEW_CELL];
        [layout setMinimumLineSpacing:SPACE_COLLECTIONVIEW_CELL];
        [layout setHeaderReferenceSize:CGSizeMake(SCREEN_WIDTH, HEIGHT_COLLECTIONVIEW_HEADER)];
        [layout setFooterReferenceSize:CGSizeMake(SCREEN_WIDTH, 0)];
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

- (NSMutableArray *)data
{
    if (_data == nil) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

- (NSMutableArray *)mediaData
{
    if (_mediaData == nil) {
        _mediaData = [[NSMutableArray alloc] init];
        for (NSArray *array in self.data) {
            for (TLMessage *message in array) {
                if (message.messageType == TLMessageTypeImage) {
                    [_mediaData addObject:message];
                    NSURL *url;
                    if ([(TLImageMessage *)message imagePath]) {
                        NSString *imagePath = [NSFileManager pathUserChatImage:[(TLImageMessage *)message imagePath]];
                        url = [NSURL fileURLWithPath:imagePath];
                    }
                    else {
                        url = TLURL([(TLImageMessage *)message imageURL]);
                    }
                    MWPhoto *photo = [MWPhoto photoWithURL:url];
                    [_browserData addObject:photo];
                }
            }
        }
    }
    return _mediaData;
}

- (NSMutableArray *)browserData
{
    if (_browserData == nil) {
        _browserData = [[NSMutableArray alloc] init];
        for (TLMessage *message in self.mediaData) {
            if (message.messageType == TLMessageTypeImage) {
                NSURL *url;
                if ([(TLImageMessage *)message imagePath]) {
                    NSString *imagePath = [NSFileManager pathUserChatImage:[(TLImageMessage *)message imagePath]];
                    url = [NSURL fileURLWithPath:imagePath];
                }
                else {
                    url = TLURL([(TLImageMessage *)message imageURL]);
                }
                MWPhoto *photo = [MWPhoto photoWithURL:url];
                [_browserData addObject:photo];
            }
        }
    }
    return _browserData;
}

@end
