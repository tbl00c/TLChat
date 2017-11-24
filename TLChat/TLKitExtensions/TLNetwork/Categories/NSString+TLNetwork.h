//
//  NSString+TLNetwork.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/13.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TLNetwork)

/// 转换为url
@property (nonatomic, strong, readonly) NSURL *toURL;

/// 获取对应httpsURL
@property (nonatomic, strong, readonly) NSString *httpsUrl;

/// 获取对应httpURL
@property (nonatomic, strong, readonly) NSString *httpUrl;

/// 获取不含http头的URL
@property (nonatomic, strong, readonly) NSString *urlWithoutHttpScheme;

/// 获取不含https头的URL
@property (nonatomic, strong, readonly) NSString *urlWithoutHttpsScheme;


/// 是否含http头或https头
@property (nonatomic, assign, readonly) BOOL hasHttpOrHttpsScheme;

/// 是否含http头
@property (nonatomic, assign, readonly) BOOL hasHttpScheme;

/// 是否含https头
@property (nonatomic, assign, readonly) BOOL hasHttpsScheme;


/// 对url进行编码
@property (nonatomic, strong, readonly) NSString *encode;

/**
 * @param pairs 参数键值对
 * eg：w=100
 * eg: w=100&h=100
 * eg: w=100&h=100&l=100
 */
- (NSString *)appendQueryKeyValuePairs:(NSString *)pairs;

/**
 * @param key 参数键
 * @param value 参数值
 */
- (NSString *)appendQueryKey:(NSString *)key value:(NSString *)value;


@end
