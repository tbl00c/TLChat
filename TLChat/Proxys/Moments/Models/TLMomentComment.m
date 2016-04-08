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
        [TLUser mj_setupObjectClassInArray:^NSDictionary *{
            return @{ @"likedFriends" : @"TLUser",
                      @"comments" : @"TLMomentComment"};
        }];
    }
    return self;
}

@end
