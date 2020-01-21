//
//  TLMomentsViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/5.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentsViewController.h"
#import "TLUserDetailViewController.h"
#import <MWPhotoBrowser/MWPhotoBrowser.h>
#import "TLWebViewController.h"

#import "TLMomentHeaderCell.h"
#import "TLMomentImagesCell.h"
#import "TLUserHelper.h"
#import "TLMomentsProxy.h"



typedef NS_ENUM(NSInteger, TLMomentsVCSectionType) {
    TLMomentsVCSectionTypeHeader,
    TLMomentsVCSectionTypeItems,
};

typedef NS_ENUM(NSInteger, TLMomentsVCNewDataPosition) {
    TLMomentsVCNewDataPositionHead,
    TLMomentsVCNewDataPositionTail,
};


@interface TLMomentsViewController () <TLMomentViewDelegate>

@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation TLMomentsViewController

- (void)loadView
{
    [super loadView];
    [self setTitle:LOCSTR(@"朋友圈")];
    
    [self loadUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self requestDataWithPageIndex:0];
}

#pragma mark - # Request
- (void)requestDataWithPageIndex:(NSInteger)pageIndex
{
    TLMomentsProxy *proxy = [[TLMomentsProxy alloc] init];
    NSArray *data = [NSMutableArray arrayWithArray:proxy.testData];
    [self addMomentsData:data postion:TLMomentsVCNewDataPositionTail];
}

#pragma mark - # UI
- (void)loadUI
{
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    @weakify(self);
    [self addRightBarButtonWithImage:TLImage(@"nav_camera") actionBlick:^{
        @strongify(self);
    }];
    
    // 头图
    self.addSection(TLMomentsVCSectionTypeHeader);
    TLUser *user = [TLUserHelper sharedHelper].user;
    self.addCell(@"TLMomentHeaderCell").toSection(TLMomentsVCSectionTypeHeader).withDataModel(user);
    
    // 列表
    self.addSection(TLMomentsVCSectionTypeItems);
}

- (void)addMomentsData:(NSArray *)momentsData postion:(TLMomentsVCNewDataPosition)position
{
    if (position == TLMomentsVCSectionTypeHeader) {
        self.insertCells(@"TLMomentImagesCell").toIndex(0).toSection(TLMomentsVCSectionTypeItems).withDataModelArray(momentsData);
    }
    else {
        self.addCells(@"TLMomentImagesCell").toSection(TLMomentsVCSectionTypeItems).withDataModelArray(momentsData);
    }
}

#pragma mark - # Delegate
//MARK: TLMomentViewDelegate
- (void)momentViewWithModel:(TLMoment *)moment didClickUser:(TLUser *)user
{
    TLUserDetailViewController *userDatailVC = [[TLUserDetailViewController alloc] initWithUserModel:user];
    PushVC(userDatailVC);
}

- (void)momentViewClickImage:(NSArray *)images atIndex:(NSInteger)index
{
    NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:images.count];
    for (NSString *imageUrl in images) {
        MWPhoto *photo = [MWPhoto photoWithURL:TLURL(imageUrl)];
        [data addObject:photo];
    }
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:data];
    [browser setDisplayNavArrows:YES];
    [browser setCurrentPhotoIndex:index];
    UINavigationController *broserNavC = [[UINavigationController alloc] initWithRootViewController:browser];
    [self presentViewController:broserNavC animated:NO completion:nil];
}

- (void)momentViewWithModel:(TLMoment *)moment jumpToUrl:(NSString *)url
{
    TLWebViewController *webVC = [[TLWebViewController alloc] initWithUrl:url];
    PushVC(webVC);
}

@end
