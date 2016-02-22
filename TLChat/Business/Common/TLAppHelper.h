//
//  TLAppHelper.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TLAppHelper : NSObject

@property (nonatomic, strong) NSString *version;

+ (TLAppHelper *)sharedHelper;

@end
