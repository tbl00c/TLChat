//
//  TLMyExpressionCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/12.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLExpressionGroupModel.h"

@protocol TLMyExpressionCellDelegate <NSObject>

- (void)myExpressionCellDeleteButtonDown:(TLExpressionGroupModel *)group;

@end

@interface TLMyExpressionCell : UITableViewCell

@property (nonatomic, assign) id<TLMyExpressionCellDelegate>delegate;

@property (nonatomic, strong) TLExpressionGroupModel *group;

@end
