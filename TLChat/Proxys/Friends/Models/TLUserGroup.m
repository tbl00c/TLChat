//
//  TLUserGroup.m
//  TLChat
//
//  Created by 李伯坤 on 16/1/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLUserGroup.h"

@implementation TLUserGroup

- (id) initWithGroupName:(NSString *)groupName users:(NSMutableArray *)users
{
    if (self = [super init]) {
        self.groupName = groupName;
        self.users = users;
    }
    return self;
}

- (NSMutableArray *) users
{
    if (_users == nil) {
        _users = [[NSMutableArray alloc] init];
    }
    return _users;
}

- (NSInteger) count
{
    return self.users.count;
}

- (void)addObject:(id)anObject
{
    [self.users addObject:anObject];
}

- (id) objectAtIndex:(NSUInteger)index
{
    return [self.users objectAtIndex:index];
}

@end
