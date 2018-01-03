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
#import "TLExpressionItemCell.h"

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
    
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] init];
    [longPressGR setMinimumPressDuration:1.0f];
    [longPressGR addTarget:self action:@selector(didLongPressScreen:)];
    [self.collectionView addGestureRecognizer:longPressGR];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] init];
    [tapGR setNumberOfTapsRequired:5];
    [tapGR setNumberOfTouchesRequired:1];
    [tapGR addTarget:self action:@selector(didTap5TimesScreen:)];
    [self.collectionView addGestureRecognizer:tapGR];
    
    self.addSection(TLExpressionDetailVCSectionTypeHeader);
    self.addSection(TLExpressionDetailVCSectionTypeItems)
    .sectionInsets(UIEdgeInsetsMake(EXP_DETAIL_EDGE, EXP_DETAIL_EDGE, EXP_DETAIL_EDGE, EXP_DETAIL_EDGE))
    .minimumLineSpacing(EXP_DETAIL_SPACE).minimumInteritemSpacing(EXP_DETAIL_SPACE);
    
    if (self.groupModel) {
        self.addCell(@"TLExpressionDetailCell").toSection(TLExpressionDetailVCSectionTypeHeader).withDataModel(self.groupModel);
        [self reloadView];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [TLUIUtility showLoading:nil];
    [self requestExpressionGroupDetailDataWithPageIndex:1];
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
    [self.groupModel requestExpressionGroupDetailByPageIndex:pageIndex success:^(id data) {
        @strongify(self);
        [TLUIUtility hiddenLoading];
        self.pageIndex = pageIndex;
        self.groupModel.data = data;
        if (pageIndex == 1) {
            self.sectionForTag(TLExpressionDetailVCSectionTypeItems).clear();
        }
        self.addCells(@"TLExpressionItemCell").toSection(TLExpressionDetailVCSectionTypeItems).withDataModelArray(data);
        [self reloadView];
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

#pragma mark - # Getter
- (TLImageExpressionDisplayView *)emojiDisplayView
{
    if (_emojiDisplayView == nil) {
        _emojiDisplayView = [[TLImageExpressionDisplayView alloc] init];
    }
    return _emojiDisplayView;
}

@end
