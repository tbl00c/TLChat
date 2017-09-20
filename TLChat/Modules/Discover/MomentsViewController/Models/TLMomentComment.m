//
//  TLMomentComment.m
//  TLChat
//
//  Created by libokun on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentComment.h"

@implementation TLMomentComment

- (id)init
{
    if (self = [super init]) {
        [TLMomentComment mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"user" : @"TLUser",
                      @"toUser" : @"TLUser"};
        }];
    }
    return self;
}

#pragma mark - # Getter
- (TLMomentCommentFrame *)commentFrame
{
    if (_commentFrame == nil) {
        _commentFrame = [[TLMomentCommentFrame alloc] init];
        _commentFrame.height = 30.0f;
    }
    return _commentFrame;
}

@end



@implementation TLMomentCommentFrame

@end
