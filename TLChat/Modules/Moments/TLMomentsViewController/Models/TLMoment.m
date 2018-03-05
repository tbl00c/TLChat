//
//  TLMoment.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMoment.h"

#define     HEIGHT_MOMENT_DEFAULT       78.0f

@implementation TLMoment

#pragma mark - # Getter
- (TLMomentFrame *)momentFrame
{
    if (_momentFrame == nil) {
        _momentFrame = [[TLMomentFrame alloc] init];
        _momentFrame.height = HEIGHT_MOMENT_DEFAULT;
        _momentFrame.height += _momentFrame.heightDetail = self.detail.detailFrame.height;  // 正文高度
        if (self.hasExtension) {
            _momentFrame.height += 10;
            _momentFrame.height += _momentFrame.heightExtension = self.extension.extensionFrame.height;   // 拓展高度
        }
    }
    return _momentFrame;
}

- (BOOL)hasExtension
{
    BOOL hasExtension = self.extension.likedFriends.count > 0 || self.extension.comments.count > 0;
    return hasExtension;
}

@end


@implementation TLMomentFrame

@end
