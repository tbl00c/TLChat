//
//  TLDBMessage+TLMessage.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/13.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDBMessage.h"
#import "TLMessage.h"

@interface TLDBMessage (TLMessage)

- (id<TLMessageProtocol>)toMessage;

@end

@interface TLMessage (TLDBMessage)

- (TLDBMessage *)toDBMessage;

@end
