//
//  TLSettingViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLSettingCell.h"
#import "TLSettingSwitchCell.h"
#import "TLSettingGroup.h"

#define     HEIGHT_SETTING_CELL             44.0f
#define     HEIGHT_SETTING_TOP_SPACE        15.0f
#define     HEIGHT_SETTING_BOTTOM_SPACE     12.0f

@interface TLSettingViewController : UITableViewController <TLSettingSwitchCellDelegate>

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) NSString *analyzeTitle;

@end
