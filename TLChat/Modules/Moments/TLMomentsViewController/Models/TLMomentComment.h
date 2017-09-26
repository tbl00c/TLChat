//
//  TLMomentComment.h
//  TLChat
//
//  Created by libokun on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLUser.h"

@interface TLMomentCommentFrame : NSObject

@property (nonatomic, assign) CGFloat height;

@end


@interface TLMomentComment : NSObject

@property (nonatomic, strong) TLUser *user;

@property (nonatomic, strong) TLUser *toUser;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong) TLMomentCommentFrame *commentFrame;

@end
