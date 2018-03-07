//
//  TLUserDetailAlbumCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/29.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLUserDetailAlbumCell.h"

#define     HEIGHT_ALBUM_ITEM           60
#define     SPACE_ALBUM_ITEM            8

@interface TLUserDetailAlbumCell ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ZZFLEXAngel *angel;

@end

@implementation TLUserDetailAlbumCell

+ (CGFloat)viewHeightByDataModel:(id)dataModel
{
    return 90.0f;
}

- (void)setViewDataModel:(TLUserDetailKVModel *)dataModel
{
    [super setViewDataModel:dataModel];
    NSArray *data = dataModel.data;
    
    NSInteger maxCount = (SCREEN_WIDTH - 118) / (HEIGHT_ALBUM_ITEM + SPACE_ALBUM_ITEM);
    
    data = data.count > maxCount ? [data subarrayWithRange:NSMakeRange(0, maxCount)] : data;
    
    self.angel.clear();
    self.angel.addSection(0).minimumInteritemSpacing(SPACE_ALBUM_ITEM).minimumLineSpacing(SPACE_ALBUM_ITEM);
    self.angel.addCells(@"TLUserDetailAlbumItemCell").toSection(0).withDataModelArray(data);
    [self.collectionView reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.collectionView = self.detailContentView.addCollectionView(1)
        .backgroundColor([UIColor clearColor])
        .userInteractionEnabled(NO)
        .masonry(^ (MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(HEIGHT_ALBUM_ITEM);
            make.centerY.mas_equalTo(0);
        })
        .view;
        
        [(UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        
        self.angel = [[ZZFLEXAngel alloc] initWithHostView:self.collectionView];
    }
    return self;
}

@end

@interface TLUserDetailAlbumItemCell :UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TLUserDetailAlbumItemCell

+ (CGSize)viewSizeByDataModel:(id)dataModel
{
    return CGSizeMake(HEIGHT_ALBUM_ITEM, HEIGHT_ALBUM_ITEM);
}

- (void)setViewDataModel:(id)dataModel
{
    if (dataModel) {
        [self.imageView tt_setImageWithURL:TLURL(dataModel) placeholderImage:[UIImage imageWithColor:[UIColor colorGrayBG]]];
    }
    else {
        [self.imageView setImage:nil];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView = self.contentView.addImageView(1)
        .contentMode(UIViewContentModeScaleAspectFill).clipsToBounds(YES)
        .masonry(^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        })
        .view;
    }
    return self;
}

@end
