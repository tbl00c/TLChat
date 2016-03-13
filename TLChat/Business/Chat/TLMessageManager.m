//
//  TLMessageManager.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/13.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMessageManager.h"
#import "TLDBMessageStore.h"

@interface TLMessageManager ()

@property (nonatomic, strong) TLDBMessageStore *messageStore;

@end

@implementation TLMessageManager

- (void)sendMessage:(TLMessage *)message
           progress:(void (^)(TLMessage *, CGFloat))progress
            success:(void (^)(TLMessage *))success
            failure:(void (^)(TLMessage *))failure
{
    TLDBMessage *dbMessage;
    BOOL ok = [self.messageStore addMessage:dbMessage];
    if (!ok) {
        NSLog(@"存储Message到DB失败");
    }
}

#pragma mark - Getter -
- (TLDBMessageStore *)messageStore
{
    if (_messageStore == nil) {
        _messageStore = [[TLDBMessageStore alloc] init];
    }
    return _messageStore;
}

@end
