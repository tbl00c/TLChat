//
//  TLExpressionProxy.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/3.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLExpressionProxy.h"
#import "TLEmojiGroup.h"

@implementation TLExpressionProxy

- (void)requestExpressionChosenListSuccess:(void (^)(id))success
                                   failure:(void (^)(NSString *))failure
{
    TLEmojiGroup *group1 = [[TLEmojiGroup alloc] init];
    group1.groupIconURL = @"http://e.hiphotos.baidu.com/zhidao/pic/item/8601a18b87d6277f52f5409d2b381f30e824fcb4.jpg";
    group1.groupName = @"金馆长";
    group1.groupDetailInfo = @"老板，来个老婆，不要饼!";
    NSMutableArray *data = [[NSMutableArray alloc] initWithArray:@[group1, group1, group1, group1, group1, group1, group1, group1]];
    success(data);
    NSString *urlString = [TLHost expressionChosenURL];
    [TLNetworking postToUrl:urlString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"YES");
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"NO");
    }];
}

@end
