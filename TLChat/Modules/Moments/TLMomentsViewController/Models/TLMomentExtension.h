//
//  TLMomentExtension.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLMomentComment.h"

@interface TLMomentExtensionFrame : NSObject

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat heightLiked;

@property (nonatomic, assign) CGFloat heightComments;

@end



@interface TLMomentExtension : NSObject

@property (nonatomic, strong) NSArray *likedFriends;
@property (nonatomic, strong, readonly) NSAttributedString *attrLikedFriendsName;
@property (nonatomic, copy) void (^likeUserClickAction)(TLUser *user);

@property (nonatomic, strong) NSArray<TLMomentComment *> *comments;

@property (nonatomic, strong) TLMomentExtensionFrame *extensionFrame;

@end
