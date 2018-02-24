//
//  ZZFlexibleLayoutSeperatorCell.h
//  ZZFlexibleLayoutFrameworkDemo
//
//  Created by 李伯坤 on 2016/12/27.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZFlexibleLayoutViewProtocol.h"

#pragma mark - # ZZFlexibleLayoutSeperatorModel
@interface ZZFlexibleLayoutSeperatorModel : NSObject

@property (nonatomic, assign) CGSize size;

@property (nonatomic, strong) UIColor *color;

- (id)initWithSize:(CGSize)size andColor:(UIColor *)color;

@end


#pragma mark - # ZZFlexibleLayoutSeperatorCell
@interface ZZFlexibleLayoutSeperatorCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) ZZFlexibleLayoutSeperatorModel *model;

@end
