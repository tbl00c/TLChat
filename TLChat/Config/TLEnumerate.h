//
//  TLEnumerate.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#ifndef TLEnumerate_h
#define TLEnumerate_h

#import <Foundation/Foundation.h>


/**
 *  消息类型
 */
typedef NS_ENUM(NSInteger, TLMessageType) {
    TLMessageTypeUnknown,
    TLMessageTypeText,          // 文字
    TLMessageTypeImage,         // 图片
    TLMessageTypeExpression,    // 表情
    TLMessageTypeVoice,         // 语音
    TLMessageTypeVideo,         // 视频
    TLMessageTypeURL,           // 链接
    TLMessageTypePosition,      // 位置
    TLMessageTypeBusinessCard,  // 名片
    TLMessageTypeSystem,        // 系统
    TLMessageTypeOther,
};



#endif /* TLEnumerate_h */
