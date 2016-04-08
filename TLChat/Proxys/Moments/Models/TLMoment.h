//
//  TLMoment.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLBaseDataModel.h"
#import "TLMomentDetail.h"
#import "TLMomentExtension.h"

@interface TLMoment : TLBaseDataModel

@property (nonatomic, strong) NSString *momentID;

@property (nonatomic, strong) NSString *userID;

@property (nonatomic, strong) NSString *avatarURL;

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSDate *date;

/// 详细内容
@property (nonatomic, strong) TLMomentDetail *detail;

/// 附加（评论，赞）
@property (nonatomic, strong) TLMomentExtension *extension;


@end

