//
//  TLDeallocTask.m
//  TLChat
//
//  Created by 李伯坤 on 2017/7/12.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLDeallocTask.h"

#pragma mark - ## TLDeallocTaskItem
@interface TLDeallocTaskItem : NSObject

@property (nonatomic, weak, readonly) id target;
@property (nonatomic, copy, readonly) NSString *key;
@property (nonatomic, copy, readonly) TLDeallocBlock task;

- (instancetype)initWithTarget:(id)target key:(NSString *)key task:(TLDeallocBlock)task;

@end

@implementation TLDeallocTaskItem

- (instancetype)initWithTarget:(id)target key:(NSString *)key task:(TLDeallocBlock)task
{
    self = [super init];
    if (self) {
        _target = target;
        _key = key;
        _task = [task copy];
    }
    return self;
}

- (BOOL)isEqual:(TLDeallocTaskItem *)object
{
    if (object == self) {
        return YES;
    }
    else if ([object isKindOfClass:[self class]] && [object.target isEqual:self.target] && [object.key isEqualToString:self.key]) {
        return YES;
    }
    return NO;
}

- (NSUInteger)hash
{
    return ([self.target hash] + self.key.hash) / 2;
}

@end

#pragma mark - ## TLDeallocTask
@interface TLDeallocTask ()

@property (nonatomic, strong) NSMutableSet<TLDeallocTaskItem *> *taskSet;

@end

@implementation TLDeallocTask

- (id)init
{
    if (self = [super init]) {
        self.taskSet = [[NSMutableSet alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [self.taskSet enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(TLDeallocTaskItem *obj, BOOL *stop) {
        obj.task ? obj.task() : nil;
    }];
}

#pragma mark - # Public Methods
- (void)addTask:(TLDeallocBlock)task forTarget:(id)target key:(NSString *)key
{
    TLDeallocTaskItem *taskItem = [[TLDeallocTaskItem alloc] initWithTarget:target key:key task:task];
    if ([self.taskSet containsObject:taskItem]) {
        [self.taskSet removeObject:taskItem];
    }
    [self.taskSet addObject:taskItem];
}

- (void)removeTaskForTarget:(id)target key:(NSString *)key
{
    TLDeallocTaskItem *taskItem = [[TLDeallocTaskItem alloc] initWithTarget:target key:key task:nil];
    [self.taskSet removeObject:taskItem];
}

@end
