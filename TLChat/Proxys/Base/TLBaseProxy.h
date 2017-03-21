//
//  TLBaseProxy.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/13.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLNetworking.h"

// 网络请求成功回调
typedef void(^TLBlockRequestSuccessWithDatas)(id datas);

// 网络请求失败回调
typedef void(^TLBlockRequestFailureWithErrorMessage)(NSString * errMsg);

@interface TLBaseProxy : NSObject

@end
