//
//  UIImageView+TLWebImage.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/13.
//  Copyright © 2017年 李伯坤. All rights reserved.
//
//  网络图片拓展，基于SDWebImage
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, TLWebImageOptions) {
    /**
     * 失败重试（默认）
     */
    TLWebImageRetryFailed = 1 << 0,
    /**
     * 低优先级的（在scrollView滑动时不下载，减速时开始下载）
     */
    TLWebImageLowPriority = 1 << 1,
    /**
     * 仅内存缓存
     */
    TLWebImageCacheMemoryOnly = 1 << 2,
    /**
     * 渐进式下载（如浏览器，下载一截展示一截）
     */
    TLWebImageProgressiveDownload = 1 << 3,
    /**
     * 重新下载，更新缓存
     */
    TLWebImageRefreshCached = 1 << 4,
    /**
     * 开始后台下载（比如app进入后台，仍然下载）
     */
    TLWebImageContinueInBackground = 1 << 5,
    /**
     * 可以控制存在NSHTTPCookieStore的cookies.
     */
    TLWebImageHandleCookies = 1 << 6,
    /**
     * 允许无效的ssl证书
     */
    TLWebImageAllowInvalidSSLCertificates = 1 << 7,
    /**
     * 高优先级，会放在队头下载
     */
    TLWebImageHighPriority = 1 << 8,
    /**
     * 延时展示占位图（图片下载失败时才展示）
     */
    TLWebImageDelayPlaceholder = 1 << 9,
    /**
     * 动图相关（猜测）
     */
    TLWebImageTransformAnimatedImage = 1 << 10,
    /**
     * 图片下载完成之后不自动给imageView设置
     */
    TLWebImageAvoidAutoSetImage = 1 << 11,
    /**
     * 根据设备屏幕类型，进行放大缩小（@1x, @2x, @3x）
     */
    TLWebImageScaleDownLargeImages = 1 << 12
};

typedef NS_ENUM(NSInteger, TLImageCacheType) {
    /**
     * 无缓存
     */
    TLImageCacheTypeNone,
    /**
     * 磁盘缓存
     */
    TLImageCacheTypeDisk,
    /**
     * 内存缓存
     */
    TLImageCacheTypeMemory
};

typedef void (^TLWebImageDownloadCompleteBlock)(UIImage *image, NSError *error, TLImageCacheType cacheType, NSURL *imageURL);
typedef void (^TLWebImageDownloaderProgressBlock)(NSInteger receivedSize, NSInteger expectedSize, NSURL *targetURL);

@interface UIImageView (TLWebImage)

- (void)tt_setImageWithURL:(NSURL *)url;
- (void)tt_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
- (void)tt_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(TLWebImageOptions)options;
- (void)tt_setImageWithURL:(NSURL *)url completed:(TLWebImageDownloadCompleteBlock)completedBlock;
- (void)tt_setImageWithURL:(NSURL *)url options:(TLWebImageOptions)options completed:(TLWebImageDownloadCompleteBlock)completedBlock;
- (void)tt_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(TLWebImageDownloadCompleteBlock)completedBlock;
- (void)tt_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(TLWebImageOptions)options completed:(TLWebImageDownloadCompleteBlock)completedBlock;
- (void)tt_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(TLWebImageOptions)options progress:(TLWebImageDownloaderProgressBlock)progressBlock completed:(TLWebImageDownloadCompleteBlock)completedBlock;

- (void)tt_cancelCurrentImageLoad;

@end
