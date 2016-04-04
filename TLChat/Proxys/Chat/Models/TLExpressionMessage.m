//
//  TLExpressionMessage.m
//  TLChat
//
//  Created by libokun on 16/3/28.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionMessage.h"

@implementation TLExpressionMessage
@synthesize path = _path;

- (NSString *)path
{
    if (_path == nil) {
        _path = [self.content objectForKey:@"path"];
    }
    return _path;
}
- (void)setPath:(NSString *)path
{
    _path = path;
    [self.content setObject:path forKey:@"path"];
}

#pragma mark -
- (TLMessageFrame *)messageFrame
{
    if (kMessageFrame == nil) {
        kMessageFrame = [[TLMessageFrame alloc] init];
        kMessageFrame.height = 20 + (self.showTime ? 30 : 0) + (self.showName ? 15 : 0);
        
        kMessageFrame.height += 5;
        if (self.path) {
            UIImage *image = [UIImage imageNamed:self.path];
            if (image == nil) {
                kMessageFrame.contentSize = CGSizeMake(50, 50);
            }
            else if (image.size.width > image.size.height) {
                CGFloat height = MAX_MESSAGE_EXPRESSION_WIDTH * image.size.height / image.size.width;
                height = height < MIN_MESSAGE_EXPRESSION_WIDTH ? MIN_MESSAGE_EXPRESSION_WIDTH : height;
                kMessageFrame.contentSize = CGSizeMake(MAX_MESSAGE_EXPRESSION_WIDTH, height);
            }
            else {
                CGFloat width = MAX_MESSAGE_EXPRESSION_WIDTH * image.size.width / image.size.height;
                width = width < MIN_MESSAGE_EXPRESSION_WIDTH ? MIN_MESSAGE_EXPRESSION_WIDTH : width;
                kMessageFrame.contentSize = CGSizeMake(width, MAX_MESSAGE_EXPRESSION_WIDTH);
            }
        }
    
        kMessageFrame.height += kMessageFrame.contentSize.height;
    }
    return kMessageFrame;
}

- (NSString *)conversationContent
{
    return @"[表情]";
}

- (NSString *)messageCopy
{
    return [self.content mj_JSONString];
}

@end
