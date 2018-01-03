//
//  TLExpressionItemCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLExpressionModel.h"

#define         EXP_DETAIL_EDGE                 20.0
#define         EXP_DETAIL_SPACE                15.0
#define         EXP_DETAIL_CELL_WIDTH           ((SCREEN_WIDTH - EXP_DETAIL_EDGE * 2 - EXP_DETAIL_SPACE * 3.0) / 4.0)

@interface TLExpressionItemCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) TLExpressionModel *emoji;

@end
