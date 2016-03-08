//
//  TLFriendHelper+Contacts.h
//  TLChat
//
//  Created by libokun on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLFriendHelper.h"
#import "TLContact.h"

@interface TLFriendHelper (Contacts)

+ (void)tryToGetAllContactsSuccess:(void (^)(NSArray *data, NSArray *headers))success
                            failed:(void (^)())failed;

@end
