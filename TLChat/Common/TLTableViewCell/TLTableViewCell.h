//
//  TLTableViewCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/1/23.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TLCellLineStyle) {
    TLCellLineStyleNone,
    TLCellLineStyleDefault,
    TLCellLineStyleFill,
};

@interface TLTableViewCell : UITableViewCell

@property (nonatomic, assign) CGFloat leftSeparatorSpace;

@property (nonatomic, assign) TLCellLineStyle topLineStyle;
@property (nonatomic, assign) TLCellLineStyle bottomLineStyle;

@end
