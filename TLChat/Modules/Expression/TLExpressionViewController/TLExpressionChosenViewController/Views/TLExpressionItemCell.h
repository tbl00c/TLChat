//
//  TLExpressionItemCell.h
//  TLChat
//
//  Created by 李伯坤 on 16/4/4.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLExpressionGroupModel;
@interface TLExpressionItemCell : UITableViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) TLExpressionGroupModel *groupModel;

@end
