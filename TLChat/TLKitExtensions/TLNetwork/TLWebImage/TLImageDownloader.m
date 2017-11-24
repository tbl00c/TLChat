//
//  TLImageDownloader.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/13.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLImageDownloader.h"
#import <SDWebImage/SDWebImageDownloader.h>
#import <SDWebImage/SDImageCache.h>

#pragma mark - ## TLImageDownloaderTask
typedef NS_ENUM(NSInteger, TLImageDownloadState) {
    TLImageDownloadStateNone,
    TLImageDownloadStateDownloading,
    TLImageDownloadStateComplete,
};

@interface TLImageDownloaderTask : NSObject

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, copy) void (^completeAction)(BOOL, UIImage *);
@property (nonatomic, strong) NSString *token;
@property (nonatomic, assign) TLImageDownloadState downloadState;
@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) UIImage *image;

- (id)initWithUrl:(NSURL *)url completeAction:(void (^)(BOOL, UIImage *))completeAction;

@end

@implementation TLImageDownloaderTask

- (id)initWithUrl:(NSURL *)url completeAction:(void (^)(BOOL, UIImage *))completeAction
{
    if (self = [super init]) {
        [self setUrl:url];
        [self setCompleteAction:completeAction];
    }
    return self;
}

@end

#pragma mark - ## TLImageDownloader
@interface TLImageDownloader ()

/// 当前下载任务
@property (nonatomic, strong) NSMutableArray<TLImageDownloaderTask *> *downloadTasks;
/// 历史记录
@property (nonatomic, strong) NSMutableArray<TLImageDownloaderTask *> *historyRecord;

@end

@implementation TLImageDownloader

- (void)addDownloadTaskWithUrl:(NSString *)urlString completeAction:(void (^)(BOOL, UIImage *))completeAction
{
    NSURL *url = TLURL(urlString);
    
    // 已经成功下载
    TLImageDownloaderTask *task = [self historyDownloadTaskByUrl:url.absoluteString];
    if (task.success && task.image) {
        [task setDownloadState:TLImageDownloadStateComplete];
        [task setCompleteAction:completeAction];
    }
    else {
        task = [[TLImageDownloaderTask alloc] initWithUrl:url completeAction:completeAction];
        UIImage *image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:url.absoluteString];
        if (!image) {
            image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url.absoluteString];
        }
        if (image) {
            [task setDownloadState:TLImageDownloadStateComplete];
            [task setSuccess:YES];
            [task setImage:image];
        }
    }
    [self.downloadTasks addObject:task];
}

- (void)startDownload
{
    for (TLImageDownloaderTask *task in self.downloadTasks) {
        if (task.success && task.image) {
            continue;
        }
        @weakify(self);
        task.downloadState = TLImageDownloadStateDownloading;
        task.token = [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:task.url options:SDWebImageDownloaderHighPriority progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            @strongify(self);
            if (!self) {
                return;
            }
            
            task.downloadState = TLImageDownloadStateComplete;
            if (finished && image && !error) {
                [task setSuccess:YES];
                [task setImage:image];
            }
            else {
                [task setSuccess:NO];
                [task setImage:nil];
            }
            [self downloadComplete:task];
        }];
    }
    if (self.downloadTasks.count > 0) {
        TLImageDownloaderTask *firstTask = self.downloadTasks.firstObject;
        if (firstTask.success && firstTask.image) {
            [self downloadComplete:firstTask];
        }
    }
}

- (void)cancelDownload
{
    for (TLImageDownloaderTask *task in self.downloadTasks) {
//        [[SDWebImageDownloader sharedDownloader] cancel:task.token];
    }
    [self.downloadTasks removeAllObjects];
}

#pragma mark - # Private Methods
/// 根据url获取任务
- (TLImageDownloaderTask *)historyDownloadTaskByUrl:(NSString *)url
{
    for (TLImageDownloaderTask *task in self.historyRecord) {
        if ([task.url.absoluteString isEqualToString:url]) {
            return task;
        }
    }
    return nil;
}

/// 下载完成
- (void)downloadComplete:(TLImageDownloaderTask *)task
{
    if (task == self.downloadTasks.firstObject) {
        [self.downloadTasks removeObject:task];
        if (task.completeAction) {
            task.completeAction(task.success, task.image);
            if (task.success) {
                [self.historyRecord addObject:task];
                [[SDImageCache sharedImageCache] storeImage:task.image forKey:task.url.absoluteString toDisk:YES];
            }
        }
        if (self.downloadTasks.count > 0 && self.downloadTasks.firstObject.downloadState == TLImageDownloadStateComplete) {
            [self downloadComplete:self.downloadTasks.firstObject];
        }
    }
}

#pragma mark - # Getters
- (NSMutableArray<TLImageDownloaderTask *> *)downloadTasks
{
    if (!_downloadTasks) {
        _downloadTasks = [[NSMutableArray alloc] init];
    }
    return _downloadTasks;
}

- (NSMutableArray<TLImageDownloaderTask *> *)historyRecord
{
    if (!_historyRecord) {
        _historyRecord = [[NSMutableArray alloc] init];
    }
    return _historyRecord;
}

- (NSInteger)curTaskCount
{
    return self.downloadTasks.count;
}

@end
