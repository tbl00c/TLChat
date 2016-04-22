//
//  TLMoment.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMoment.h"

@implementation TLMoment

- (id)init
{
    if (self = [super init]) {
        self.height = -1.0f;
        [TLUser mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"detail" : @"TLMomentDetail",
                      @"extension" : @"TLMomentExtension"};
        }];
    }
    return self;
}

- (CGFloat)height
{
    if (_height < 0.0f) {
        _height = 75.0f;
        CGFloat width = (WIDTH_SCREEN - 70);
        if (self.detail.text.length > 0) {
            CGFloat textHeight = [self.detail.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:15.0f]} context:nil].size.height;
            //???: 浮点数会导致部分cell顶部多出来一条线，莫名其妙！！！
            _height += (int)textHeight;
        }
        if (self.detail.images.count > 0) {
            if (self.detail.text.length > 0) {
                _height += 7.0f;
            }
            else {
                _height += 3.0f;
            }
            CGFloat space = 4.0;
            if (self.detail.images.count == 1) {
                _height += width * 0.6 * 0.8;
            }
            else {
                NSInteger row = (self.detail.images.count / 3) + (self.detail.images.count % 3 == 0 ? 0 : 1);
                _height += (width * 0.31 * row + space * (row - 1));
            }
        }
    }
    return _height;
}

@end
