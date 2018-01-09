//
//  TLContactsSearchResultViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/25.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLViewController.h"
#import "TLSearchResultControllerProtocol.h"

#define     HEIGHT_FRIEND_CELL      54.0f

@class TLUser;
@interface TLContactsSearchResultViewController : TLViewController <TLSearchResultControllerProtocol>

@property (nonatomic, copy) void (^itemSelectedAction)(TLContactsSearchResultViewController *searchVC, TLUser *userModel);

@end
