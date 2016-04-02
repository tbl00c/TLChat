//
//  TLMessage.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/15.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLBaseDataModel.h"
#import "TLUser.h"
#import <MapKit/MapKit.h>
#import "TLMessageProtocol.h"

@interface TLMessage : TLBaseDataModel <TLMessageProtocol>
{
    TLMessageFrame *kMessageFrame;
}

@property (nonatomic, strong) TLUser *fromUser;                     // 发送者

+ (id<TLMessageProtocol>)createMessageByType:(TLMessageType)type;

@end