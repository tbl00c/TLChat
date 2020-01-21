//
//  TLExpressionModel.m
//  TLChat
//
//  Created by 李伯坤 on 16/2/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionModel.h"
#import "NSFileManager+TLChat.h"
#import "TLMacros.h"

@implementation TLExpressionModel
@synthesize path = _path;

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
             @"eId" : @"pId",
             @"url" : @"Url",
             @"name" : @"credentialName",
             @"emojiPath" : @"imageFile",
             @"size" : @"size",
             };
}

#pragma mark - # Getters
- (NSString *)path
{
    if (_path == nil) {
        NSString *groupPath = [NSFileManager pathExpressionForGroupID:self.gid];
        _path = [NSString stringWithFormat:@"%@%@", groupPath, self.eId];
    }
    return _path;
}

@end
