//
//  NSHTTPURLResponse+TLNetwork.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/14.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "NSHTTPURLResponse+TLNetwork.h"

@implementation NSHTTPURLResponse (TLNetwork)

- (NSStringEncoding)stringEncoding
{
    if (self.textEncodingName) {
        CFStringEncoding encoding = CFStringConvertIANACharSetNameToEncoding((CFStringRef)self.textEncodingName);
        if (encoding != kCFStringEncodingInvalidId) {
            return CFStringConvertEncodingToNSStringEncoding(encoding);
        }
    }
    return NSUTF8StringEncoding;
}

@end
