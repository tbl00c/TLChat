//
//  TLImageDownloader.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/13.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLImageDownloader : NSObject

/// 是否按队列顺序执行回调（默认NO）
@property (nonatomic, assign) BOOL useQueue;
/// 是否正在下载
@property (nonatomic, assign) BOOL isDownloading;
/// 当前任务数量
@property (nonatomic, assign) NSInteger curTaskCount;

- (void)addDownloadTaskWithUrl:(NSString *)urlString completeAction:(void (^)(BOOL success, UIImage *image))completeAction;
- (void)startDownload;
- (void)cancelDownload;

@end
