//
//  TLChatGroupDetailViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLGroup.h"

@interface TLChatGroupDetailViewController : ZZFlexibleLayoutViewController

@property (nonatomic, strong, readonly) TLGroup *group;

- (instancetype)initWithGroupModel:(TLGroup *)groupModel;
- (instancetype)init NS_UNAVAILABLE;

@end
