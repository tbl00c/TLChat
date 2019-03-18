//
//  ZZFlexibleLayoutViewProtocol.h
//  ZZFlexibleLayoutFrameworkDemo
//
//  Created by lbk on 2016/12/27.
//  Copyright © 2016年 lbk. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 所有要加入ZZFlexibleLayoutViewController、ZZFLEXAngel的view/cell都要实现此协议
 *
 * 除获取大小/高度两个方法需要二选一之外，其余都可按需选择实现
 */

@protocol ZZFlexibleLayoutViewProtocol <NSObject>

@optional;
/**
 * 获取cell/view大小，除非手动调用update方法，否则只调用一次，与viewHeightByDataModel二选一
 */
+ (CGSize)viewSizeByDataModel:(id)dataModel;
/**
 * 获取cell/view高度，除非手动调用update方法，否则只调用一次，与viewSizeByDataModel二选一
 */
+ (CGFloat)viewHeightByDataModel:(id)dataModel;


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
