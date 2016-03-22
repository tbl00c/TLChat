//
//  TLDBFriendDetail.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDBBaseModel.h"

@interface TLDBFriendDetail : TLDBBaseModel

#pragma mark - 详细资料
@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, strong) NSString *phoneNumber;

@property (nonatomic, strong) NSString *location;

@property (nonatomic, strong) NSString *albums;

@property (nonatomic, strong) NSString *motto;

@property (nonatomic, strong) NSString *channel;

@property (nonatomic, strong) NSString *describe;

@property (nonatomic, strong) NSString *describeImage;

#pragma mark - 扩展字段
@property (nonatomic, strong) NSString *ext1;

@property (nonatomic, strong) NSString *ext2;

@property (nonatomic, strong) NSString *ext3;

@property (nonatomic, strong) NSString *ext4;

@property (nonatomic, strong) NSString *ext5;

@end
