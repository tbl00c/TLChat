//
//  TLMomentDetail.m
//  TLChat
//
//  Created by libokun on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentDetail.h"

#define     WIDTH_MOMENT_CONTENT        (SCREEN_WIDTH - 80.0f)

@implementation TLMomentDetail

#pragma mark - # Private Methods
- (CGFloat)heightText
{
    if (self.text.length > 0) {
        CGFloat textHeight = [self.text tt_sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(WIDTH_MOMENT_CONTENT, MAXFLOAT)].height;
        return textHeight;
    }
    return 0.0f;
}

- (CGFloat)heightImages
{
    CGFloat height = 0.0f;
    if (self.images.count > 0) {
        CGFloat space = 4.0;
        if (self.images.count == 1) {
            height += WIDTH_MOMENT_CONTENT * 0.6 * 1.2;
        }
        else {
            CGFloat width = (WIDTH_MOMENT_CONTENT - space * 2.0) / 3.0;
            NSInteger row = (self.images.count / 3) + (self.images.count % 3 == 0 ? 0 : 1);
            height += (width * row + space * (row - 1));
        }
    }
    return height;
}

#pragma mark - # Getter
- (TLMomentDetailFrame *)detailFrame
{
    if (_detailFrame == nil) {
        _detailFrame = [[TLMomentDetailFrame alloc] init];
        _detailFrame.height = 0.0f;
        _detailFrame.height += _detailFrame.heightText = [self heightText];
        if (self.images.count > 0) {
            if (self.text.length > 0) {
                _detailFrame.height += 10;
            }
            _detailFrame.height += _detailFrame.heightImages = [self heightImages];
        }
    }
    return _detailFrame;
}

@end


@implementation TLMomentDetailFrame

@end
