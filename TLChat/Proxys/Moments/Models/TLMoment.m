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
        _height = 67.0f;
        CGFloat width = (WIDTH_SCREEN - 70);
        if (self.detail.text.length > 0) {
#warning 莫名其妙多线
            CGFloat textHeight ;//= [self.detail.text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:15.0f]} context:nil].size.height;
            UILabel *label = [[UILabel alloc] init];
            [label setFont:[UIFont systemFontOfSize:15.0f]];
            [label setText:self.detail.text];
            [label setNumberOfLines:0];
            textHeight = [label sizeThatFits:CGSizeMake(width, MAXFLOAT)].height;
            _height += textHeight;
        }
        if (self.detail.images.count > 0) {
            CGFloat space = 3.0;
            _height += (2.0 + space);
            if (self.detail.images.count == 1) {
                _height += (width * 0.6 * 0.8 + space);
            }
            else {
                NSInteger row = (self.detail.images.count / 3) + (self.detail.images.count % 3 == 0 ? 0 : 1);
                _height += ((width * 0.32 + space) * row);
            }
        }
    }
    return _height;
}

@end
