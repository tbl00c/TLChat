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
 *  昵称
 */
@property (nonatomic, strong) NSString *nikeName;

/**
 *  头像URL
 */
@property (nonatomic, strong) NSString *avatarURL;

/**
 *  头像Path
 */
@property (nonatomic, strong) NSString *avatarPath;

/**
 *  备注名
 */
@property (nonatomic, strong) NSString *remarkName;

/**
 *  拼音  
 *
 *  来源：备注 > 昵称 > 用户名
 */
@property (nonatomic, strong) NSString *pinyin;

@property (nonatomic, strong) NSString *pinyinInitial;

- (id) initWithUserID:(NSString *)userID avatarPath:(NSString *)avatarPath remarkName:(NSString *)remarkName;

@end
