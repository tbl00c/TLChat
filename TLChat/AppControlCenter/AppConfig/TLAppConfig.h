//
//  TLAppConfig.h
//  TLChat
//
//  Created by 李伯坤 on 2017/9/20.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLAppConfig : NSObject

/// App 版本信息
@property (nonatomic, strong, readonly) NSString *version;

/// 消息页面，+菜单项
@property (nonatomic, strong) NSArray *addMenuItems;

+ (TLAppConfig *)sharedConfig;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end
