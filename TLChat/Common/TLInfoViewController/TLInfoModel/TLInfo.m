//
//  TLInfo.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLInfo.h"

@implementation TLInfo

+ (TLInfo *)createInfoWithTitle:(NSString *)title subTitle:(NSString *)subTitle
{
    TLInfo *info = [[TLInfo alloc] init];
    info.title = title;
    info.subTitle = subTitle;
    return info;
}

@end
