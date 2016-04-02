//
//  TLImageMessage.m
//  TLChat
//
//  Created by libokun on 16/3/28.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLImageMessage.h"

@implementation TLImageMessage
@synthesize imagePath = _imagePath;
@synthesize imageURL = _imageURL;


#pragma mark -
- (NSString *)imagePath
{
    if (_imagePath == nil) {
        _imagePath = [self.content objectForKey:@"path"];
    }
    return _imagePath;
}
- (void)setImagePath:(NSString *)imagePath
{
    _imagePath = imagePath;
    [self.content setObject:imagePath forKey:@"path"];
}

- (NSString *)imageURL
{
    if (_imageURL == nil) {
        _imageURL = [self.content objectForKey:@"url"];
    }
    return _imageURL;
}
- (void)setImageURL:(NSString *)imageURL
{
    _imageURL = imageURL;
    [self.content setObject:imageURL forKey:@"url"];
}

#pragma mark -
- (TLMessageFrame *)messageFrame
{
    if (kMessageFrame == nil) {
        kMessageFrame = [[TLMessageFrame alloc] init];
        kMessageFrame.height = 20 + (self.showTime ? 30 : 0) + (self.showName ? 15 : 0);
        
        if (self.imagePath) {
            NSString *imagePath = [NSFileManager pathUserChatImage:self.imagePath];
            UIImage *image = [UIImage imageNamed:imagePath];
            if (image == nil) {
                kMessageFrame.contentSize = CGSizeMake(60, 60);
            }
            else if (image.size.width > image.size.height) {
                CGFloat height = MAX_MESSAGE_IMAGE_WIDTH * image.size.height / image.size.width;
                height = height < MIN_MESSAGE_IMAGE_WIDTH ? MIN_MESSAGE_IMAGE_WIDTH : height;
                kMessageFrame.contentSize = CGSizeMake(MAX_MESSAGE_IMAGE_WIDTH, height);
            }
            else {
                CGFloat width = MAX_MESSAGE_IMAGE_WIDTH * image.size.width / image.size.height;
                width = width < MIN_MESSAGE_IMAGE_WIDTH ? MIN_MESSAGE_IMAGE_WIDTH : width;
                kMessageFrame.contentSize = CGSizeMake(width, MAX_MESSAGE_IMAGE_WIDTH);
            }
        }
        kMessageFrame.height += kMessageFrame.contentSize.height;
    }
    return kMessageFrame;
}

- (NSString *)conversationContent
{
    return @"[图片]";
}

- (NSString *)messageCopy
{
    return [self.content mj_JSONString];
}

@end
