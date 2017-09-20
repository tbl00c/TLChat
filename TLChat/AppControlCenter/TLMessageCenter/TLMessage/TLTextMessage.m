//
//  TLTextMessage.m
//  TLChat
//
//  Created by libokun on 16/3/28.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTextMessage.h"
#import "NSString+Message.h"

static UILabel *textLabel = nil;

@implementation TLTextMessage
@synthesize text = _text;

- (id)init
{
    if (self = [super init]) {
        [self setMessageType:TLMessageTypeText];
        if (textLabel == nil) {
            textLabel = [[UILabel alloc] init];
            [textLabel setFont:[UIFont fontTextMessageText]];
            [textLabel setNumberOfLines:0];
        }
    }
    return self;
}

- (NSString *)text
{
    if (_text == nil) {
        _text = [self.content objectForKey:@"text"];
    }
    return _text;
}
- (void)setText:(NSString *)text
{
    _text = text;
    [self.content setObject:text forKey:@"text"];
}

- (NSAttributedString *)attrText
{
    if (_attrText == nil) {
        _attrText = [self.text toMessageString];
    }
    return _attrText;
}

- (TLMessageFrame *)messageFrame
{
    if (kMessageFrame == nil) {
        kMessageFrame = [[TLMessageFrame alloc] init];
        kMessageFrame.height = 20 + (self.showTime ? 30 : 0) + (self.showName ? 15 : 0) + 20;
        [textLabel setAttributedText:self.attrText];
        kMessageFrame.contentSize = [textLabel sizeThatFits:CGSizeMake(MAX_MESSAGE_WIDTH, MAXFLOAT)];
        kMessageFrame.height += kMessageFrame.contentSize.height;
    }
    return kMessageFrame;
}

- (NSString *)conversationContent
{
    return self.text;
}

- (NSString *)messageCopy
{
    return self.text;
}

@end
