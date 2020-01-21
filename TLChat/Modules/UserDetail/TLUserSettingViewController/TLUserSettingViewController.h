//
//  TLUserSettingViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLUser;
@interface TLUserSettingViewController : ZZFlexibleLayoutViewController

@property (nonatomic, strong, readonly) TLUser *userModel;

- (instancetype)initWithUserModel:(TLUser *)userModel;
- (instancetype)init  __attribute__((unavailable("请使用 initWithUserModel:")));

@end
