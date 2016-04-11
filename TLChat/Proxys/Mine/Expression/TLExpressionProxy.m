//
//  TLExpressionProxy.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/3.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionProxy.h"
#import "TLEmojiGroup.h"

#define     IEXPRESSION_NEW_URL         @"http://123.57.155.230:8080/ibiaoqing/admin/expre/listBy.do?pageNumber=%ld&status=Y&status1=B"
#define     IEXPRESSION_PUBLIC_URL      @"http://123.57.155.230:8080/ibiaoqing/admin/expre/listBy.do?pageNumber=%ld&status=Y&status1=B&count=yes"
#define     IEXPRESSION_DETAIL_URL      @"http://123.57.155.230:8080/ibiaoqing/admin/expre/getByeId.do?pageNumber=%ld&eId=%@"

@implementation TLExpressionProxy

- (void)requestExpressionChosenListByPageIndex:(NSInteger)pageIndex
                                       success:(void (^)(id data))success
                                       failure:(void (^)(NSString *error))failure
{
    NSString *urlString = [NSString stringWithFormat:IEXPRESSION_NEW_URL, (long)pageIndex];
    [TLNetworking postUrl:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *respArray = [responseObject mj_JSONObject];
        NSString *status = respArray[0];
        if ([status isEqualToString:@"OK"]) {
            NSArray *infoArray = respArray[2];
            NSMutableArray *data = [TLEmojiGroup mj_objectArrayWithKeyValuesArray:infoArray];
            success(data);
        }
        else {
            failure(status);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure([error description]);
    }];
}

- (void)requestExpressionPublicListByPageIndex:(NSInteger)pageIndex
                                       success:(void (^)(id data))success
                                       failure:(void (^)(NSString *error))failure
{
    NSString *urlString = [NSString stringWithFormat:IEXPRESSION_PUBLIC_URL, (long)pageIndex];
    [TLNetworking postUrl:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *respArray = [responseObject mj_JSONObject];
        NSString *status = respArray[0];
        if ([status isEqualToString:@"OK"]) {
            NSArray *infoArray = respArray[2];
            NSMutableArray *data = [TLEmojiGroup mj_objectArrayWithKeyValuesArray:infoArray];
            success(data);
        }
        else {
            failure(status);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure([error description]);
    }];
}


- (void)requestExpressionGroupDetailByGroupID:(NSString *)groupID
                                    pageIndex:(NSInteger)pageIndex
                                      success:(void (^)(id data))success
                                      failure:(void (^)(NSString *error))failure
{
    NSString *urlString = [NSString stringWithFormat:IEXPRESSION_DETAIL_URL, (long)pageIndex, groupID];
    [TLNetworking postUrl:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *respArray = [responseObject mj_JSONObject];
        NSString *status = respArray[0];
        if ([status isEqualToString:@"OK"]) {
            NSArray *infoArray = respArray[2];
            NSMutableArray *data = [TLEmoji mj_objectArrayWithKeyValuesArray:infoArray];
            success(data);
        }
        else {
            failure(status);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure([error description]);
    }];
}

@end
