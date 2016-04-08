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
        [TLUser mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"detail" : @"TLMomentDetail",
                      @"extension" : @"TLMomentExtension"};
        }];
    }
    return self;
}

@end
