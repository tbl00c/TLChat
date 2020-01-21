//
//  TLChatDetailViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLUser.h"

@interface TLChatDetailViewController : ZZFlexibleLayoutViewController

@property (nonatomic, strong, readonly) TLUser *user;

- (instancetype)initWithUserModel:(TLUser *)user;
- (instancetype)init NS_UNAVAILABLE;

@end
