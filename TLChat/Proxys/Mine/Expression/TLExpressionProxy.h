//
//  TLExpressionProxy.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/3.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLBaseProxy.h"

@interface TLExpressionProxy : TLBaseProxy

- (void)requestExpressionChosenListSuccess:(void (^)(id data))success
                                   failure:(void (^)(NSString *error))failure;

@end
