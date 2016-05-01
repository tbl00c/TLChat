//
//  TLMomentDetail.m
//  TLChat
//
//  Created by libokun on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMomentDetail.h"

#define     WIDTH_MOMENT_CONTENT        (WIDTH_SCREEN - 70.0f)

@implementation TLMomentDetail

#pragma mark - # Private Methods
- (CGFloat)heightText
{
    if (self.text.length > 0) {
        CGFloat textHeight = [self.text boundingRectWithSize:CGSizeMake(WIDTH_MOMENT_CONTENT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:15.0f]} context:nil].size.height;
        //???: 浮点数会导致部分cell顶部多出来一条线，莫名其妙！！！
        return (int)textHeight + 1.0;
    }
    return 0.0f;
}

- (CGFloat)heightImages
{
    CGFloat height = 0.0f;
    if (self.images.count > 0) {
        if (self.text.length > 0) {
            height += 7.0f;
        }
        else {
            height += 3.0f;
        }
        CGFloat space = 4.0;
        if (self.images.count == 1) {
            height += WIDTH_MOMENT_CONTENT * 0.6 * 0.8;
        }
        else {
            NSInteger row = (self.images.count / 3) + (self.images.count % 3 == 0 ? 0 : 1);
            height += (WIDTH_MOMENT_CONTENT * 0.31 * row + space * (row - 1));
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
        _detailFrame.height += _detailFrame.heightImages = [self heightImages];
    }
    return _detailFrame;
}

@end


@implementation TLMomentDetailFrame

@end