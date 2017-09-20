//
//  TLMomentExtension.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentExtension.h"

#define     EDGE_MOMENT_EXTENSION       5.0f

@implementation TLMomentExtension

- (id)init
{
    if (self = [super init]) {
        [TLMomentExtension mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"likedFriends" : @"TLUser",
                      @"comments" : @"TLMomentComment"};
        }];
    }
    return self;
}

#pragma mark - # Private Methods
- (CGFloat)heightLiked
{
    CGFloat height = 0.0f;
    if (self.likedFriends.count > 0) {
        height = 30.0f;
    }
    return height;
}

- (CGFloat)heightComments
{
    CGFloat height = 0.0f;
    for (TLMomentComment *comment in self.comments) {
        height += comment.commentFrame.height;
    }
    return height;
}

#pragma mark - # Getter
- (TLMomentExtensionFrame *)extensionFrame
{
    if (_extensionFrame == nil) {
        _extensionFrame = [[TLMomentExtensionFrame alloc] init];
        _extensionFrame.height = 0.0f;
        if (self.likedFriends.count > 0 || self.comments.count > 0) {
            _extensionFrame.height += EDGE_MOMENT_EXTENSION;
        }
        _extensionFrame.height += _extensionFrame.heightLiked = [self heightLiked];
        _extensionFrame.height += _extensionFrame.heightComments = [self heightComments];
    }
    return _extensionFrame;
}

@end


@implementation TLMomentExtensionFrame

@end
