//
//  TLUser.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLBaseDataModel.h"

@interface TLUser : TLBaseDataModel

/**
 *  用户ID
 */
@property (nonatomic, strong) NSString *userID;

/**
 *  用户名
 */
@property (nonatomic, strong) NSString *username;

/**
 *  头像URL
 */
@property (nonatomic, strong) NSString *avatarURL;

/**
 *  备注名
 */
@property (nonatomic, strong) NSString *remarkName;

@end
