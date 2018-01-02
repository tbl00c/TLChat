//
//  TLExpressionGroupModel+DetailRequest.h
//  TLChat
//
//  Created by 李伯坤 on 2018/1/2.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLExpressionGroupModel.h"

@interface TLExpressionGroupModel (DetailRequest)

/**
 *  表情详情
 */
- (TLBaseRequest *)requestExpressionGroupDetailByPageIndex:(NSInteger)pageIndex success:(TLRequestSuccessBlock)success failure:(TLRequestFailureBlock)failure;

@end
