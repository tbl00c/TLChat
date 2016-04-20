//
//  TLExpressionProxy.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/3.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLBaseProxy.h"

@interface TLExpressionProxy : TLBaseProxy

/**
 *  精选表情
 */
- (void)requestExpressionChosenListByPageIndex:(NSInteger)page
                                       success:(void (^)(id data))success
                                       failure:(void (^)(NSString *error))failure;

/**
 *  竞选表情Banner
 */
- (void)requestExpressionChosenBannerSuccess:(void (^)(id data))success
                                     failure:(void (^)(NSString *error))failure;

/**
 *  网络表情
 */
- (void)requestExpressionPublicListByPageIndex:(NSInteger)page
                                       success:(void (^)(id data))success
                                       failure:(void (^)(NSString *error))failure;

/**
 *  表情搜索
 */
- (void)requestExpressionSearchByKeyword:(NSString *)keyword
                                 success:(void (^)(id data))success
                                 failure:(void (^)(NSString *error))failure;

/**
 *  表情详情
 */
- (void)requestExpressionGroupDetailByGroupID:(NSString *)groupID
                                    pageIndex:(NSInteger)pageIndex
                                      success:(void (^)(id data))success
                                      failure:(void (^)(NSString *error))failure;

@end
