//
//  TLUserGroupItemCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLUserGroupItemCell : UICollectionViewCell

@property (nonatomic, strong) TLUser *user;

@property (nonatomic, strong) void (^clickBlock)(TLUser *user);

@end
