//
//  TLExpressionGroupModel+MoreRequest.m
//  TLChat
//
//  Created by 李伯坤 on 2018/1/2.
//  Copyright © 2018年 李伯坤. All rights reserved.
//

#import "TLExpressionGroupModel+MoreRequest.h"
#import "TLNetworking.h"

#define     IEXPRESSION_MORE_URL        [IEXPRESSION_HOST_URL stringByAppendingString:@"expre/listBy.do?pageNumber=%ld&status=Y&status1=B&count=yes"]

@implementation TLExpressionGroupModel (MoreRequest)

+ (TLBaseRequest *)requestExpressionMoreListByPageIndex:(NSInteger)page success:(TLRequestSuccessBlock)success failure:(TLRequestFailureBlock)failure
{
    NSString *urlString = [NSString stringWithFormat:IEXPRESSION_MORE_URL, (long)page];
    [TLNetworking postUrl:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *respArray = [responseObject mj_JSONObject];
        NSString *status = respArray[0];
        if ([status isEqualToString:@"OK"]) {
            NSArray *infoArray = respArray[2];
            NSMutableArray *data = [TLExpressionGroupModel mj_objectArrayWithKeyValuesArray:infoArray];
            if (success) {
                success(data);
            }
        }
        else {
            if (failure) {
                failure(status);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(TLNetworkErrorTip);
        }
    }];
//    NSString *urlString = [NSString stringWithFormat:IEXPRESSION_MORE_URL, (long)page];
//    TLBaseRequest *request = [TLBaseRequest requestWithMethod:TLRequestMethodPOST url:urlString parameters:nil];
//    [request startRequestWithSuccessAction:^(TLResponse *response) {
//        NSArray *respArray = [response.responseData mj_JSONObject];
//        NSString *status = respArray[0];
//        if ([status isEqualToString:@"OK"]) {
//            NSArray *infoArray = respArray[2];
//            NSMutableArray *data = [TLExpressionGroupModel mj_objectArrayWithKeyValuesArray:infoArray];
//            if (success) {
//                success(data);
//            }
//        }
//        else {
//            if (failure) {
//                failure(status);
//            }
//        }
//    } failureAction:^(TLResponse *response) {
//        if (failure) {
//            failure(TLNetworkErrorTip);
//        }
//    }];
//    return request;
    return nil;
}

@end
