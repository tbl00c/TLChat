//
//  TLExpressionHelper.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLEmojiGroup.h"

@interface TLExpressionHelper : NSObject

+ (id)sharedHelper;

- (void)downloadExpressionsWithGroupInfo:(TLEmojiGroup *)group
                                progress:(void (^)(CGFloat progress))progress
                                 success:(void (^)(TLEmojiGroup *group))success
                                 failure:(void (^)(TLEmojiGroup *group, NSString *error))failure;

@end
