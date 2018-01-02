//
//  TLExpressionGroupModel+MoreRequest.h
//  TLChat
//
//  Created by 李伯坤 on 2018/1/2.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLExpressionGroupModel.h"

@interface TLExpressionGroupModel (MoreRequest)

/**
 *  更多表情 —— 更多列表
 */
+ (TLBaseRequest *)requestExpressionMoreListByPageIndex:(NSInteger)page success:(TLRequestSuccessBlock)success failure:(TLRequestFailureBlock)failure;

@end
