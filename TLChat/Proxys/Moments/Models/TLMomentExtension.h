//
//  TLMomentExtension.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLBaseDataModel.h"
#import "TLMomentComment.h"

@interface TLMomentExtension : TLBaseDataModel

@property (nonatomic, strong) NSMutableArray *likedFriends;

@property (nonatomic, strong) NSMutableArray *comments;

@end
