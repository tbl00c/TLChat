//
//  TLSettingSwitchCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/10.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLSettingItem.h"

@protocol TLSettingSwitchCellDelegate <NSObject>
@optional
- (void)settingSwitchCellForItem:(TLSettingItem *)settingItem didChangeStatus:(BOOL)on;
@end

@interface TLSettingSwitchCell : UITableViewCell

@property (nonatomic, assign) id<TLSettingSwitchCellDelegate>delegate;

@property (nonatomic, strong) TLSettingItem *item;

@end
