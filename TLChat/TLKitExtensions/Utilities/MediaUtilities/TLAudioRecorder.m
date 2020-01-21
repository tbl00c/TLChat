
//
//  TLAudioRecorder.m
//  TLChat
//
//  Created by 李伯坤 on 16/7/11.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLAudioRecorder.h"
#import <AVFoundation/AVFoundation.h>

#define     PATH_RECFILE        [[NSFileManager cachesPath] stringByAppendingString:@"/rec.caf"]

@interface TLAudioRecorder () <AVAudioRecorderDelegate>

@property (nonatomic, strong) AVAudioRecorder *recorder;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) void (^volumeChangedBlock)(CGFloat valume);
@property (nonatomic, strong) void (^completeBlock)(NSString *path, CGFloat time);
@property (nonatomic, strong) void (^cancelBlock)();

@end

@implementation TLAudioRecorder

+ (TLAudioRecorder *)sharedRecorder
{
    static dispatch_once_t once;
    static TLAudioRecorder *audioRecorder;
    dispatch_once(&once, ^{
        audioRecorder = [[TLAudioRecorder alloc] init];
    });
    return audioRecorder;
}

- (void)startRecordingWithVolumeChangedBlock:(void (^)(CGFloat volume))volumeChanged
                               completeBlock:(void (^)(NSString *path, CGFloat time))complete
                                 cancelBlock:(void (^)())cancel;
{
    self.volumeChangedBlock = volumeChanged;
    self.completeBlock = complete;
    self.cancelBlock = cancel;
    if ([[NSFileManager defaultManager] fileExistsAtPath:PATH_RECFILE]) {
        [[NSFileManager defaultManager] removeItemAtPath:PATH_RECFILE error:nil];
    }
    [self.recorder prepareToRecord];
    [self.recorder record];
    
    if (self.timer && self.timer.isValid) {
        [self.timer invalidate];
    }
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 block:^(NSTimer *timer) {
        [weakSelf.recorder updateMeters];
        float peakPower = pow(10, (0.05 * [weakSelf.recorder peakPowerForChannel:0]));
        if (weakSelf && weakSelf.volumeChangedBlock) {
            weakSelf.volumeChangedBlock(peakPower);
        }
    } repeats:YES];
}

- (void)stopRecording
{
    [self.timer invalidate];
    CGFloat time = self.recorder.currentTime;
    [self.recorder stop];
    if (self.completeBlock) {
        self.completeBlock(PATH_RECFILE, time);
        self.completeBlock = nil;
    }
}

- (void)cancelRecording
{
    [self.timer invalidate];
    [self.recorder stop];
    if (self.cancelBlock) {
        self.cancelBlock();
        self.cancelBlock = nil;
    }
}

#pragma mark - # Delegate
//MARK: AVAudioRecorderDelegate
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    if (flag) {
//        NSLog(@"录音成功");
    }
}

#pragma mark - # Getter
- (AVAudioRecorder *)recorder
{
    if (_recorder == nil) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *sessionError;
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
        
        if(session == nil){
            DDLogError(@"Error creating session: %@", [sessionError description]);
            return nil;
        }
        else {
            [session setActive:YES error:nil];
        }
        
        // 设置录音的一些参数
        NSMutableDictionary *setting = [NSMutableDictionary dictionary];
        setting[AVFormatIDKey] = @(kAudioFormatAppleIMA4);              // 音频格式
        setting[AVSampleRateKey] = @(44100);                            // 录音采样率(Hz)
        setting[AVNumberOfChannelsKey] = @(1);                          // 音频通道数 1 或 2
        setting[AVLinearPCMBitDepthKey] = @(8);                         // 线性音频的位深度
        setting[AVEncoderAudioQualityKey] = [NSNumber numberWithInt:AVAudioQualityHigh];        //录音的质量
        
        _recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:self.recFilePath] settings:setting error:NULL];
        _recorder.delegate = self;
        _recorder.meteringEnabled = YES;
    }
    return _recorder;
}

- (NSString *)recFilePath
{
    return PATH_RECFILE;
}

@end
