//
//  TLUserGroupCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/6.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TLUserGroupCellDelegate <NSObject>

- (void)userGroupCellDidSelectUser:(TLUser *)user;

- (void)userGroupCellAddUserButtonDown;

@end

@interface TLUserGroupCell : UITableViewCell

@property (nonatomic, assign) id<TLUserGroupCellDelegate>delegate;

@property (nonatomic, strong) NSMutableArray *users;


@end
