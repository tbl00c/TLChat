//
//  TLAudioRecorder.h
//  TLChat
//
//  Created by 李伯坤 on 16/7/11.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLAudioRecorder : NSObject

+ (TLAudioRecorder *)sharedRecorder;

- (void)startRecordingWithVolumeChangedBlock:(void (^)(CGFloat volume))volumeChanged
                               completeBlock:(void (^)(NSString *path, CGFloat time))complete
                                 cancelBlock:(void (^)())cancel;
- (void)stopRecording;
- (void)cancelRecording;

@end
