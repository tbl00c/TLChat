//
//  TLMessage.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLBaseDataModel.h"
#import "TLUser.h"
#import "TLMessageFrame.h"
#import <MapKit/MapKit.h>

/**
 *  消息所有者类型
 */
typedef NS_ENUM(NSInteger, TLPartnerType){
    TLPartnerTypeUser,          // 用户
    TLPartnerTypeGroup,         // 群聊
};

/**
 *  消息拥有者
 */
typedef NS_ENUM(NSInteger, TLMessageOwnerType){
    TLMessageOwnerTypeUnknown,  // 未知的消息拥有者
    TLMessageOwnerTypeSystem,   // 系统消息
    TLMessageOwnerTypeSelf,     // 自己发送的消息
    TLMessageOwnerTypeFriend,   // 接收到的他人消息
};

/**
 *  消息发送状态
 */
typedef NS_ENUM(NSInteger, TLMessageSendState){
    TLMessageSendSuccess,       // 消息发送成功
    TLMessageSendFail,          // 消息发送失败
};

/**
 *  消息读取状态
 */
typedef NS_ENUM(NSInteger, TLMessageReadState) {
    TLMessageUnRead,            // 消息未读
    TLMessageReaded,            // 消息已读
};

@interface TLMessage : TLBaseDataModel

@property (nonatomic, strong) NSString *messageID;                  // 消息ID
@property (nonatomic, strong) NSString *userID;                     // 发送者ID
@property (nonatomic, strong) NSString *friendID;                   // 接收者ID
@property (nonatomic, strong) NSString *groupID;                    // 讨论组ID（无则为nil）
@property (nonatomic, strong) TLUser *fromUser;                     // 发送者

@property (nonatomic, strong) NSDate *date;                         // 发送时间

@property (nonatomic, assign) TLPartnerType partnerType;            // 对方类型
@property (nonatomic, assign) TLMessageType messageType;            // 消息类型
@property (nonatomic, assign) TLMessageOwnerType ownerTyper;        // 发送者类型
@property (nonatomic, assign) TLMessageReadState readState;         // 读取状态
@property (nonatomic, assign) TLMessageSendState sendState;         // 发送状态

@property (nonatomic, assign) BOOL showTime;
@property (nonatomic, assign) BOOL showName;

#pragma mark - 文字消息
@property (nonatomic, strong) NSString *text;                       // 文字信息
@property (nonatomic, strong) NSAttributedString *attrText;         // 格式化的文字信息（仅展示用）

#pragma mark - 图片消息
@property (nonatomic, strong) NSString *imagePath;                  // 本地图片Path
@property (nonatomic, strong) NSString *imageURL;                   // 网络图片URL

#pragma mark - 位置消息
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;    // 经纬度
@property (nonatomic, strong) NSString *address;                    // 地址

#pragma mark - 语音消息
@property (nonatomic, assign) NSUInteger voiceSeconds;              // 语音时间
@property (nonatomic, strong) NSString *voiceUrl;                   // 网络语音URL
@property (nonatomic, strong) NSString *voicePath;                  // 本地语音Path


@property (nonatomic, strong) TLMessageFrame *frame;                // 消息frame

@property (nonatomic, strong) NSString *messageCopy;

@end