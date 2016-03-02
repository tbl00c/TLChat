//
//  TLInfoViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/26.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLInfoCell.h"
#import "TLInfoButtonCell.h"

#define     HEIGHT_INFO_CELL                44.0f
#define     HEIGHT_INFO_TOP_SPACE           15.0f
#define     HEIGHT_INFO_BOTTOM_SPACE        12.0f

@interface TLInfoViewController : UITableViewController <TLInfoButtonCellDelegate>

@property (nonatomic, strong) NSMutableArray *data;

@end
