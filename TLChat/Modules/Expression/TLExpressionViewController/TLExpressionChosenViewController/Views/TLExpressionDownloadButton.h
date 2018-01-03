//
//  TLExpressionDownloadButton.h
//  TLChat
//
//  Created by 李伯坤 on 2018/1/2.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TLExpressionDownloadButtonStatus) {
    TLExpressionDownloadButtonStatusNet,
    TLExpressionDownloadButtonStatusDownloading,
    TLExpressionDownloadButtonStatusDownloaded,
};

@interface TLExpressionDownloadButton : UIView

@property (nonatomic, assign) TLExpressionDownloadButtonStatus status;

@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, copy) void (^downloadButtonClick)();

@end
