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
 * 获取cell/view大小，与viewHeightByDataModel二选一
 * 仅 CollectionView 可选择使用
 *
 * 调用时机：添加到ZZFlexibleLayoutViewController或ZZFLEXAngel时，如实现仅调用一次后，大小会缓存在ViewModel中。
 * 其他：如需更新视图大小，需手动调用update方法
 * 小Tips：0至-1表示比例，如size.width=-0.5时，表示视图的宽度为列表宽度的50%
 */
+ (CGSize)viewSizeByDataModel:(id)dataModel;
/**
 * 获取cell/view高度，与viewSizeByDataModel二选一
 * CollectionView、TableView 均可选择使用
 *
 * 调用时机：添加到ZZFlexibleLayoutViewController或ZZFLEXAngel时，如实现仅调用一次后，高度会缓存在ViewModel中。
 * 其他：如需更新视图高度，需手动调用update方法
 * 小Tips：CollectionView也可用此方法，宽度默认为-1，即列表宽度
 */
+ (CGFloat)viewHeightByDataModel:(id)dataModel;


/**
 * 设置cell/view的数据源
 *
 * 调用时机：cellForRowAtIndexPath或者cellForItemAtIndexPath，如实现每次都会调用
 * 小Tips：如果模型未变化时不需要更新UI，建议在此方法执行时做判断直接return
 */
- (void)setViewDataModel:(id)dataModel;

/**
 * 设置cell/view的delegate对象
 *
 * 调用时机：cellForRowAtIndexPath或者cellForItemAtIndexPath，如实现每次都会调用
 */
- (void)setViewDelegate:(id)delegate;

/**
 * 设置cell/view的actionBlock
 *
 * 调用时机：cellForRowAtIndexPath或者cellForItemAtIndexPath，如实现每次都会调用
 */
- (void)setViewEventAction:(id (^)(NSInteger actionType, id data))eventAction;

/**
 * 当前视图的indexPath，所在section元素数（目前仅cell调用）
 *
 * 调用时机：cellForRowAtIndexPath或者cellForItemAtIndexPath，如实现每次都会调用
 * 小Tips：可用于UI差异化设置等，不建议cell持有indexPath，因为可能会经常变
 */
- (void)onViewPositionUpdatedWithIndexPath:(NSIndexPath *)indexPath sectionItemCount:(NSInteger)count;

@end
