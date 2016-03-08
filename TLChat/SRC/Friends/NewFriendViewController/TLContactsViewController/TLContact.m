//
//  TLContact.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLContact.h"
#import "NSString+PinYin.h"

@implementation TLContact

- (NSString *)pinyin
{
    if (_pinyin == nil) {
        _pinyin = self.name.pinyin;
    }
    return _pinyin;
}

@end
