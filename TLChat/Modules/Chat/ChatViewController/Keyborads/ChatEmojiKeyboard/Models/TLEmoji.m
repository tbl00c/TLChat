//
//  TLEmoji.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLEmoji.h"
#import "NSFileManager+TLChat.h"
#import "TLMacros.h"

@implementation TLEmoji

+ (NSString *)expressionURLWithEid:(NSString *)eid
{
    return [NSString stringWithFormat:@"%@expre/downloadsuo.do?pId=%@", IEXPRESSION_HOST_URL, eid];
}

+ (NSString *)expressionDownloadURLWithEid:(NSString *)eid
{
    return [NSString stringWithFormat:@"%@expre/download.do?pId=%@", IEXPRESSION_HOST_URL, eid];
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"emojiID" : @"pId",
             @"emojiURL" : @"Url",
             @"emojiName" : @"credentialName",
             @"emojiPath" : @"imageFile",
             @"size" : @"size",
             };
}

- (NSString *)emojiPath
{
    if (_emojiPath == nil) {
        NSString *groupPath = [NSFileManager pathExpressionForGroupID:self.groupID];
        _emojiPath = [NSString stringWithFormat:@"%@%@", groupPath, self.emojiID];
    }
    return _emojiPath;
}

@end
