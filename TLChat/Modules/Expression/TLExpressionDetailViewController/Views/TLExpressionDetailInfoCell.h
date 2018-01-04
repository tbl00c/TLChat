//
//  TLExpressionDetailInfoCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/11.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLExpressionGroupModel.h"

#define         HEIGHT_EXP_BANNER       (SCREEN_WIDTH * 0.45)

@interface TLExpressionDetailInfoCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) TLExpressionGroupModel *groupModel;

@end
