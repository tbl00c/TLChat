//
//  TLMessage.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMessage.h"

@implementation TLMessage

+ (TLMessage *)createMessageByType:(TLMessageType)type
{
    NSString *className;
    if (type == TLMessageTypeText) {
        className = @"TLTextMessage";
    }
    else if (type == TLMessageTypeImage) {
        className = @"TLImageMessage";
    }
    else if (type == TLMessageTypeExpression) {
        className = @"TLExpressionMessage";
    }
    else if (type == TLMessageTypeVoice) {
        className = @"TLVoiceMessage";
    }
    if (className) {
        return [[NSClassFromString(className) alloc] init];
    }
    return nil;
}

- (id)init
{
    if (self = [super init]) {
        self.messageID = [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970] * 10000)];
    }
    return self;
}

- (void)resetMessageFrame
{
    kMessageFrame = nil;
}


#pragma mark - # Protocol
- (NSString *)conversationContent
{
    return @"子类未定义";
}

- (NSString *)messageCopy
{
    return @"子类未定义";
}


#pragma mark - # Getter
- (NSMutableDictionary *)content
{
    if (_content == nil) {
        _content = [[NSMutableDictionary alloc] init];
    }
    return _content;
}

@end
