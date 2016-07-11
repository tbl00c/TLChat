//
//  TLVoiceMessage.h
//  TLChat
//
//  Created by 李伯坤 on 16/7/11.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLMessage.h"

@interface TLVoiceMessage : TLMessage

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) CGFloat time;

@end
