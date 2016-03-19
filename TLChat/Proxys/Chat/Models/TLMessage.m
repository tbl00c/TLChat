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
                NSString *imagePath = [NSFileManager pathUserChatImage:self.imagePath];
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
        else if (self.messageType == TLMessageTypeExpression) {
            _frame.height += 5;
            if (self.imagePath) {
                UIImage *image = [UIImage imageNamed:self.imagePath];
                if (image == nil) {
                    _frame.contentSize = CGSizeMake(50, 50);
                }
                else if (image.size.width > image.size.height) {
                    CGFloat height = MAX_MESSAGE_EXPRESSION_WIDTH * image.size.height / image.size.width;
                    height = height < MIN_MESSAGE_EXPRESSION_WIDTH ? MIN_MESSAGE_EXPRESSION_WIDTH : height;
                    _frame.contentSize = CGSizeMake(MAX_MESSAGE_EXPRESSION_WIDTH, height);
                }
                else {
                    CGFloat width = MAX_MESSAGE_EXPRESSION_WIDTH * image.size.width / image.size.height;
                    width = width < MIN_MESSAGE_EXPRESSION_WIDTH ? MIN_MESSAGE_EXPRESSION_WIDTH : width;
                    _frame.contentSize = CGSizeMake(width, MAX_MESSAGE_EXPRESSION_WIDTH);
                }
            }
        }
        _frame.height += _frame.contentSize.height;
    }
    return _frame;
}

- (NSString *)messageCopy
{
    if (_messageCopy == nil) {
        if (self.messageType == TLMessageTypeText) {
            _messageCopy = self.text;
        }
        else if (self.messageType == TLMessageTypeImage) {
            NSDictionary *dictionary = @{@"path":self.imagePath.length > 0 ? self.imagePath : @"",
                                         @"url":self.imageURL.length > 0 ? self.imageURL : @""};
            NSString *jsonStr = dictionary.mj_JSONString;
            _messageCopy = [@"###TLCHAT_IMAGE_MESSAGE###" stringByAppendingString:jsonStr];
        }
        else if (self.messageType == TLMessageTypeExpression) {
            NSDictionary *dictionary = @{@"path":self.imagePath.length > 0 ? self.imagePath : @""};
            NSString *jsonStr = dictionary.mj_JSONString;
            _messageCopy = [@"###TLCHAT_EXPRESSION_MESSAGE###" stringByAppendingString:jsonStr];
        }
    }
    return _messageCopy;
}

@end
