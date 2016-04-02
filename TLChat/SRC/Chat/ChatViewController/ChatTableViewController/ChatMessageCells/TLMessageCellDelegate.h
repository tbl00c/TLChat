
//
//  TLMessageCellDelegate.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/2.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLMessageProtocol.h"

@class TLUser;
@protocol TLMessageCellDelegate <NSObject>

- (void)messageCellDidClickAvatarForUser:(TLUser *)user;

- (void)messageCellLongPress:(id<TLMessageProtocol>)message rect:(CGRect)rect;

- (void)messageCellDoubleClick:(id<TLMessageProtocol>)message;

@end
