//
//  TLMoments.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLBaseDataModel.h"

@interface TLBell : TLBaseDataModel

@property (nonatomic, strong) NSString *bellURL;

@property (nonatomic, strong) NSString *bellIconURL;

@property (nonatomic, strong) NSString *bellTitle;

@end

@interface TLMoments : TLBaseDataModel

@property (nonatomic, strong) NSString *userID;

@property (nonatomic, strong) NSString *avatarURL;

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSDate *date;


#pragma mark - 内容 -
@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSMutableArray *images;

//@property (nonatomic, strong)

@end
