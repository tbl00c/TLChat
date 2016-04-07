//
//  TLMomentDetail.h
//  TLChat
//
//  Created by libokun on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLBaseDataModel.h"

@interface TLMomentDetail : TLBaseDataModel

@property (nonatomic, strong) NSString *text;

@property (nonatomic, strong) NSMutableArray *images;

@end
