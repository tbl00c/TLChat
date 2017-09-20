//
//  TLImageBrowserController.m
//  TLChat
//
//  Created by 李伯坤 on 16/5/1.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLImageBrowserController.h"
#import <UIImageView+WebCache.h>

@interface TLImageBrowserController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *curImageView;

@end

@implementation TLImageBrowserController

- (id)initWithImages:(NSArray *)images curImageIndex:(NSInteger)index curImageRect:(CGRect)rect
{
    if (self = [super init]) {
        self.images = images;
        self.curIndex = index;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.scrollView setFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [imageView setImage:[UIImage imageNamed:self.images[0]]];
    [self.scrollView addSubview:imageView];
    self.curImageView = imageView;

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.view removeFromSuperview];
    });
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.view];
}

#pragma mark - # Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.curImageView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGSize originalSize=_scrollView.bounds.size;
    CGSize contentSize=_scrollView.contentSize;
    CGFloat offsetX=originalSize.width>contentSize.width?(originalSize.width-contentSize.width)/2:0;
    CGFloat offsetY=originalSize.height>contentSize.height?(originalSize.height-contentSize.height)/2:0;
    
    self.curImageView.center=CGPointMake(contentSize.width/2+offsetX, contentSize.height/2+offsetY);
}

#pragma mark - # Getter
- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        [_scrollView setDelegate:self];
        [_scrollView setContentMode:UIViewContentModeScaleAspectFit];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
//        [_scrollView setPagingEnabled:YES];
        [_scrollView setAlwaysBounceHorizontal:YES];
        [_scrollView setMinimumZoomScale:1.0];
        [_scrollView setMaximumZoomScale:3.0];
    }
    return _scrollView;
}

@end
