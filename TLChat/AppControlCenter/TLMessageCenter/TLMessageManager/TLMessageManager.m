//
//  TLMessageManager.m
//  TLChat
//
//  Created by 李伯坤 on 16/3/13.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMessageManager.h"
#import "TLMessageManager+ConversationRecord.h"
#import "TLUserHelper.h"
#import "TLNetwork.h"

#import "TLFriendHelper.h"
#import "TLTextMessage.h"
#import "TLImageMessage.h"

static TLMessageManager *messageManager;

@implementation TLMessageManager

+ (TLMessageManager *)sharedInstance
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        messageManager = [[TLMessageManager alloc] init];
    });
    return messageManager;
}

- (void)sendMessage:(TLMessage *)message
           progress:(void (^)(TLMessage *, CGFloat))progress
            success:(void (^)(TLMessage *))success
            failure:(void (^)(TLMessage *))failure
{
    if (message.messageType == TLMessageTypeText) {
        NSString *text = [message.content objectForKey:@"text"];
        NSDictionary *json = @{@"reqType" : @"0",
                               @"userInfo" : @{
                                       @"apiKey" : @"44eb0b4ab0a640f192bd469551a7c03e",
                                       @"userId" : @"100454",
                                       },
                               @"perception" : @{
                                       @"inputText" : @{
                                               @"text" : text,
                                               }
                                       },
                               };
        NSString *url = @"http://openapi.tuling123.com/openapi/api/v2";
        TLBaseRequest *request = [TLBaseRequest requestWithMethod:TLRequestMethodPOST url:url parameters:json];
        [request startRequestWithSuccessAction:^(TLResponse *response) {
            if (success) {
                success(message);
            }
            NSDictionary *json = response.responseObject;
            NSArray *results = [json objectForKey:@"results"];
            TLUser *user;
            if (message.partnerType == TLPartnerTypeGroup) {
                TLGroup *group = [[TLFriendHelper sharedFriendHelper] getGroupInfoByGroupID:message.groupID];
                NSInteger index = arc4random() % group.count;
                user = group.users[index];
            }
            else {
                user = [[TLFriendHelper sharedFriendHelper] getFriendInfoByUserID:message.friendID];
            }
            for (NSDictionary *item in results) {
                NSDictionary *values = [item objectForKey:@"values"];
                if (values[@"text"]) {
                    NSString *text = values[@"text"];
                    TLTextMessage *textMessage = [[TLTextMessage alloc] init];
                    textMessage.partnerType = message.partnerType;
                    textMessage.text = text;
                    textMessage.ownerTyper = TLMessageOwnerTypeFriend;
                    textMessage.userID = message.userID;
                    textMessage.date = [NSDate date];
                    textMessage.friendID = user.userID;
                    textMessage.fromUser = user;
                    textMessage.groupID = message.groupID;
                    [self.messageStore addMessage:textMessage];
                    if (self.messageDelegate && [self.messageDelegate respondsToSelector:@selector(didReceivedMessage:)]) {
                        [self.messageDelegate didReceivedMessage:textMessage];
                    }
                }
                else if (values[@"image"]) {
                    NSString *imageURL = values[@"image"];
                    TLImageMessage *imageMessage = [[TLImageMessage alloc] init];
                    imageMessage.partnerType = message.partnerType;
                    imageMessage.imageURL = imageURL;
                    imageMessage.ownerTyper = TLMessageOwnerTypeFriend;
                    imageMessage.userID = message.userID;
                    imageMessage.friendID = user.userID;
                    imageMessage.date = [NSDate date];
                    imageMessage.fromUser = user;
                    imageMessage.imageSize = CGSizeMake(120, 120);
                    imageMessage.groupID = message.groupID;
                    [self.messageStore addMessage:imageMessage];
                    if (self.messageDelegate && [self.messageDelegate respondsToSelector:@selector(didReceivedMessage:)]) {
                        [self.messageDelegate didReceivedMessage:imageMessage];
                    }
                }
            }
        } failureAction:^(TLResponse *response) {
            if (failure) {
                failure(message);
            }
        }];
    }
    
    
    BOOL ok = [self.messageStore addMessage:message];
    if (!ok) {
        DDLogError(@"存储Message到DB失败");
    }
    else {      // 存储到conversation
        ok = [self addConversationByMessage:message];
        if (!ok) {
            DDLogError(@"存储Conversation到DB失败");
        }
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

- (TLDBConversationStore *)conversationStore
{
    if (_conversationStore == nil) {
        _conversationStore = [[TLDBConversationStore alloc] init];
    }
    return _conversationStore;
}

- (NSString *)userID
{
    return [TLUserHelper sharedHelper].userID;
}

@end
