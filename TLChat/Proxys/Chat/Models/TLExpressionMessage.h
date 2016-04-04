//
//  TLExpressionMessage.h
//  TLChat
//
//  Created by libokun on 16/3/28.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMessage.h"

@interface TLExpressionMessage : TLMessage

@property (nonatomic, strong) NSString *expGroupID;         // 表情专辑ID
@property (nonatomic, strong) NSString *expItemID;          // 表情ID

@property (nonatomic, strong) NSString *path;

@end
