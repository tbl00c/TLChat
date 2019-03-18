//
//  ZZFlexibleLayoutViewModel.h
//  ZZFlexibleLayoutFrameworkDemo
//
//  Created by lbk on 2016/12/27.
//  Copyright © 2016年 lbk. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 仅框架内部使用
 *
 * 是对dataModel的一层封装
 * 实际给cell\view传递的仍然是dataModel
 */
@interface ZZFlexibleLayoutViewModel : NSObject

/// view/cell类名
@property (nonatomic, strong) NSString *className;
/// view/cell类
@property (nonatomic, assign, readonly) Class viewClass;

/// view/cell的数据Model
@property (nonatomic, strong) id dataModel;

/// view/cell的大小（用户设置值，只读、从dataModel中获取）
@property (nonatomic, assign, readonly) CGSize viewSize;

@property (nonatomic, assign) NSInteger viewTag;

/// view/cell中的事件
@property (nonatomic, copy) id (^eventAction)(NSInteger actionType, id data);

/// 业务方指定的代理，默认nil
@property (nonatomic, copy) id delegate;

/// cell选中事件
@property (nonatomic, copy) void (^selectedAction)(id data);

/// cell配置事件
@property (nonatomic, copy) void (^configAction)(__kindof UIView *itemView, id dataModel);

/**
 *  根据类名和数据源初始化viewModel
 */
- (id)initWithClassName:(NSString *)className andDataModel:(id)dataModel;
- (id)initWithClassName:(NSString *)className andDataModel:(id)dataModel viewTag:(NSInteger)viewTag;

/**
 *  重新计算视图高度
 */
- (void)updateViewHeight;

@end
