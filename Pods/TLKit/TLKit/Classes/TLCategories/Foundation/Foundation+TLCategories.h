//
//  Foundation+TLCategories.h
//  TLKit
//
//  Created by 李伯坤 on 2017/9/12.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#ifndef Foundation_TLCategories_h
#define Foundation_TLCategories_h

//MAKR: NSObject
#import "NSObject+Association.h"            // NSObject 利用runtime动态添加属性（支持strong）
#import "NSObject+EasyCopy.h"               // NSObject 快捷copy、深copy
#import "NSObject+KVOBlock.h"               // NSObject KVO
#import "NSObject+Reflection.h"             // NSObject 获取类关系

//MARK: NSString
#import "NSString+Contains.h"               // NSString 包含Emoji、空格等判断
#import "NSString+NormalRegex.h"            // NSString 常用正则匹配
#import "NSString+Size.h"                   // NSString 计算字符串大小
#import "NSString+URL.h"                    // NSString URL编码、解码相关
#import "NSString+Base64.h"                 // NSString Base64编解码
#import "NSString+Hash.h"                   // NSString Md5、sha1等hash计算
#import "NSString+Encrypt.h"                // NSString AES、Des等加解密
#import "NSString+PinYin.h"                 // NSString 获取汉字拼音
#import "NSString+StringPages.h"            // NSString 对字符串进行分页

//MARK: NSData
#import "NSData+Base64.h"                   // NSData Base64编解码
#import "NSData+Encrypt.h"                  // NSData AES、Des等加解密
#import "NSData+Gzip.h"                     // NSData Gzip
#import "NSData+Hash.h"                     // NSData Md5、sha1等hash计算

//MARK: NSArray
#import "NSArray+SafeAccess.h"              // NSArray 数组安全取值、类型取值等

//MARK: NSMutableArray
#import "NSMutableArray+SafeAccess.h"       // NSMutableArray 安全添加值、类型添加值等

//MARK: NSDictionary
#import "NSDictionary+Extensions.h"         // NSDictionary 合并字典等
#import "NSDictionary+SafeAccess.h"         // NSDictionary 安全取值、类型取值等

//MARK: NSMutableDictionary
#import "NSMutableDictionary+SafeAccess.h"  // NSMutableDictionary 安全添加值、类型添加值等

//MARK: NSURL
#import "NSURL+Params.h"                    // NSURL 获取url中的参数等

//MARK: NSDate
#import "NSDate+Extensions.h"               // NSDate 时间日期快速获取
#import "NSDate+Relation.h"                 // DSDate 时间关系

//MARK: NSTimer
#import "NSTimer+Block.h"                   // NSTimer 定时器

//MARK: NSFileManager
#import "NSFileManager+Paths.h"             // NSFileManager 常用文件路径等

//MARK: NSNotificationCenter
#import "NSNotificationCenter+MainThread.h" // NSNotificationCenter 主线程发送广播

//MARK: NSBundle
#import "NSBundle+AppIcon.h"                // NSBundle 获取AppIcon等


#endif /* Foundation_TLCategories_h */
