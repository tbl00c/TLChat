//
//  TLExpressionMoreCell.h
//  TLChat
//
//  Created by 李伯坤 on 2017/7/21.
//  Copyright © 2017年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLExpressionGroupModel.h"

#define     WIDTH_EXPRESSION_MORE_CELL          MIN(((SCREEN_WIDTH - 15 * 4) / 3 - 1), 115)

@interface TLExpressionMoreCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) TLExpressionGroupModel *groupModel;

@end
