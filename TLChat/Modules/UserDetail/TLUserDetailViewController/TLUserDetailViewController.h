//
//  TLUserDetailViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLUser;
@interface TLUserDetailViewController : ZZFlexibleLayoutViewController

- (instancetype)initWithUserId:(NSString *)userId;
- (instancetype)initWithUserModel:(TLUser *)userModel;
- (instancetype)init  __attribute__((unavailable("请使用 initWithUserId: 或 initWithUserModel:")));

@end
