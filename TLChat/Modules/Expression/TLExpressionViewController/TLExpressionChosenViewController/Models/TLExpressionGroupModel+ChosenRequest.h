//
//  TLExpressionGroupModel+ChosenRequest.h
//  TLChat
//
//  Created by 李伯坤 on 2018/1/2.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLExpressionGroupModel.h"
#import "TLPictureCarouselProtocol.h"

@interface TLExpressionGroupModel (ChosenRequest)

/**
 *  表情精选 - Banner
 */
+ (TLBaseRequest *)requestExpressionChosenBannerSuccess:(TLRequestSuccessBlock)success failure:(TLRequestFailureBlock)failure;

/**
 *  表情精选 - 推荐模块
 */
+ (void)requestExpressionRecommentListSuccess:(TLRequestSuccessBlock)success failure:(TLRequestFailureBlock)failure;

/**
 *  表情精选 - 更多模块
 */
+ (TLBaseRequest *)requestExpressionChosenListByPageIndex:(NSInteger)page success:(TLRequestSuccessBlock)success failure:(TLRequestFailureBlock)failure;


@end
