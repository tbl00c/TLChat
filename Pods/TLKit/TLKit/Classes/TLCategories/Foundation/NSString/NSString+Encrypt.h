//
//  NSString+Encrypt.h
//  TLKit
//
//  Created by 李伯坤 on 2017/9/11.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encrypt)

#pragma mark - # AES
/**
 *  AES加密数据
 *
 *  @param key  key 长度一般为16（AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
 *  @param iv  iv
 */
- (NSString*)encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  AES解密数据
 *
 *  @param key key 长度一般为16
 *  @param iv  iv
 */
- (NSString*)decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;

#pragma mark - # DES
/**
 *  DES加密数据
 *
 *  @param key key 长度一般为8
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString*)encryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv;
/**
 *  DE解密数据
 *
 *  @param key key 长度一般为8
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString*)decryptedWithDESUsingKey:(NSString*)key andIV:(NSData*)iv;

#pragma mark - # 3DES
/**
 *  3DES加密数据
 *
 *  @param key key 长度一般为24
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString*)encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;
/**
 *  3DES解密数据
 *
 *  @param key key 长度一般为24
 *  @param iv  iv
 *
 *  @return data
 */
- (NSString*)decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;

@end
