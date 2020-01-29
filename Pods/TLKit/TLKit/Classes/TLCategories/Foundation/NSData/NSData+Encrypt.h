//
//  NSData+Encrypt.h
//  TLKit
//
//  Created by 李伯坤 on 2017/9/11.
//  Copyright © 2017年 李伯坤. All rights reserved.
//
// 加密解密工具 http://tool.chacuo.net/cryptdes

#import <Foundation/Foundation.h>


@interface NSData (Encrypt)

#pragma mark - AES
/**
 *  利用AES加密数据
 *
 *  @param key  key 长度一般为16（AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
 *  @param iv  iv description
 */
- (NSData *)encryptedWithAESUsingKey:(NSString*)key andIV:(NSData *)iv;

/**
 *  @brief  利用AES解密数据
 *
 *  @param key key 长度一般为16 （AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
 *  @param iv  iv
 */
- (NSData *)decryptedWithAESUsingKey:(NSString*)key andIV:(NSData *)iv;

#pragma mark - DES
/**
 *  利用DES加密数据
 *
 *  @param key key 长度一般为8
 *  @param iv  iv description
 */
- (NSData *)encryptedWithDESUsingKey:(NSString*)key andIV:(NSData *)iv;
/**
 *  @brief   利用DES解密数据
 *
 *  @param key key 长度一般为8
 *  @param iv  iv
 */
- (NSData *)decryptedWithDESUsingKey:(NSString*)key andIV:(NSData *)iv;

#pragma mark - 3DES
/**
 *  利用3DES加密数据
 *
 *  @param key key 长度一般为24
 *  @param iv  iv description
 */
- (NSData *)encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData *)iv;
/**
 *  利用3DES解密数据
 *
 *  @param key key 长度一般为24
 *  @param iv  iv
 */
- (NSData *)decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData *)iv;

/**
 *  NSData 转成UTF8 字符串
 */
- (NSString *)UTF8String;

@end
