//
//  TLRecorderIndicatorView.h
//  TLChat
//
//  Created by 李伯坤 on 16/7/12.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TLRecorderStatus) {
    TLRecorderStatusRecording,
    TLRecorderStatusWillCancel,
    TLRecorderStatusTooShort,
};

@interface TLRecorderIndicatorView : UIView

@property (nonatomic, assign) TLRecorderStatus status;

/**
 *  音量大小，取值（0-1）
 */
@property (nonatomic, assign) CGFloat volume;

@end
