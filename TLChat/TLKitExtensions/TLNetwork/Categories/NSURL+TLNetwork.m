//
//  NSURL+TLNetwork.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/13.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "NSURL+TLNetwork.h"

@implementation NSURL (TLNetwork)

- (BOOL)isHttpURL
{
    return [self.absoluteString hasPrefix:@"http:"];
}

- (BOOL)isHttpsURL
{
    return [self.absoluteString hasPrefix:@"https:"];
}

@end
