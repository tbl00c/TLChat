//
//  TLVoiceMessage.h
//  TLChat
//
//  Created by 李伯坤 on 16/7/11.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMessage.h"

typedef NS_ENUM(NSInteger, TLVoiceMessageStatus) {
    TLVoiceMessageStatusNormal,
    TLVoiceMessageStatusRecording,
    TLVoiceMessageStatusPlaying,
};

@interface TLVoiceMessage : TLMessage

@property (nonatomic, strong) NSString *recFileName;

@property (nonatomic, strong, readonly) NSString *path;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) CGFloat time;

@property (nonatomic, assign) TLVoiceMessageStatus msgStatus;

@end
