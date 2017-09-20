//
//  TLUserChatSetting.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLUserChatSetting : NSObject

@property (nonatomic, strong) NSString *userID;

@property (nonatomic, assign) BOOL top;

@property (nonatomic, assign) BOOL noDisturb;

@property (nonatomic, strong) NSString *chatBGPath;

@end
