//
//  TLMacros.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#ifndef TLMacros_h
#define TLMacros_h

#pragma mark - # Debug
#define     DEBUG_LOCAL_SERVER      // 使用本地测试服务器
//#define     DEBUG_MEMERY            // 内存测试
//#define     DEBUG_JSPATCH           // JSPatch本地测试


#pragma mark - # URL
#define     HOST_URL                    @"http://101.200.134.35:8000/"
//#define     HOST_URL                    @"http://10.252.146.27:8000/"
#define     IEXPRESSION_HOST_URL        @"http://123.57.155.230/ibiaoqing/admin/"


#pragma mark - # SIZE
#define     NAVBAR_ITEM_FIXED_SPACE     5.0f

#define     BORDER_WIDTH_1PX            ([[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0)

#define     MAX_MESSAGE_WIDTH               SCREEN_WIDTH * 0.58
#define     MAX_MESSAGE_IMAGE_WIDTH         SCREEN_WIDTH * 0.45
#define     MIN_MESSAGE_IMAGE_WIDTH         SCREEN_WIDTH * 0.25
#define     MAX_MESSAGE_EXPRESSION_WIDTH    SCREEN_WIDTH * 0.35
#define     MIN_MESSAGE_EXPRESSION_WIDTH    SCREEN_WIDTH * 0.2


#define mark - # Default
#define     DEFAULT_AVATAR_PATH    @"default_head"


#pragma mark - # Methods
#define     TLTimeStamp(date)   ([NSString stringWithFormat:@"%lf", [date timeIntervalSince1970]])


#endif /* TLMacros_h */
