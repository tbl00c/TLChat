//
//  TLDBMessage.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/13.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLDBMessage : NSObject

#pragma mark - 基本信息
@property (nonatomic, strong, nonnull) NSString *msgID;

@property (nonatomic, strong, nonnull) NSString *userID;

@property (nonatomic, strong, nonnull) NSString *friendID;

@property (nonatomic, assign) NSInteger ownerType;

@property (nonatomic, strong, nonnull) NSString *date;


#pragma mark - 消息内容
@property (nonatomic, assign) NSInteger msgType;

@property (nonatomic, strong, nonnull) NSString *content;


#pragma mark - 消息状态
@property (nonatomic, assign) NSInteger sendStatus;

@property (nonatomic, assign) NSInteger receivedStatus;


#pragma mark - 扩展字段
@property (nonatomic, strong, nonnull) NSString *ext1;

@property (nonatomic, strong, nonnull) NSString *ext2;

@property (nonatomic, strong, nonnull) NSString *ext3;

@property (nonatomic, strong, nonnull) NSString *ext4;

@property (nonatomic, strong, nonnull) NSString *ext5;

@end
