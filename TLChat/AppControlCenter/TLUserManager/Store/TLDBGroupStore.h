//
//  TLDBGroupStore.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/17.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLDBBaseStore.h"
#import "TLGroup.h"

@interface TLDBGroupStore : TLDBBaseStore

- (BOOL)updateGroupsData:(NSArray *)groupData
                   forUid:(NSString *)uid;

- (BOOL)addGroup:(TLGroup *)group forUid:(NSString *)uid;


- (NSMutableArray *)groupsDataByUid:(NSString *)uid;

- (BOOL)deleteGroupByGid:(NSString *)gid forUid:(NSString *)uid;

@end
