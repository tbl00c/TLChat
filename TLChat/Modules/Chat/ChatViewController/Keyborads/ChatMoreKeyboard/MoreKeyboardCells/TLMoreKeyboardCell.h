//
//  TLMoreKeyboardCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/2/18.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLMoreKeyboardItem.h"

@interface TLMoreKeyboardCell : UICollectionViewCell

@property (nonatomic, strong) TLMoreKeyboardItem *item;

@property (nonatomic, strong) void(^clickBlock)(TLMoreKeyboardItem *item);

@end