//
//  ZZFlexibleLayoutViewProtocol.h
//  ZZFlexibleLayoutFrameworkDemo
//
//  Created by 李伯坤 on 2016/12/27.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 所有要加入ZZFlexibleLayoutViewController的view/cell都要实现此协议
 */

@protocol ZZFlexibleLayoutViewProtocol <NSObject>

@required;
/**
 * 获取cell/view大小，必须实现
 */
+ (CGSize)viewSizeByDataModel:(id)dataModel;

@optional;
/**
 *  设置cell/view的数据源
 */
- (void)setViewDataModel:(id)dataModel;

/**
 *  设置cell/view的delegate对象
 */
- (void)setViewDelegate:(id)delegate;

/**
 *  设置cell/view的actionBlock
 */
- (void)setViewEventAction:(id (^)(NSInteger actionType, id data))eventAction;

/**
 * 当前视图的indexPath，所在section元素数（目前仅cell调用）
 */
- (void)viewIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count;


@end
