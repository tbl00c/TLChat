//
//  TLUserGroup.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLUser.h"

@interface TLUserGroup : NSObject

@property (nonatomic, strong) NSString *groupName;

@property (nonatomic, strong) NSMutableArray *users;

@property (nonatomic, assign, readonly) NSInteger count;

- (id) initWithGroupName:(NSString *)groupName users:(NSMutableArray *)users;

- (void)addObject:(id)anObject;

- (id)objectAtIndex:(NSUInteger)index;

@end
