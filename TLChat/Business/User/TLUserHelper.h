//
//  TLUserHelper.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLUser.h"

@interface TLUserHelper : NSObject

@property (nonatomic, strong) TLUser *user;

@property (nonatomic, strong, readonly) NSString *userID;

+ (TLUserHelper *) sharedHelper;

@end
