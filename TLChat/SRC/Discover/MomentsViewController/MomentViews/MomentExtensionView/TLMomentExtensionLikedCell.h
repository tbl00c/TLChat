//
//  TLMomentExtensionLikedCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/22.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLTableViewCell.h"

@interface TLMomentExtensionLikedCell : TLTableViewCell

@property (nonatomic, assign) BOOL showBottomLine;

@property (nonatomic, strong) NSArray *likedFriends;

@end
