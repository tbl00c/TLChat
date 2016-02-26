//
//  TLInfo.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLInfo : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *subTitle;

@property (nonatomic, strong) NSMutableArray *subImageArray;

+ (TLInfo *)createInfoWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

@end
