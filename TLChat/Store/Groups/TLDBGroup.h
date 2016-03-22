//
//  TLDBGroup.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDBBaseModel.h"

@interface TLDBGroup : TLDBBaseModel

#pragma mark - 群基本信息
@property (nonatomic, strong) NSString *groupID;

@property (nonatomic, strong) NSString *groupName;

@property (nonatomic, strong) NSString *creatorID;

@property (nonatomic, strong) NSString *post;

#pragma mark - 个人信息
@property (nonatomic, strong) NSString *myName;

#pragma mark - 设置信息
@property (nonatomic, assign) BOOL noDisturb;

@property (nonatomic, assign) BOOL top;

@property (nonatomic, assign) BOOL saveToContacts;

@property (nonatomic, assign) BOOL showName;

@property (nonatomic, assign) NSString *chatBGPath;

#pragma mark - 扩展字段
@property (nonatomic, strong) NSString *ext1;

@property (nonatomic, strong) NSString *ext2;

@property (nonatomic, strong) NSString *ext3;

@property (nonatomic, strong) NSString *ext4;

@property (nonatomic, strong) NSString *ext5;


@end
