//
//  TLContect.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TLContectStatus) {
    TLContactStatusFriend,
    TLContactStatusWait,
    TLContactStatusStranger,
};

@interface TLContect : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *avatarPath;

@property (nonatomic, strong) NSString *avatarURL;

@property (nonatomic, strong) NSString *tel;

@property (nonatomic, assign) TLContectStatus status;

@property (nonatomic, assign) int recordID;

@property (nonatomic, assign) NSString *email;

@end
