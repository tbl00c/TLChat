//
//  TLExpressionGroupModel+SearchRequest.h
//  TLChat
//
//  Created by 李伯坤 on 2018/1/2.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLExpressionGroupModel.h"

@interface TLExpressionGroupModel (SearchRequest)

/**
 *  表情搜索
 */
+ (TLBaseRequest *)requestExpressionSearchByKeyword:(NSString *)keyword success:(TLRequestSuccessBlock)success failure:(TLRequestFailureBlock)failure;

@end
