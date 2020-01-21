//
//  TLExpressionDetailViewController.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/8.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLViewController.h"

@class TLExpressionGroupModel;
@interface TLExpressionDetailViewController : ZZFlexibleLayoutViewController

@property (nonatomic, strong, readonly) TLExpressionGroupModel *groupModel;

- (id)initWithGroupModel:(TLExpressionGroupModel *)groupModel;

@end
