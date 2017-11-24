//
//  UIImageView+TLWebImage.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/13.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "UIImageView+TLWebImage.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (TLWebImage)

- (void)tt_setImageWithURL:(NSURL *)url
{
    [self tt_setImageWithURL:url completed:nil];
}

- (void)tt_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    [self tt_setImageWithURL:url placeholderImage:placeholder completed:nil];
}

- (void)tt_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(TLWebImageOptions)options
{
    [self tt_setImageWithURL:url placeholderImage:placeholder options:options completed:nil];
}

- (void)tt_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(TLWebImageDownloadCompleteBlock)completedBlock
{
     [self tt_setImageWithURL:url placeholderImage:placeholder options:nil completed:completedBlock];
}

- (void)tt_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(TLWebImageOptions)options completed:(TLWebImageDownloadCompleteBlock)completedBlock
{
    [self tt_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock];
}

- (void)tt_setImageWithURL:(NSURL *)url completed:(TLWebImageDownloadCompleteBlock)completedBlock
{
    [self tt_setImageWithURL:url placeholderImage:nil completed:completedBlock];
}

- (void)tt_setImageWithURL:(NSURL *)url options:(TLWebImageOptions)options completed:(TLWebImageDownloadCompleteBlock)completedBlock
{
    [self tt_setImageWithURL:url placeholderImage:nil options:options progress:nil completed:completedBlock];
}

- (void)tt_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(TLWebImageOptions)options progress:(TLWebImageDownloaderProgressBlock)progressBlock completed:(TLWebImageDownloadCompleteBlock)completedBlock
{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:(SDWebImageOptions)options progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        if (progressBlock) {
            progressBlock(receivedSize, expectedSize, nil);
        }
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (completedBlock) {
            completedBlock(image, error, (TLImageCacheType)cacheType, imageURL);
        }
    }];
}

- (void)tt_cancelCurrentImageLoad
{
    [self sd_cancelCurrentImageLoad];
}

@end
