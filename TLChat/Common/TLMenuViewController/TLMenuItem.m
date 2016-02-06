//
//  TLMenuItem.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMenuItem.h"

@implementation TLMenuItem

+ (TLMenuItem *) createMenuWithIconPath:(NSString *)iconPath title:(NSString *)title
{
    TLMenuItem *item = [[TLMenuItem alloc] init];
    item.iconPath = iconPath;
    item.title = title;
    return item;
}

@end
