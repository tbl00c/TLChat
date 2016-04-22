//
//  TLMomentExtension.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLBaseDataModel.h"
#import "TLMomentComment.h"

@interface TLMomentExtensionFrame : NSObject

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat heightLiked;

@property (nonatomic, assign) CGFloat heightComments;

@end



@interface TLMomentExtension : TLBaseDataModel

@property (nonatomic, strong) NSMutableArray *likedFriends;

@property (nonatomic, strong) NSMutableArray *comments;

@property (nonatomic, strong) TLMomentExtensionFrame *extensionFrame;

@end
