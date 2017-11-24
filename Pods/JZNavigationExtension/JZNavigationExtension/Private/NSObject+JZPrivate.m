//
//  NSObject+JZPrivate.m
//  AFNetworking
//
//  Created by 李伯坤 on 2017/11/24.
//

#import "NSObject+JZPrivate.h"
#import <objc/runtime.h>

@interface JZDeallocTask : NSObject

- (void)addTask:(DeallocBlock)task forTarget:(id)target key:(NSString *)key;

- (void)removeTaskForTarget:(id)target key:(NSString *)key;

@end

@interface JZDeallocTaskItem : NSObject

@property (nonatomic, weak, readonly) id target;
@property (nonatomic, copy, readonly) NSString *key;
@property (nonatomic, copy, readonly) DeallocBlock task;

- (instancetype)initWithTarget:(id)target key:(NSString *)key task:(DeallocBlock)task;
+ (instancetype)taskItemWithTarget:(id)target key:(NSString *)key task:(DeallocBlock)task;

@end

@interface JZDeallocTask ()

@property (nonatomic, strong) NSMutableSet<JZDeallocTaskItem *> *taskSet;

@end


@implementation JZDeallocTask

- (void)addTask:(DeallocBlock)task forTarget:(id)target key:(NSString *)key {
    JZDeallocTaskItem *taskItem = [JZDeallocTaskItem taskItemWithTarget:target key:key task:task];
    if ([self.taskSet containsObject:taskItem]) {
        [self.taskSet removeObject:taskItem];
    }
    [self.taskSet addObject:taskItem];
}

- (void)removeTaskForTarget:(id)target key:(NSString *)key {
    JZDeallocTaskItem *taskItem = [JZDeallocTaskItem taskItemWithTarget:target key:key task:nil];
    [self.taskSet removeObject:taskItem]; // remove task with method named 'isEqual:'.
}

- (void)dealloc {
    [_taskSet enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        JZDeallocTaskItem *item = obj;
        !item.task?:item.task(); // run script to clean all weak references to 'self'.
    }];
}

- (NSMutableSet *)taskSet {
    if (!_taskSet) {
        _taskSet = [NSMutableSet set];
    }
    return _taskSet;
}

@end


@implementation JZDeallocTaskItem

- (instancetype)initWithTarget:(id)target key:(NSString *)key task:(DeallocBlock)task {
    self = [super init];
    if (self) {
        _target = target;
        _key = key;
        _task = [task copy];
    }
    return self;
}

+ (instancetype)taskItemWithTarget:(id)target key:(NSString *)key task:(DeallocBlock)task {
    return [[self alloc] initWithTarget:target key:key task:task];
}

- (BOOL)isEqual:(id)object {
    if (object == self) {
        return YES;
    } else if (![object isKindOfClass:[self class]]) {
        return NO;
    } else {
        JZDeallocTaskItem *another = (JZDeallocTaskItem *)object;
        return [another.target isEqual:self.target] && [another.key isEqualToString:self.key];
    }
}

/**
 *  瞎写一个hash来快速查找
 *
 *  @return NSUInteger
 */
- (NSUInteger)hash {
    NSObject *target = self.target;
    return (target.hash + self.key.hash) / 2;
}

@end

@implementation NSObject (JZPrivate)

static const char kTask = '0';

- (JZDeallocTask *)deallocTask {
    JZDeallocTask *task = objc_getAssociatedObject(self, &kTask);
    if (!task) {
        task = [JZDeallocTask new];
        objc_setAssociatedObject(self, &kTask, task, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return task;
}

- (void)addDeallocTask:(DeallocBlock)task forTarget:(id)target key:(NSString *)key {
    [self.deallocTask addTask:task forTarget:target key:key];
}

- (void)removeDeallocTaskForTarget:(id)target key:(NSString *)key {
    [self.deallocTask removeTaskForTarget:target key:key];
}


@end
