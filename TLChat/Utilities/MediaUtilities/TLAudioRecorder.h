//
//  TLAudioRecorder.h
//  TLChat
//
//  Created by 李伯坤 on 16/7/11.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLAudioRecorder : NSObject

@property (nonatomic, strong, readonly) NSString *recFilePath;

+ (TLAudioRecorder *)sharedRecorder;

- (void)startRecording;
- (void)stopRecording;

@end
