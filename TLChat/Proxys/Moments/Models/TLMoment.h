//
//  TLMoment.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLBaseDataModel.h"

@interface TLMoment : TLBaseDataModel

@property (nonatomic, strong) NSString *momentID;

@property (nonatomic, strong) NSString *userID;

@property (nonatomic, strong) NSString *avatarURL;

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSDate *date;


#pragma mark - 内容 -
@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSMutableArray *images;

@end
