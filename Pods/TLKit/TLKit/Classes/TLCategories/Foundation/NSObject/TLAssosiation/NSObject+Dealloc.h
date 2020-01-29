//
//  NSObject+Dealloc.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/12.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TLDeallocBlock)(void);

@interface NSObject (Dealloc)

- (void)addDeallocTask:(TLDeallocBlock)deallocTask forTarget:(id)target key:(NSString *)key;

- (void)removeDeallocTaskForTarget:(id)target key:(NSString *)key;

@end
