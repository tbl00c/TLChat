//
//  TLDBMessageStore.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/13.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDBBaseStore.h"
#import "TLDBMessage.h"

@interface TLDBMessageStore : TLDBBaseStore

- (BOOL)addMessage:(TLDBMessage *)message;


@end
