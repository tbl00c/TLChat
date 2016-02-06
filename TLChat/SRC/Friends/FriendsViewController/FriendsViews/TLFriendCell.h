//
//  TLFriendCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTableViewCell.h"

#import "TLUser.h"

@interface TLFriendCell : TLTableViewCell

/**
 *  用户信息
 */
@property (nonatomic, strong) TLUser *user;

@end
