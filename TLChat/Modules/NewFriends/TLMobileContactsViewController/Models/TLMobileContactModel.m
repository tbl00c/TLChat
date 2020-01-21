//
//  TLMobileContactModel.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMobileContactModel.h"
#import "NSString+PinYin.h"

@implementation TLMobileContactModel

- (id)initWithCoder:(NSCoder *)decoder
{
    self.name = [decoder decodeObjectForKey:@"name"];
    self.avatarPath = [decoder decodeObjectForKey:@"avatarPath"];
    self.avatarURL = [decoder decodeObjectForKey:@"avatarURL"];
    self.tel = [decoder decodeObjectForKey:@"tel"];
    self.status = [decoder decodeIntegerForKey:@"status"];
    self.recordID = [decoder decodeIntForKey:@"recordID"];
    self.email = [decoder decodeObjectForKey:@"email"];
    self.pinyin = [decoder decodeObjectForKey:@"pinyin"];
    self.pinyinInitial = [decoder decodeObjectForKey:@"pinyinInitial"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.avatarPath forKey:@"avatarPath"];
    [encoder encodeObject:self.avatarURL forKey:@"avatarURL"];
    [encoder encodeObject:self.tel forKey:@"tel"];
    [encoder encodeInteger:self.status forKey:@"status"];
    [encoder encodeInt:self.recordID forKey:@"recordID"];
    [encoder encodeObject:self.email forKey:@"email"];
    [encoder encodeObject:self.pinyin forKey:@"pinyin"];
    [encoder encodeObject:self.pinyinInitial forKey:@"pinyinInitial"];
}

- (NSString *)pinyin
{
    if (_pinyin == nil) {
        _pinyin = self.name.pinyin;
    }
    return _pinyin;
}

- (NSString *)pinyinInitial
{
    if (_pinyinInitial == nil) {
        _pinyinInitial = self.name.pinyinInitial;
    }
    return _pinyinInitial;
}

@end
