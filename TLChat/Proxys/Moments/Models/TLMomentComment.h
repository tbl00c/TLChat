//
//  TLMomentComment.h
//  TLChat
//
//  Created by libokun on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLBaseDataModel.h"

@interface TLMomentComment : TLBaseDataModel

@property (nonatomic, strong) TLUser *user;

@property (nonatomic, strong) TLUser *toUser;

@property (nonatomic, strong) NSString *content;

@property (nonatomic, strong, readonly) NSAttributedString *attrContent;

@end
