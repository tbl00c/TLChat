//
//  TLMessage.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMessage.h"

static UILabel *textLabel;

@implementation TLMessage

- (id)init
{
    if (self = [super init]) {
        if (textLabel == nil) {
            textLabel = [[UILabel alloc] init];
            [textLabel setFont:[UIFont fontTextMessageText]];
            [textLabel setNumberOfLines:0];
        }
        self.messageID = [NSString stringWithFormat:@"%lld", (long long)([[NSDate date] timeIntervalSince1970] * 10000)];
    }
    return self;
}

- (TLMessageFrame *)frame
{
    if (_frame == nil) {
        _frame = [[TLMessageFrame alloc] init];
        _frame.height = 32 + (self.showTime ? 30 : 0) + (self.showName ? 15 : 0);
        if (self.messageType == TLMessageTypeText) {
            [textLabel setText:self.text];
            CGSize size = [textLabel sizeThatFits:CGSizeMake(MAX_MESSAGE_WIDTH, MAXFLOAT)];
            size.height = (size.height < 28 ? 28 : size.height);
            _frame.contentSize = size;
        }
        _frame.height += _frame.contentSize.height;
    }
    return _frame;
}

@end
