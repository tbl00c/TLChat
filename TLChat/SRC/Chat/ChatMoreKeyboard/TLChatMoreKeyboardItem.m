//
//  TLChatMoreKeyboardItem.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/18.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLChatMoreKeyboardItem.h"

@implementation TLChatMoreKeyboardItem

+ (TLChatMoreKeyboardItem *)createByTitle:(NSString *)title imagePath:(NSString *)imagePath
{
    TLChatMoreKeyboardItem *item = [[TLChatMoreKeyboardItem alloc] init];
    item.title = title;
    item.imagePath = imagePath;
    return item;
}

@end
