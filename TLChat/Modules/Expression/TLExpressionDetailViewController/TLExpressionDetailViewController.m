//
//  TLExpressionDetailViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionDetailViewController.h"
#import "TLImageExpressionDisplayView.h"
#import "TLExpressionGroupModel+DetailRequest.h"
#import "TLExpressionDetailItemCell.h"

typedef NS_ENUM(NSInteger, TLExpressionDetailVCSectionType) {
    TLExpressionDetailVCSectionTypeHeader,
    TLExpressionDetailVCSectionTypeItems,
};

@interface TLExpressionDetailViewController ()

@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, strong) TLImageExpressionDisplayView *emojiDisplayView;

@end

@implementation TLExpressionDetailViewController

- (id)initWithGroupModel:(TLExpressionGroupModel *)groupModel
{
    if (self = [super init]) {
        _pageIndex = 1;
        _groupModel = groupModel;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    [self setTitle:self.groupModel.name];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // 添加表情长按浏览手势
    [self p_addDisplayGesture];
    
    // 加载表情详情cells
    [self p_loadGroupDetailCells];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.groupModel.data.count == 0) {
        [TLUIUtility showLoading:nil];
        [self requestExpressionGroupDetailDataWithPageIndex:1];
    }
    else {
        [self p_showExpressionItemsWithData:self.groupModel.data];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [TLUIUtility hiddenLoading];
}

#pragma mark - # Requests
- (void)requestExpressionGroupDetailDataWithPageIndex:(NSInteger)pageIndex
{
    @weakify(self);
    [self.groupModel requestExpressionGroupDetailByPageIndex:pageIndex success:^(NSArray *data) {
        @strongify(self);
        if (!self) {
            return;
        }
        [TLUIUtility hiddenLoading];
        self.pageIndex = pageIndex;
        if (pageIndex == 1) {
            self.groupModel.data = [data mutableCopy];
            self.sectionForTag(TLExpressionDetailVCSectionTypeItems).clear();
        }
        else {
            [self.groupModel.data addObjectsFromArray:data];
        }
        [self p_showExpressionItemsWithData:data];
    } failure:^(NSString *error) {
        [TLUIUtility hiddenLoading];
    }];
}

#pragma mark - # Event Response
- (void)didLongPressScreen:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded || sender.state == UIGestureRecognizerStateCancelled) {        // 长按停止
        [self.emojiDisplayView removeFromSuperview];
    }
    else {
        CGPoint point = [sender locationInView:self.collectionView];
        for (UICollectionViewCell *cell in self.collectionView.visibleCells) {
            if (cell.x <= point.x && cell.y <= point.y && cell.x + cell.width >= point.x && cell.y + cell.height >= point.y) {
                NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
                TLExpressionModel *emoji = [self.groupModel objectAtIndex:indexPath.row];
                CGRect rect = cell.frame;
                rect.origin.y -= (self.collectionView.contentOffset.y + 13);
                [self.emojiDisplayView removeFromSuperview];
                [self.emojiDisplayView displayEmoji:emoji atRect:rect];
                [self.view addSubview:self.emojiDisplayView];
                break;
            }
        }
    }
}

- (void)didTap5TimesScreen:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.collectionView];
    for (UICollectionViewCell *cell in self.collectionView.visibleCells) {
        if (cell.x <= point.x && cell.y <= point.y && cell.x + cell.width >= point.x && cell.y + cell.height >= point.y) {
            NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
            TLExpressionModel *emoji = [self.groupModel objectAtIndex:indexPath.row];
            [TLUIUtility showLoading:@"正在将表情保存到系统相册"];
            NSString *urlString = [TLExpressionModel expressionDownloadURLWithEid:emoji.eId];
            NSData *data = [NSData dataWithContentsOfURL:TLURL(urlString)];
            if (!data) {
                data = [NSData dataWithContentsOfFile:emoji.path];
            }
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
            }
            break;
        }
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [TLUIUtility showAlertWithTitle:@"错误" message:[NSString stringWithFormat:@"保存图片到系统相册失败\n%@", [error description]]];
    }
    else {
        [TLUIUtility showSuccessHint:@"已保存到系统相册"];
    }
}

#pragma mark - # Private Methods
- (void)p_loadGroupDetailCells
{
    self.addSection(TLExpressionDetailVCSectionTypeHeader);
    self.addSection(TLExpressionDetailVCSectionTypeItems)
    .sectionInsets(UIEdgeInsetsMake(EXP_DETAIL_EDGE, EXP_DETAIL_EDGE, EXP_DETAIL_EDGE, EXP_DETAIL_EDGE))
    .minimumLineSpacing(EXP_DETAIL_SPACE).minimumInteritemSpacing(EXP_DETAIL_SPACE);

    if (self.groupModel) {
        // banner
        if (self.groupModel.bannerURL.length > 0) {
            self.addCell(@"TLExpressionDetailBannerCell").toSection(TLExpressionDetailVCSectionTypeHeader).withDataModel(self.groupModel.bannerURL);
        }
        // 介绍
        self.addCell(@"TLExpressionDetailInfoCell").toSection(TLExpressionDetailVCSectionTypeHeader).withDataModel(self.groupModel);
        // 分割线
        self.addCell(@"TLExpressionDetailSeperatorCell").toSection(TLExpressionDetailVCSectionTypeHeader);
        [self reloadView];
    }
}

- (void)p_addDisplayGesture
{
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] init];
    [longPressGR setMinimumPressDuration:1.0f];
    [longPressGR addTarget:self action:@selector(didLongPressScreen:)];
    [self.collectionView addGestureRecognizer:longPressGR];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] init];
    [tapGR setNumberOfTapsRequired:5];
    [tapGR setNumberOfTouchesRequired:1];
    [tapGR addTarget:self action:@selector(didTap5TimesScreen:)];
    [self.collectionView addGestureRecognizer:tapGR];
}

- (void)p_showExpressionItemsWithData:(NSArray *)data
{
    // 表情
    self.addCells(@"TLExpressionDetailItemCell").toSection(TLExpressionDetailVCSectionTypeItems).withDataModelArray(data);
    [self reloadView];
}

#pragma mark - # Getter
- (TLImageExpressionDisplayView *)emojiDisplayView
{
    if (_emojiDisplayView == nil) {
        _emojiDisplayView = [[TLImageExpressionDisplayView alloc] init];
    }
    return _emojiDisplayView;
}

@end
