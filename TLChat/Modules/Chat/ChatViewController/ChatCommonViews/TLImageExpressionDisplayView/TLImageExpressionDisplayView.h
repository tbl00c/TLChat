//
//  TLImageExpressionDisplayView.h
//  TLChat
//
//  Created by 李伯坤 on 16/3/16.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLExpressionModel.h"

@interface TLImageExpressionDisplayView : UIView

@property (nonatomic, strong) TLExpressionModel *emoji;

@property (nonatomic, assign) CGRect rect;

- (void)displayEmoji:(TLExpressionModel *)emoji atRect:(CGRect)rect;

@end
