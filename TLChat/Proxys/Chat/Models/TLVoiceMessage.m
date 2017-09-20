//
//  TLVoiceMessage.m
//  TLChat
//
//  Created by 李伯坤 on 16/7/11.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLVoiceMessage.h"
#import "NSFileManager+TLChat.h"

@implementation TLVoiceMessage
@synthesize recFileName = _recFileName;
@synthesize path = _path;
@synthesize url = _url;
@synthesize time = _time;

- (id)init
{
    if (self = [super init]) {
        [self setMessageType:TLMessageTypeVoice];
    }
    return self;
}

- (NSString *)recFileName
{
    if (_recFileName == nil) {
        _recFileName = [self.content objectForKey:@"path"];
    }
    return _recFileName;
}
- (void)setRecFileName:(NSString *)recFileName
{
    _recFileName = recFileName;
    [self.content setObject:recFileName forKey:@"path"];
}

- (NSString *)path
{
    if (_path == nil) {
        _path = [NSFileManager pathUserChatVoice:self.recFileName];;
    }
    return _path;
}

- (NSString *)url
{
    if (_url == nil) {
        _url = [self.content objectForKey:@"url"];
    }
    return _url;
}
- (void)setUrl:(NSString *)url
{
    _url = url;
    [self.content setObject:url forKey:@"url"];
}

- (CGFloat)time
{
    return [[self.content objectForKey:@"time"] doubleValue];
}
- (void)setTime:(CGFloat)time
{
    [self.content setObject:[NSNumber numberWithDouble:time] forKey:@"time"];
}

#pragma mark -
- (TLMessageFrame *)messageFrame
{
    if (kMessageFrame == nil) {
        kMessageFrame = [[TLMessageFrame alloc] init];
        CGFloat width = 60 + (self.time > 20 ? 1.0 : self.time / 20.0)  * (MAX_MESSAGE_WIDTH - 60);
        CGFloat height = 54;
        kMessageFrame.contentSize = CGSizeMake(width, height);
        kMessageFrame.height = kMessageFrame.contentSize.height + (self.showTime ? 30 : 0) + (self.showName ? 15 : 0) + 3;
    }
    return kMessageFrame;
}

- (NSString *)conversationContent
{
    return @"[语音消息]";
}

- (NSString *)messageCopy
{
    return [self.content mj_JSONString];
}


@end
