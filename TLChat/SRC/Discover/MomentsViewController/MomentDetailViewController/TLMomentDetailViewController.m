//
//  TLMomentDetailViewController.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentDetailViewController.h"
#import "TLMomentImageView.h"
#import <MWPhotoBrowser.h>

@interface TLMomentDetailViewController () <TLMomentViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) TLMomentImageView *momentView;

@end

@implementation TLMomentDetailViewController

- (id)init
{
    if (self = [super init]) {
        [self.navigationItem setTitle:@"详情"];
        [self.view setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:self.scrollView];
        [self.scrollView addSubview:self.momentView];
        
        [self p_addMasonry];
    }
    return self;
}

- (void)setMoment:(TLMoment *)moment
{
    _moment = moment;
    [self.momentView setMoment:moment];
    [self.momentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(moment.momentFrame.height);
    }];
}

#pragma mark - # Delegate
//MARK: TLMomentViewDelegate
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
    TLNavigationController *broserNavC = [[TLNavigationController alloc] initWithRootViewController:browser];
    [self presentViewController:broserNavC animated:NO completion:nil];
}

#pragma mark - # Private Methods
- (void)p_addMasonry
{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self.momentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.mas_equalTo(0);
        make.width.mas_equalTo(self.view);
    }];
}

#pragma mark - # Getter
- (TLMomentImageView *)momentView
{
    if (_momentView == nil) {
        _momentView = [[TLMomentImageView alloc] init];
        [_momentView setDelegate:self];
    }
    return _momentView;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        [_scrollView setAlwaysBounceVertical:YES];
    }
    return _scrollView;
}

@end
