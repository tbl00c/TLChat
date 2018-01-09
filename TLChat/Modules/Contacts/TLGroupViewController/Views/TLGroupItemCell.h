//
//  TLGroupItemCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/7.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLGroup.h"

@interface TLGroupItemCell : UITableViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) TLGroup *group;

@end
