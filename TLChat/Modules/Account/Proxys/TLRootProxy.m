//
//  TLRootProxy.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/13.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLRootProxy.h"
#import "TLMacros.h"
#import "TLNetworking.h"

#define     URL_LOGIN           @"account/login/"
#define     URL_REGISTER        @"account/register/"

@implementation TLRootProxy

- (void)requestClientInitInfoSuccess:(void (^)(id)) clientInitInfo
                             failure:(void (^)(NSString *))error
{
//    NSString *urlString = [TLHost clientInitInfoURL];
//    [TLNetworking postUrl:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"OK");
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"NO");
//    }];
}

- (void)userLoginWithPhoneNumber:(NSString *)phoneNumber
                        password:(NSString *)password
                         success:(TLBlockRequestSuccessWithDatas)success
                         failure:(TLBlockRequestFailureWithErrorMessage)failure
{
    NSString *url = [HOST_URL stringByAppendingString:URL_LOGIN];
    NSDictionary *params = @{@"phoneNumber" : phoneNumber,
                             @"password" : password};
    [TLNetworking postUrl:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *json = [responseObject mj_JSONObject];
        NSInteger status = [json[@"status"] integerValue];
        if (status == 1) {
            NSDictionary *data = json[@"content"];
            NSString *token = data[@"token"];
            if (success) {
                success(token);
            }
        }
        else {
            NSString *errorMsg = json[@"content"];
            if (failure) {
                failure(errorMsg);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(@"网络请求失败");
        }
    }];
}

- (void)userRegisterWithPhoneNumber:(NSString *)phoneNumber
                           password:(NSString *)password
                            success:(TLBlockRequestSuccessWithDatas)success
                            failure:(TLBlockRequestFailureWithErrorMessage)failure
{
    NSString *url = [HOST_URL stringByAppendingString:URL_REGISTER];
    NSDictionary *params = @{@"phoneNumber" : phoneNumber,
                             @"password" : password};
    [TLNetworking postUrl:url parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *json = [responseObject mj_JSONObject];
        NSInteger status = [json[@"status"] integerValue];
        if (status == 1) {
            NSDictionary *data = json[@"content"];
            NSString *token = data[@"token"];
            if (success) {
                success(token);
            }
        }
        else {
            NSString *errorMsg = json[@"content"];
            if (failure) {
                failure(errorMsg);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(@"网络请求失败");
        }
    }];
}

@end
