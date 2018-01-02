//
//  TLExpressionMessage.h
//  TLChat
//
//  Created by libokun on 16/3/28.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMessage.h"
#import "TLExpressionModel.h"

@interface TLExpressionMessage : TLMessage

@property (nonatomic, strong) TLExpressionModel *emoji;

@property (nonatomic, strong, readonly) NSString *path;

@property (nonatomic, strong, readonly) NSString *url;

@property (nonatomic, assign, readonly) CGSize emojiSize;

@end
