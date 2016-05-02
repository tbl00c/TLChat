//
//  TLChatViewControllerProxy.h
//  TLChat
//
//  Created by 李伯坤 on 16/5/1.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TLImageMessage;
@protocol TLChatViewControllerProxy <NSObject>

@optional;
- (void)didClickedUserAvatar:(TLUser *)user;

- (void)didClickedImageMessages:(NSArray *)imageMessages atIndex:(NSInteger)index;

@end
