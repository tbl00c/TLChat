//
//  TLMacros.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#ifndef TLMacros_h
#define TLMacros_h

#define     APP_CHANNEL         @"Github"

#pragma mark - # Debug
#define     DEBUG_LOCAL_SERVER      // 使用本地测试服务器
//#define     DEBUG_MEMERY            // 内存测试
//#define     DEBUG_JSPATCH           // JSPatch本地测试


#pragma mark - # URL
#define     IEXPRESSION_HOST_URL        @"http://123.57.155.230/ibiaoqing/admin/"


#pragma mark - # SIZE
#define     SIZE_SCREEN                 [UIScreen mainScreen].bounds.size
#define     WIDTH_SCREEN                [UIScreen mainScreen].bounds.size.width
#define     HEIGHT_SCREEN               [UIScreen mainScreen].bounds.size.height
#define     HEIGHT_STATUSBAR            20.0f
#define     HEIGHT_TABBAR               49.0f
#define     HEIGHT_NAVBAR               44.0f
#define     NAVBAR_ITEM_FIXED_SPACE     5.0f

#define     BORDER_WIDTH_1PX            ([[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0)

#define     MAX_MESSAGE_WIDTH               WIDTH_SCREEN * 0.58
#define     MAX_MESSAGE_IMAGE_WIDTH         WIDTH_SCREEN * 0.45
#define     MIN_MESSAGE_IMAGE_WIDTH         WIDTH_SCREEN * 0.25
#define     MAX_MESSAGE_EXPRESSION_WIDTH    WIDTH_SCREEN * 0.35
#define     MIN_MESSAGE_EXPRESSION_WIDTH    WIDTH_SCREEN * 0.2


#define mark - # Default
#define     DEFAULT_AVATAR_PATH    @"default_head"


#pragma mark - # Methods
#define     TLURL(urlString)    [NSURL URLWithString:urlString]
#define     TLNoNilString(str)  (str.length > 0 ? str : @"")
#define     TLWeakSelf(type)    __weak typeof(type) weak##type = type;
#define     TLStrongSelf(type)  __strong typeof(type) strong##type = type;
#define     TLTimeStamp(date)   ([NSString stringWithFormat:@"%lf", [date timeIntervalSince1970]])
#define     TLColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]


#pragma mark - # ThirdPart KEY
// UMeng
#define     UMENG_APPKEY        @"56b8ba33e0f55a15480020b0"
// JSPatch
#define     JSPATCH_APPKEY      @"7eadab71a29a784e"
// 七牛云存储
#define     QINIU_APPKEY        @"28ed72E3r7nfEjApnsHWQhItdqyZqTLCtcfQZp9I"
#define     QINIU_SECRET        @"aRYPqQYF9rK9EVJfcu849VY0PAky2Sfj97Sp349S"
// Mob SMS
#define     MOB_SMS_APPKEY      @"1133dc881b63b"
#define     MOB_SMS_SECRET      @"b4882225b9baee69761071c8cfa848f3"

#endif /* TLMacros_h */
