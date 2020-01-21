//
//  NSObject+Dealloc.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/12.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "NSObject+Dealloc.h"
#import <objc/runtime.h>
#import "TLDeallocTask.h"

static const char kTask = '0';

@implementation NSObject (Dealloc)

- (void)addDeallocTask:(TLDeallocBlock)deallocTask forTarget:(id)target key:(NSString *)key
{
    [self.deallocTask addDeallocTask:deallocTask forTarget:target key:key];
}

- (void)removeDeallocTaskForTarget:(id)target key:(NSString *)key
{
    [self.deallocTask removeDeallocTaskForTarget:target key:key];
}

#pragma mark - # Getters
- (TLDeallocTask *)deallocTask
{
    TLDeallocTask *task = objc_getAssociatedObject(self, &kTask);
    if (!task) {
        task = [[TLDeallocTask alloc] init];
        objc_setAssociatedObject(self, &kTask, task, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return task;
}

@end
