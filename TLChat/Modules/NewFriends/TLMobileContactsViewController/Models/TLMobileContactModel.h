//
//  TLMobileContactModel.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

/**
 *  通讯录 Model
 */

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TLMobileContactStatus) {
    TLMobileContactStatusStranger,
    TLMobileContactStatusFriend,
    TLMobileContactStatusWait,
};

@interface TLMobileContactModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *avatarPath;

@property (nonatomic, strong) NSString *avatarURL;

@property (nonatomic, strong) NSString *tel;

@property (nonatomic, assign) TLMobileContactStatus status;

@property (nonatomic, assign) int recordID;

@property (nonatomic, assign) NSString *email;

@property (nonatomic, strong) NSString *pinyin;

@property (nonatomic, strong) NSString *pinyinInitial;

@end
