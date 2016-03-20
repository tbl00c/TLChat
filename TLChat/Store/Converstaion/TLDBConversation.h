//
//  TLDBConversation.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLDBConversation : NSObject

#pragma mark - 基本信息
@property (nonatomic, strong) NSString *uid;

@property (nonatomic, strong) NSString *fid;

@property (nonatomic, assign) NSInteger unreadCount;


#pragma mark - 扩展字段
@property (nonatomic, strong) NSString *ext1;

@property (nonatomic, strong) NSString *ext2;

@property (nonatomic, strong) NSString *ext3;

@property (nonatomic, strong) NSString *ext4;

@property (nonatomic, strong) NSString *ext5;


@end
