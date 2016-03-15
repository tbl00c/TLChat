//
//  TLMessage.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMessage.h"
#import "NSString+Message.h"

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

- (NSAttributedString *)attrText
{
    if (_attrText == nil) {
        _attrText = [self.text toMessageString];
    }
    return _attrText;
}

- (TLMessageFrame *)frame
{
    if (_frame == nil) {
        _frame = [[TLMessageFrame alloc] init];
        _frame.height = 20 + (self.showTime ? 30 : 0) + (self.showName ? 15 : 0);
        if (self.messageType == TLMessageTypeText) {
            _frame.height += 20;
            [textLabel setAttributedText:self.attrText];
            _frame.contentSize = [textLabel sizeThatFits:CGSizeMake(MAX_MESSAGE_WIDTH, MAXFLOAT)];
        }
        else if (self.messageType == TLMessageTypeImage){
            if (self.imagePath) {
                NSString *imagePath = [NSFileManager pathUserChatAvatar:self.imagePath forUser:self.userID];
                UIImage *image = [UIImage imageNamed:imagePath];
                if (image == nil) {
                    _frame.contentSize = CGSizeMake(60, 60);
                }
                else if (image.size.width > image.size.height) {
                    CGFloat height = MAX_MESSAGE_IMAGE_WIDTH * image.size.height / image.size.width;
                    height = height < MIN_MESSAGE_IMAGE_WIDTH ? MIN_MESSAGE_IMAGE_WIDTH : height;
                    _frame.contentSize = CGSizeMake(MAX_MESSAGE_IMAGE_WIDTH, height);
                }
                else {
                    CGFloat width = MAX_MESSAGE_IMAGE_WIDTH * image.size.width / image.size.height;
                    width = width < MIN_MESSAGE_IMAGE_WIDTH ? MIN_MESSAGE_IMAGE_WIDTH : width;
                    _frame.contentSize = CGSizeMake(width, MAX_MESSAGE_IMAGE_WIDTH);
                }
            }
        }
        _frame.height += _frame.contentSize.height;
    }
    return _frame;
}

@end
