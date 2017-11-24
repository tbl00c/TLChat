//
//  NSURL+TLNetwork.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/13.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (TLNetwork)

@property (nonatomic, assign, readonly) BOOL isHttpURL;

@property (nonatomic, assign, readonly) BOOL isHttpsURL;



@end
