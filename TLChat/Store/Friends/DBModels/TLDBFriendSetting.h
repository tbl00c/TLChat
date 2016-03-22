//
//  TLDBFriendSetting.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDBBaseModel.h"

@interface TLDBFriendSetting : TLDBBaseModel

#pragma mark - 设置信息
@property (nonatomic, assign) BOOL starFriend;

@property (nonatomic, assign) BOOL dismissTimeLine;

@property (nonatomic, assign) BOOL prohibitTimeLine;

@property (nonatomic, assign) BOOL blacklist;

@property (nonatomic, strong) NSString *chatBGPath;

#pragma mark - 扩展字段
@property (nonatomic, strong) NSString *ext1;

@property (nonatomic, strong) NSString *ext2;

@property (nonatomic, strong) NSString *ext3;

@property (nonatomic, strong) NSString *ext4;

@property (nonatomic, strong) NSString *ext5;

@end
