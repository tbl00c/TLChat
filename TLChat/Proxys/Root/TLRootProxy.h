//
//  TLRootProxy.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/13.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLBaseProxy.h"

@interface TLRootProxy : TLBaseProxy

- (void)requestClientInitInfoSuccess:(void (^)(id))clientInitInfo
                             failure:(void (^)(NSString *))error;

- (void)userLoginWithUsername:(NSString *)username
                     password:(NSString *)password
                      success:(void (^)(id))userInfo
                      failure:(void (^)(NSString *))error;


@end
