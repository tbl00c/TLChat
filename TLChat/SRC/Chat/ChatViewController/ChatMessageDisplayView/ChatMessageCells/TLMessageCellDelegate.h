
//
//  TLMessageCellDelegate.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/2.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TLChatUserProtocol;
@class TLMessage;
@protocol TLMessageCellDelegate <NSObject>

- (void)messageCellDidClickAvatarForUser:(id<TLChatUserProtocol>)user;

- (void)messageCellTap:(TLMessage *)message;

- (void)messageCellLongPress:(TLMessage *)message rect:(CGRect)rect;

- (void)messageCellDoubleClick:(TLMessage *)message;

@end
