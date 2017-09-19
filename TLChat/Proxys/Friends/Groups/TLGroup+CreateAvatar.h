//
//  TLGroup+CreateAvatar.h
//  TLChat
//
//  Created by 李伯坤 on 2017/9/19.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import "TLGroup.h"

@interface TLGroup (CreateAvatar)

- (void)createGroupAvatarWithCompleteAction:(void (^)(NSString *groupID))completeAction;

@end
