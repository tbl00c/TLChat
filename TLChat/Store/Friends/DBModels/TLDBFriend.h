//
//  TLDBFriend.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDBBaseModel.h"

@interface TLDBFriend : TLDBBaseModel

#pragma mark - 基本信息
@property (nonatomic, strong) NSString *fid;

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSString *nikename;

@property (nonatomic, strong) NSString *avatarPath;

@property (nonatomic, strong) NSString *avatarURL;

@property (nonatomic, strong) NSString *remarkname;

#pragma mark - 扩展字段
@property (nonatomic, strong) NSString *ext1;

@property (nonatomic, strong) NSString *ext2;

@property (nonatomic, strong) NSString *ext3;

@property (nonatomic, strong) NSString *ext4;

@property (nonatomic, strong) NSString *ext5;

@end
